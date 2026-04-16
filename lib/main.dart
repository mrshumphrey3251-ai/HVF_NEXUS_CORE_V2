import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
      authDomain: "hvf-nexus.firebaseapp.com",
      projectId: "hvf-nexus",
      storageBucket: "hvf-nexus.firebasestorage.app",
      messagingSenderId: "892263251736",
      appId: "1:892263251736:web:899cc6ab03f6f5e9d8286d",
    ),
  );
  runApp(const MaterialApp(home: HVFNexusFinal(), debugShowCheckedModeBanner: false));
}

class HVFNexusFinal extends StatefulWidget {
  const HVFNexusFinal({super.key});
  @override
  State<HVFNexusFinal> createState() => _HVFNexusFinalState();
}

class _HVFNexusFinalState extends State<HVFNexusFinal> {
  String view = "GATE";
  String? buyerSession;
  final _db = FirebaseFirestore.instance;

  void _authorize(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("LOGIN: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () { if (c.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        actions: [if(view != "GATE") IconButton(icon: const Icon(Icons.logout, color: Colors.red), onPressed: () => setState(() => view = "GATE"))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final allDocs = snap.data!.docs;
          
          if (view == "PRODUCER") return _producer(allDocs);
          if (view == "BUYER") return _buyer(allDocs);
          if (view == "CEO") return _ceo(allDocs);
          if (view == "LOGISTICS") return _logistics(allDocs);
          return _gate();
        },
      ),
    );
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _b("CEO COMMAND", () => _authorize("CEO", "1978")),
      _b("PRODUCER DECK", () => _authorize("PRODUCER", "2026")),
      _b("BUYER MARKET", () => setState(() => view = "BUYER")),
      GestureDetector(onLongPress: () => _authorize("LOGISTICS", "1776"), child: Container(height: 40, width: 200, color: Colors.transparent))
    ]));
  }

  Widget _b(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(280, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
  );

  Widget _producer(List<DocumentSnapshot> docs) {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET ID")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITAL DATA")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FMV")),
        ElevatedButton(onPressed: () {
          _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'status': 'AVAILABLE'});
          n.clear(); v.clear(); p.clear();
        }, child: const Text("UPLINK"))
      ])),
      Expanded(child: ListView(children: docs.where((d) => d['status'] == 'AVAILABLE').map((d) => ListTile(title: Text(d['name'], style: const TextStyle(color: Colors.white)))).toList()))
    ]);
  }

  Widget _buyer(List<DocumentSnapshot> docs) {
    final b = TextEditingController();
    if (buyerSession == null) return Center(child: Column(children: [
      const SizedBox(height: 50),
      TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "Enter Buyer ID")),
      ElevatedButton(onPressed: () => setState(() => buyerSession = b.text), child: const Text("ENTER MARKET"))
    ]));
    return ListView(children: [
      ListTile(title: Text("BUYER: $buyerSession", style: const TextStyle(color: Colors.green))),
      ...docs.where((d) => d['status'] == 'AVAILABLE').map((d) => ListTile(
        title: Text(d['name'], style: const TextStyle(color: Colors.white)),
        subtitle: Text("FMV: \$${d['price']}"),
        trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'CLAIMED', 'buyer': buyerSession}), child: const Text("SECURE")),
      )).toList()
    ]);
  }

  Widget _ceo(List<DocumentSnapshot> docs) {
    return ListView(children: docs.map((d) => ListTile(
      title: Text(d['name'], style: const TextStyle(color: Colors.white)),
      subtitle: Text("STATUS: ${d['status']}"),
      trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
    )).toList());
  }

  Widget _logistics(List<DocumentSnapshot> docs) {
    return ListView(children: docs.where((d) => d['status'] == 'CLAIMED').map((d) => ListTile(
      title: Text(d['name'], style: const TextStyle(color: Colors.white)),
      subtitle: Text("FOR: ${d['buyer']}"),
      trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'DONE'}), child: const Text("COMPLETE")),
    )).toList());
  }
}
