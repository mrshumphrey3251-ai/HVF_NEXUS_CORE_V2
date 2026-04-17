import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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
  runApp(const MaterialApp(home: HVFMasterSystem(), debugShowCheckedModeBanner: false));
}

class HVFMasterSystem extends StatefulWidget {
  const HVFMasterSystem({super.key});
  @override
  State<HVFMasterSystem> createState() => _HVFMasterSystemState();
}

class _HVFMasterSystemState extends State<HVFMasterSystem> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  final nC = TextEditingController();
  final pC = TextEditingController();
  final fC = TextEditingController();
  final lC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
        actions: const [Center(child: Text("5 USC 552(B)(4) SECURED   ", style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)))],
      ),
      body: _buildView(),
      bottomNavigationBar: view == "GATE" ? null : Container(
        color: Colors.black, padding: const EdgeInsets.all(10),
        child: const Text("MATTHEW 25:41–46 (KJV)", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFC5A059), fontSize: 9, fontStyle: FontStyle.italic)),
      ),
    );
  }

  Widget _buildView() {
    switch (view) {
      case "CEO": return _ceo();
      case "PRODUCER": return _producer();
      case "BUYER": return _buyer();
      case "REGISTER": return _reg();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 120),
      const Text("HVF NEXUS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 12)),
      const SizedBox(height: 60),
      _btn("EXECUTIVE COMMAND", () => _auth("CEO")),
      _btn("SECURE ENTRY", () => _login()),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  Widget _producer() {
    return SingleChildScrollView(padding: const EdgeInsets.all(35), child: Column(children: [
      _field(nC, "ASSET NAME"), _field(pC, "VALUATION (\$)"), _field(fC, "FSA #"), _field(lC, "MEDIA LINK"),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () {
        _db.collection('sovereign_ledger').add({'name': nC.text, 'price': pC.text, 'fsa': fC.text, 'media': lC.text, 'status': 'PENDING', 'producer': sessionUID});
        nC.clear(); pC.clear(); fC.clear(); lC.clear();
      }, child: const Text("UPLINK"))
    ]));
  }

  Widget _buyer() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('buyer_id', isEqualTo: sessionUID).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)), subtitle: Text("\$${d['price']}"))).toList());
      },
    );
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)), trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})))).toList());
      },
    );
  }

  Widget _reg() {
    final t = TextEditingController(); String r = "PRODUCER";
    return Center(child: Column(children: [
      const Text("REGISTRATION", style: TextStyle(color: Colors.white)),
      TextField(controller: t, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
      ElevatedButton(onPressed: () async {
        String uid = "HVF-${Random().nextInt(9999)}";
        await _db.collection('vetted_participants').add({'name': t.text, 'uid': uid, 'pin': "1234", 'role': r});
        setState(() => view = "GATE");
      }, child: const Text("REGISTER"))
    ]));
  }

  void _auth(String r) {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(title: const Text("PIN"), content: TextField(controller: p), actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = r; activeRole = r; }); } }, child: const Text("ENTER"))]));
  }

  void _login() {
    TextEditingController u = TextEditingController(); TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: u, decoration: const InputDecoration(hintText: "UID")), TextField(controller: p, decoration: const InputDecoration(hintText: "PIN"))]), actions: [ElevatedButton(onPressed: () async {
      var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get();
      if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) { Navigator.pop(context); setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; }); }
    }, child: const Text("LOGIN"))]));
  }

  Widget _field(TextEditingController c, String l) => TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white54)));
  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(10), child: OutlinedButton(onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059)))));
}
