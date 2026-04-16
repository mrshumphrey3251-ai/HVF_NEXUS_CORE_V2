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
  runApp(const MaterialApp(home: HVFCore(), debugShowCheckedModeBanner: false));
}

class HVFCore extends StatefulWidget {
  const HVFCore({super.key});
  @override
  State<HVFCore> createState() => _HVFCoreState();
}

class _HVFCoreState extends State<HVFCore> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  String? buyer;
  final _db = FirebaseFirestore.instance;

  void _gateAccess(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("LOGIN: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () {
            if (c.text == pin) { setState(() => view = target); Navigator.pop(context); }
          }, child: const Text("SUBMIT"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("HVF NEXUS", style: TextStyle(color: Color(0xFFC5A059)))),
      body: _body(),
    );
  }

  Widget _body() {
    if (view == "PRODUCER") return _producer();
    if (view == "BUYER") return _buyer();
    if (view == "CEO") return _ceo();
    if (view == "LOGISTICS") return _logistics();
    return _gate();
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _b("CEO OVERSIGHT", () => _gateAccess("CEO", "1978")),
      _b("PRODUCER DECK", () => _gateAccess("PRODUCER", "2026")),
      _b("BUYER MARKET", () => setState(() => view = "BUYER")),
      GestureDetector(onLongPress: () => _gateAccess("LOGISTICS", "1776"), child: Container(height: 50, width: 200, color: Colors.transparent)),
    ]));
  }

  Widget _b(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(250, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
  );

  Widget _producer() {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return Column(children: [
      Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        DropdownButton<String>(
          value: sector, dropdownColor: Colors.black, style: const TextStyle(color: Colors.white),
          items: ["LIVESTOCK", "CROPS", "FLEET"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (val) => setState(() => sector = val!),
        ),
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FMV")),
        ElevatedButton(onPressed: () {
          _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'status': 'AVAILABLE', 'sector': sector});
          n.clear(); v.clear(); p.clear();
        }, child: const Text("UPLINK"))
      ])),
      IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() => view = "GATE"))
    ]);
  }

  Widget _buyer() {
    final b = TextEditingController();
    if (buyer == null) return Center(child: Column(children: [
      TextField(controller: b, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "BUYER ID")),
      ElevatedButton(onPressed: () => setState(() => buyer = b.text), child: const Text("LOGIN"))
    ]));
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: [
          ListTile(title: Text("BUYER: $buyer", style: const TextStyle(color: Colors.green)), trailing: IconButton(icon: const Icon(Icons.logout), onPressed: () => setState(() => buyer = null))),
          ...snap.data!.docs.map((d) => ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white)),
            subtitle: Text("FMV: \$${d['price']}"),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'CLAIMED', 'owner': buyer}), child: const Text("SECURE")),
          )).toList()
        ]);
      }
    );
  }

  Widget _logistics() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'CLAIMED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("OWNER: ${d['owner']}"),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'DONE'}), child: const Text("COMPLETE")),
        )).toList());
      }
    );
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: [
          IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() => view = "GATE")),
          ...snap.data!.docs.map((d) => ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white)),
            subtitle: Text("STATUS: ${d['status']}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
          )).toList()
        ]);
      }
    );
  }
}
