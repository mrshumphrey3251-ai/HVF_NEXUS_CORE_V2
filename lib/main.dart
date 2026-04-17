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
  runApp(const MaterialApp(home: HVFVerifiedCore(), debugShowCheckedModeBanner: false));
}

class HVFVerifiedCore extends StatefulWidget {
  const HVFVerifiedCore({super.key});
  @override
  State<HVFVerifiedCore> createState() => _HVFVerifiedCoreState();
}

class _HVFVerifiedCoreState extends State<HVFVerifiedCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  String selectedRole = "PRODUCER"; // DEFAULT ROLE
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // SYSTEM CONTROLLERS
  final nC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();
  final fsaC = TextEditingController();
  final taxC = TextEditingController();
  final yrC = TextEditingController(); 
  final cityC = TextEditingController();
  final statsC = TextEditingController();
  final goalC = TextEditingController();
  bool isAda = false;

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; })),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "REGISTER": return _onboarding();
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT": return _agentTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth()),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
      _gateBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  Widget _onboarding() {
    return Row(children: [
      Expanded(child: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white10))),
        child: ListView(controller: _legalScroll, children: const [
          Text("MASTER SERVICE AGREEMENT v11.1.0\n\nARTICLE I: SOVEREIGNTY\nAll data is Proprietary/Trade Secret.\n\nARTICLE II: COMPLIANCE\nMinimum 24 months operation required.\n\nSCROLL TO UNLOCK...", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 1200),
          Text("MANDATE READY.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        ]),
      )),
      Expanded(child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedRole, isExpanded: true, style: const TextStyle(color: Color(0xFFC5A059)),
            items: ["PRODUCER", "BUYER", "AGENT"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => selectedRole = v!),
          ),
          TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
          TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "TAX ID")),
          TextField(controller: yrC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OP")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: canAccept ? () => _submitAudit() : null, child: const Text("SUBMIT AUDIT")),
        ]),
      )),
    ]);
  }

  void _submitAudit() async {
    String uid = "HVF-${Random().nextInt(9999)}-${selectedRole[0]}";
    String pin = (1000 + Random().nextInt(8999)).toString();
    await _db.collection('vetted_participants').add({'name': nC.text, 'uid': uid, 'pin': pin, 'role': selectedRole, 'yrs': yrC.text});
    _showSuccess(uid, pin);
  }

  void _showSuccess(String u, String p) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("AUDIT PASSED", style: TextStyle(color: Colors.green)),
      content: Text("UID: $u\nPIN: $p"),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("DONE"))],
    ));
  }

  // --- MINIMAL WRAPPERS FOR VERIFICATION ---
  Widget _producerTerminal() => const Center(child: Text("PRODUCER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _buyerTerminal() => const Center(child: Text("BUYER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _agentTerminal() => const Center(child: Text("AGENT ACTIVE", style: TextStyle(color: Colors.white)));

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSETS"), Tab(text: "LEDGER")]),
      Expanded(child: TabBarView(children: [
        _streamList('sovereign_ledger'),
        _streamList('vetted_participants'),
      ])),
    ]));
  }

  Widget _streamList(String col) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection(col).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['name'] ?? 'USER', style: const TextStyle(color: Colors.white)))).toList());
      },
    );
  }

  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CEO ACCESS"),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("VALIDATE"),
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

  Widget _gateBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
