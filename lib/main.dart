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
  runApp(const MaterialApp(home: HVFRedTeamSafe(), debugShowCheckedModeBanner: false));
}

class HVFRedTeamSafe extends StatefulWidget {
  const HVFRedTeamSafe({super.key});
  @override
  State<HVFRedTeamSafe> createState() => _HVFRedTeamSafeState();
}

class _HVFRedTeamSafeState extends State<HVFRedTeamSafe> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF HARDENED | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; })),
        actions: const [Center(child: Text("5 USC 552(B)(4) SHIELD ACTIVE   ", style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildCurrentModule(),
    );
  }

  Widget _buildCurrentModule() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "REGISTER": return _gatedRegistration();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _btn("EXECUTIVE COMMAND", () => _ceoAuth()),
      _btn("SECURE ENTRY (UID/PIN)", () => _vettedLogin()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("ENCRYPTED ACCESS ONLY", style: TextStyle(color: Colors.white10, fontSize: 8))),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- REGISTRATION WITH QUARANTINE LOGIC ---
  Widget _gatedRegistration() {
    final nC = TextEditingController();
    final yC = TextEditingController();
    return Center(child: Container(
      width: 350, padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("STEWARDSHIP AUDIT", style: TextStyle(color: Color(0xFFC5A059))),
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
        TextField(controller: yC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OP")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () async {
          int yrs = int.tryParse(yC.text) ?? 0;
          String status = yrs >= 2 ? "VETTED" : "QUARANTINE";
          String uid = "HVF-${Random().nextInt(9999)}";
          String pin = (1000 + Random().nextInt(8999)).toString();
          await _db.collection('vetted_participants').add({
            'name': nC.text, 'uid': uid, 'pin': pin, 'role': 'PRODUCER', 
            'status': status, 'shield': '5_USC_552_B4'
          });
          _showResult(uid, pin, status);
        }, child: const Text("SUBMIT"))
      ]),
    ));
  }

  void _showResult(String u, String p, String s) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: Text(s == "VETTED" ? "PASSED" : "FLAGGED", style: TextStyle(color: s == "VETTED" ? Colors.green : Colors.red)),
      content: Text("UID: $u\nPIN: $p\nStatus: $s"),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("DONE"))],
    ));
  }

  // --- CEO: EXECUTIVE COMMAND ---
  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSETS"), Tab(text: "SECURITY LEDGER")]),
      Expanded(child: TabBarView(children: [
        _streamView('sovereign_ledger'),
        _streamView('vetted_participants'),
      ])),
    ]));
  }

  Widget _streamView(String col) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection(col).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ITEM', style: const TextStyle(color: Colors.white)),
          subtitle: Text("STATUS: ${d['status'] ?? 'PENDING'}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        )).toList());
      },
    );
  }

  // --- LOGIN LOGIC ---
  void _ceoAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("CEO ACCESS"),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _vettedLogin() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("VALIDATE"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: idC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")),
        TextField(controller: pinC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN")),
      ]),
      actions: [ElevatedButton(onPressed: () async {
        var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: idC.text).get();
        if (snap.docs.isNotEmpty && snap.docs.first['pin'] == pinC.text) {
          if (snap.docs.first['status'] == "QUARANTINE") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ACCOUNT UNDER REVIEW")));
          } else {
            setState(() { sessionUID = idC.text; activeRole = snap.docs.first['role']; view = activeRole; });
            Navigator.pop(context);
          }
        }
      }, child: const Text("LOGIN"))],
    ));
  }

  Widget _producerTerminal() => const Center(child: Text("PRODUCER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _buyerTerminal() => const Center(child: Text("BUYER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
