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
        // SEARCHING PRIMARY LEDGER
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          
          final docs = snap.hasData ? snap.data!.docs : [];
          
          if (view == "PRODUCER") return _producer(docs);
          if (view == "BUYER") return _buyer(docs);
          if (view == "CEO") return _ceo(docs);
          return _gate(docs.length);
        },
      ),
    );
  }

  Widget _gate(int count) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 20),
      Text("SIGNAL: ${count > 0 ? 'ACTIVE ($count Assets)' : 'NO DATA IN LEDGER'}", style: TextStyle(color: count > 0 ? Colors.green : Colors.red, fontSize: 12)),
      const SizedBox(height: 40),
      _b("CEO COMMAND", () => _authorize("CEO", "1978")),
      _b("PRODUCER DECK", () => _authorize("PRODUCER", "2026")),
      _b("BUYER MARKET", () => setState(() => view = "BUYER")),
    ]));
  }

  Widget _b(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(280, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
  );

  Widget _producer(List<QueryDocumentSnapshot> docs) {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        const Text("NEW ASSET UPLINK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FMV")),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {
          if (n.text.isNotEmpty) {
            _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'status': 'AVAILABLE'});
            n.clear(); v.clear(); p.clear();
          }
        }, child: const Text("FORCE UPLINK"))
      ])),
      const Divider(color: Color(0xFFC5A059)),
      const Text("CURRENT LIVE INVENTORY", style: TextStyle(color: Colors.white38, fontSize: 10)),
      Expanded(child: ListView(children: docs.map((d) => ListTile(title: Text(d['name'] ?? "Unnamed", style: const TextStyle(color: Colors.white)))).toList()))
    ]);
  }

  Widget _buyer(List<QueryDocumentSnapshot> docs) {
    final b = TextEditingController();
    if (buyerSession == null) return Center(child: Column(children: [
      const SizedBox(height: 50),
      const Text("ENTER BUYER CREDENTIALS", style: TextStyle(color: Colors.white)),
      SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
      ElevatedButton(onPressed: () => setState(() => buyerSession = b.text), child: const Text("ENTER MARKET"))
    ]));
    
    final available = docs.where((d) => d['status'] == 'AVAILABLE').toList();
    return ListView(children: [
      ListTile(title: Text("BUYER: $buyerSession", style: const TextStyle(color: Colors.green))),
      if (available.isEmpty) const Center(child: Text("NO ASSETS AVAILABLE FOR PURCHASE", style: TextStyle(color: Colors.white24))),
      ...available.map((d) => Card(
        color: const Color(0xFF1A1A1A),
        child: ListTile(
          title: Text(d['name'] ?? "Asset", style: const TextStyle(color: Colors.white)),
          subtitle: Text("FMV: \$${d['price']}"),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'CLAIMED', 'buyer': buyerSession}), child: const Text("SECURE")),
        ),
      )).toList()
    ]);
  }

  Widget _ceo(List<QueryDocumentSnapshot> docs) {
    return Column(children: [
      const Padding(padding: EdgeInsets.all(10), child: Text("MASTER AUDIT: ALL DATA POINTS", style: TextStyle(color: Colors.white38))),
      Expanded(child: ListView(children: docs.map((d) => ListTile(
        title: Text(d['name'] ?? "No Name", style: const TextStyle(color: Colors.white)),
        subtitle: Text("STATUS: ${d['status']}"),
        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
      )).toList())),
    ]);
  }
}
