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
  runApp(const MaterialApp(home: HVFMasterGate(), debugShowCheckedModeBanner: false));
}

class HVFMasterGate extends StatefulWidget {
  const HVFMasterGate({super.key});
  @override
  State<HVFMasterGate> createState() => _HVFMasterGateState();
}

class _HVFMasterGateState extends State<HVFMasterGate> {
  String view = "GATE";
  String? buyerSession;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; buyerSession = null; })) : null,
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (view) {
      case "PRODUCER": return _producerTheater();
      case "BUYER": return _buyerTheater();
      case "CEO": return _ceoTheater();
      default: return _gateTheater();
    }
  }

  Widget _gateTheater() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.shield, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 40),
      _cmdBtn("CEO COMMAND", () => _pinAccess("CEO", "1978")),
      _cmdBtn("PRODUCER DECK", () => _pinAccess("PRODUCER", "2026")),
      _cmdBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
    ]));
  }

  void _pinAccess(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () { if (c.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }

  Widget _cmdBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(280, 60)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold))
    ),
  );

  // PRODUCER: ALWAYS SHOWS FORM, REGARDLESS OF DB STATUS
  Widget _producerTheater() {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE")),
        const SizedBox(height: 10),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
          if(n.text.isNotEmpty) {
            _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'status': 'AVAILABLE'});
            n.clear(); v.clear(); p.clear();
          }
        }, child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
      ])),
      const Padding(padding: EdgeInsets.all(10), child: Text("LOCAL MONITOR", style: TextStyle(color: Colors.white24))),
      Expanded(child: _listStream(_db.collection('enterprise_ledger').snapshots()))
    ]);
  }

  // BUYER: SHOWS LOGIN FIRST, THEN LIST
  Widget _buyerTheater() {
    final b = TextEditingController();
    if (buyerSession == null) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("MARKET ACCESS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20)),
        const SizedBox(height: 20),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "Enter ID"))),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => buyerSession = b.text), child: const Text("ENTER"))
      ]));
    }
    return Column(children: [
      ListTile(title: Text("SESSION: $buyerSession", style: const TextStyle(color: Colors.green))),
      Expanded(child: _listStream(_db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots()))
    ]);
  }

  // CEO: MASTER VIEW
  Widget _ceoTheater() {
    return Column(children: [
      const Padding(padding: EdgeInsets.all(20), child: Text("MASTER AUDIT LOG", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18))),
      Expanded(child: _listStream(_db.collection('enterprise_ledger').snapshots()))
    ]);
  }

  // UNIVERSAL LIST BUILDER: PREVENTS GREY SCREEN HANGS
  Widget _listStream(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snap) {
        if (snap.hasError) return const Center(child: Text("CONNECTION TIMEOUT", style: TextStyle(color: Colors.red)));
        if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA RECORDED", style: TextStyle(color: Colors.white24)));
        
        return ListView(children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return Card(
            color: const Color(0xFF1A1A1A),
            child: ListTile(
              title: Text(data['name'] ?? "Asset", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("STATUS: ${data['status']}", style: const TextStyle(color: Colors.white38)),
              trailing: view == "CEO" ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) : null,
            ),
          );
        }).toList());
      },
    );
  }
}
