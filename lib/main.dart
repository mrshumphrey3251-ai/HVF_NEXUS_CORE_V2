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
  runApp(const MaterialApp(home: HVFStressTest(), debugShowCheckedModeBanner: false));
}

class HVFStressTest extends StatefulWidget {
  const HVFStressTest({super.key});
  @override
  State<HVFStressTest> createState() => _HVFStressTestState();
}

class _HVFStressTestState extends State<HVFStressTest> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController();
  final pC = TextEditingController();
  final fsaC = TextEditingController();
  final yrC = TextEditingController();

  // VALIDATION STATE
  bool get isHardened => nC.text.isNotEmpty && pC.text.isNotEmpty && fsaC.text.isNotEmpty && (int.tryParse(yrC.text) ?? 0) >= 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF STRESS TEST | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.security, color: Colors.red), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
        actions: const [Center(child: Text("HARDENED BY DEFAULT   ", style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _btn("EXECUTIVE COMMAND", () => _pinAuth()),
      _btn("SECURE ENTRY (UID/PIN)", () => _login()),
    ]));
  }

  // --- THE STRESS TEST: PRODUCER UPLINK ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("PRODUCER AUDIT UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextField(controller: nC, onChanged: (v) => setState((){}), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, onChanged: (v) => setState((){}), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION")),
      TextField(controller: fsaC, onChanged: (v) => setState((){}), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA NUMBER")),
      TextField(controller: yrC, onChanged: (v) => setState((){}), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OPERATION")),
      const SizedBox(height: 30),
      // THE LOCK: Only enables if all SME requirements are met
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: isHardened ? const Color(0xFFC5A059) : Colors.white10),
        onPressed: isHardened ? () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': pC.text, 'fsa': fsaC.text, 'yrs': yrC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'shield': '5_USC_552_B4'
          });
          nC.clear(); pC.clear(); fsaC.clear(); yrC.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("AUDIT PASSED: ASSET UPLINKED")));
        } : null, 
        child: Text(isHardened ? "SUBMIT TO LEDGER" : "AUDIT FAILED: INCOMPLETE DATA", style: const TextStyle(fontWeight: FontWeight.bold))
      ),
    ]));
  }

  // --- CEO & BUYER REMAINS LOCKED ---
  Widget _buyerTerminal() => const Center(child: Text("BUYER TERMINAL: SECURE", style: TextStyle(color: Colors.white)));
  Widget _ceoTerminal() => const Center(child: Text("EXECUTIVE COMMAND: ACTIVE", style: TextStyle(color: Colors.white)));

  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("CEO PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _login() {
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
          setState(() { sessionUID = idC.text; activeRole = snap.docs.first['role']; view = activeRole; });
          Navigator.pop(context);
        }
      }, child: const Text("LOGIN"))],
    ));
  }

  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
