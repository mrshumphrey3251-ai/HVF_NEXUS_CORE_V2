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
  runApp(const MaterialApp(home: HVFTotalRecovery(), debugShowCheckedModeBanner: false));
}

class HVFTotalRecovery extends StatefulWidget {
  const HVFTotalRecovery({super.key});
  @override
  State<HVFTotalRecovery> createState() => _HVFTotalRecoveryState();
}

class _HVFTotalRecoveryState extends State<HVFTotalRecovery> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // SYSTEM CONTROLLERS
  final nC = TextEditingController(); // Name
  final pC = TextEditingController(); // Price
  final dC = TextEditingController(); // Details
  final fsaC = TextEditingController(); // FSA Number
  final taxC = TextEditingController(); // Tax ID
  final yrC = TextEditingController(); // Years in Op
  final docC = TextEditingController(); // Doc Link
  final cityC = TextEditingController(); // Tour City
  final goalC = TextEditingController(); // Tour Goal
  bool isAda = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole | $sessionUID", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
        actions: const [Center(child: Text("STATUTORY PROTECTION: 5 USC 552(B)(4)   ", style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildActiveTheater(),
    );
  }

  Widget _buildActiveTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT": return _agentTerminal();
      case "REGISTER": return _gatedOnboarding();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _btn("EXECUTIVE COMMAND", () => _pinAuth()),
      _btn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("RE-ESTABLISHING UPLINK...", style: TextStyle(color: Colors.white10, fontSize: 8))),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- REGISTRATION: THE QUARANTINE GATE ---
  Widget _gatedOnboarding() {
    return Center(child: Container(
      width: 400, padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("STEWARDSHIP AUDIT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "LEGAL NAME")),
        TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "TAX ID")),
        TextField(controller: yrC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OPERATION")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () async {
          int yrs = int.tryParse(yrC.text) ?? 0;
          String status = yrs >= 2 ? "VETTED" : "QUARANTINE";
          String uid = "HVF-${Random().nextInt(9999)}";
          String pin = (1000 + Random().nextInt(8999)).toString();
          await _db.collection('vetted_participants').add({'name': nC.text, 'uid': uid, 'pin': pin, 'role': 'PRODUCER', 'status': status});
          _showResult(uid, pin, status);
        }, child: const Text("SUBMIT FOR AUDIT")),
      ]),
    ));
  }

  // --- PRODUCER: INDUSTRIAL UPLINK ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION")),
      TextField(controller: dC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE")),
      TextField(controller: fsaC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA NUMBER")),
      CheckboxListTile(title: const Text("ADA COMPLIANT", style: TextStyle(color: Colors.white70)), value: isAda, onChanged: (v)=>setState(()=>isAda=v!), activeColor: const Color(0xFFC5A059)),
      ElevatedButton(onPressed: () {
        _db.collection('sovereign_ledger').add({'name': nC.text, 'price': pC.text, 'details': dC.text, 'fsa': fsaC.text, 'status': 'PENDING_SORTER', 'producer': sessionUID, 'shield': '5_USC_552_B4'});
        nC.clear(); pC.clear(); dC.clear(); fsaC.clear();
      }, child: const Text("UPLINK"))
    ]));
  }

  // --- BUYER: MARKET & PORTFOLIO ---
  Widget _buyerTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY PORTFOLIO")]),
      Expanded(child: TabBarView(children: [
        _buyerMarket(),
        _buyerPortfolio(),
      ])),
    ]));
  }

  Widget _buyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")),
        )).toList());
      },
    );
  }

  Widget _buyerPortfolio() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('buyer_id', isEqualTo: sessionUID).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'] ?? 'SECURED', style: const TextStyle(color: Colors.white)),
            subtitle: TextField(controller: docC, style: const TextStyle(color: Colors.white24, fontSize: 10), decoration: const InputDecoration(hintText: "UPLINK DOC LINK")),
            trailing: IconButton(icon: const Icon(Icons.upload, color: Color(0xFFC5A059)), onPressed: () => d.reference.update({'docs': docC.text})),
          ),
        )).toList());
      },
    );
  }

  // --- AGENT: TOUR TICKER ---
  Widget _agentTerminal() {
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), child: const Text("RESIDUALS: 10% ACTIVE", style: TextStyle(color: Colors.green))),
      TextField(controller: cityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY")),
      TextField(controller: goalC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "GOAL")),
      ElevatedButton(onPressed: () {
        _db.collection('tour_calendar').add({'city': cityC.text, 'goal': goalC.text, 'status': 'PROPOSED', 'agent': sessionUID});
        cityC.clear(); goalC.clear();
      }, child: const Text("SUBMIT NODE")),
    ]);
  }

  // --- CEO: EXECUTIVE COMMAND ---
  Widget _ceoTerminal() {
    return DefaultTabController(length: 3, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "SORTER"), Tab(text: "TOUR"), Tab(text: "LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetReview(),
        _ceoTourReview(),
        _ceoLedgerView(),
      ])),
    ]));
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoTourReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['city'] ?? 'CITY', style: const TextStyle(color: Colors.white)),
          trailing: IconButton(icon: const Icon(Icons.bolt, color: Colors.green), onPressed: () => d.reference.update({'status': 'ACTIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLedgerView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'USER', style: const TextStyle(color: Colors.white)),
          subtitle: Text("ID: ${d['uid']} | PIN: ${d['pin']} | STATUS: ${d['status']}"),
        )).toList());
      },
    );
  }

  // --- AUTH LOGIC ---
  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("CEO PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
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

  void _showResult(String u, String p, String s) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: Text(s == "VETTED" ? "PASSED" : "FLAGGED", style: TextStyle(color: s == "VETTED" ? Colors.green : Colors.red)),
      content: Text("UID: $u\nPIN: $p"),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("DONE"))],
    ));
  }

  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
