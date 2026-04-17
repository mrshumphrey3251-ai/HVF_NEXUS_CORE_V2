// V14.2.0: THE OPEN-GATE BUILD
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
  runApp(const MaterialApp(home: HVFOpenGate(), debugShowCheckedModeBanner: false));
}

class HVFOpenGate extends StatefulWidget {
  const HVFOpenGate({super.key});
  @override
  State<HVFOpenGate> createState() => _HVFOpenGateState();
}

class _HVFOpenGateState extends State<HVFOpenGate> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;
  final ScrollController _scroll = ScrollController();
  bool canSubmit = false;

  // Controllers
  final nC = TextEditingController();
  final yC = TextEditingController();
  String selectedRole = "BUYER";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        leading: IconButton(icon: const Icon(Icons.logout), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    switch (view) {
      case "CEO": return _ceo();
      case "REGISTER": return _register();
      case "BUYER": return _buyer();
      case "PRODUCER": return _producer();
      default: return _gate();
    }
  }

  // --- THE FIXED GATE: ALL DOORS RESTORED ---
  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5)),
      const SizedBox(height: 40),
      _btn("EXECUTIVE COMMAND", () => _pinAuth()), // DOOR A
      _btn("SECURE ENTRY (UID/PIN)", () => _loginDialog()), // DOOR B
      const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text("OR", style: TextStyle(color: Colors.white24))),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")), // DOOR C
    ]));
  }

  // --- REGISTRATION FLOW (FOR BUYERS) ---
  Widget _register() {
    return Column(children: [
      Expanded(child: ListView(controller: _scroll, padding: const EdgeInsets.all(20), children: [
        const Text("MASTER SERVICE AGREEMENT\n\nSection 1: Trade Secrets\nAll data is protected under 5 USC 552(b)(4)...\n\nSCROLL TO ACCEPT", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 1000),
        const Text("END OF AGREEMENT.", style: TextStyle(color: Color(0xFFC5A059))),
        ElevatedButton(onPressed: () => setState(() => canSubmit = true), child: const Text("I ACCEPT TERMS"))
      ])),
      if (canSubmit) Container(
        color: Colors.black, padding: const EdgeInsets.all(20),
        child: Column(children: [
          DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedRole,
            items: ["BUYER", "PRODUCER", "AGENT"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(),
            onChanged: (v) => setState(() => selectedRole = v!),
          ),
          TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
          TextField(controller: yC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OP")),
          ElevatedButton(onPressed: _submitReg, child: const Text("GENERATE CREDENTIALS"))
        ]),
      )
    ]);
  }

  void _submitReg() async {
    String uid = "HVF-${Random().nextInt(9999)}";
    String pin = (1000 + Random().nextInt(8999)).toString();
    await _db.collection('vetted_participants').add({'name': nC.text, 'uid': uid, 'pin': pin, 'role': selectedRole, 'status': 'VETTED'});
    _showCreds(uid, pin);
  }

  void _showCreds(String u, String p) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("CREDENTIALS ISSUED", style: TextStyle(color: Colors.green)),
      content: Text("UID: $u\nPIN: $p", style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("DONE"))],
    ));
  }

  // --- AUTH LOGIC ---
  void _pinAuth() {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("CEO ACCESS"),
      content: TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = "CEO"; activeRole = "CEO"; }); } }, child: const Text("ENTER"))],
    ));
  }

  void _loginDialog() {
    TextEditingController u = TextEditingController();
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("VALIDATE"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: u, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")),
        TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN")),
      ]),
      actions: [ElevatedButton(onPressed: () async {
        var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get();
        if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) {
          Navigator.pop(context);
          setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; });
        }
      }, child: const Text("LOGIN"))],
    ));
  }

  // --- PLACEHOLDERS ---
  Widget _ceo() => const Center(child: Text("CEO COMMAND DECK ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _buyer() => const Center(child: Text("BUYER MARKET ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _producer() => const Center(child: Text("PRODUCER UPLINK ACTIVE", style: TextStyle(color: Colors.white)));

  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(350, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059)))));
}
