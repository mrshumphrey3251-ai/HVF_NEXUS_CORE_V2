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
  runApp(const MaterialApp(home: HVFMasterNexus(), debugShowCheckedModeBanner: false));
}

class HVFMasterNexus extends StatefulWidget {
  const HVFMasterNexus({super.key});
  @override
  State<HVFMasterNexus> createState() => _HVFMasterNexusState();
}

class _HVFMasterNexusState extends State<HVFMasterNexus> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  bool msaAccepted = false;
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController(); // Name
  final pC = TextEditingController(); // Price
  final fC = TextEditingController(); // FSA
  final lC = TextEditingController(); // Link

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
        actions: const [Center(child: Text("5 USC 552(B)(4) SECURED   ", style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "REGISTER": return _onboardingGate();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 8)),
      const SizedBox(height: 60),
      _cmdBtn("EXECUTIVE COMMAND", () => _ceoLogin()),
      _cmdBtn("SECURE ENTRY (UID/PIN)", () => _vettedLogin()),
      _cmdBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- PRODUCER TERMINAL ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 25),
      _input(nC, "ASSET NAME"),
      _input(pC, "VALUATION (\$)"),
      _input(fC, "FSA FARM NUMBER"),
      _input(lC, "MEDIA LINK (PHOTO/DOC)"),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': pC.text, 'fsa': fC.text, 'media': lC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'shield': '5_USC_552_B4'
          });
          nC.clear(); pC.clear(); fC.clear(); lC.clear();
        },
        child: const Text("UPLINK TO LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  // --- BUYER TERMINAL ---
  Widget _buyerTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY ASSETS")]),
      Expanded(child: TabBarView(children: [
        _queryLedger('LIVE'),
        _queryLedger('SECURED', portfolio: true),
      ])),
    ]));
  }

  Widget _queryLedger(String stat, {bool portfolio = false}) {
    Query q = _db.collection('sovereign_ledger').where('status', isEqualTo: stat);
    if (portfolio) q = q.where('buyer_id', isEqualTo: sessionUID);
    return StreamBuilder<QuerySnapshot>(
      stream: q.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("\$${d['price']}"),
            trailing: stat == 'LIVE' 
              ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")) 
              : const Icon(Icons.verified, color: Colors.green),
          ),
        )).toList());
      },
    );
  }

  // --- CEO TERMINAL ---
  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa']} | Media: ${d['media']}"),
          trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  // --- ONBOARDING WITH MSA ---
  Widget _onboardingGate() {
    final t = TextEditingController();
    String r = "PRODUCER";
    return Column(children: [
      if (!msaAccepted) Expanded(child: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("MASTER SERVICE AGREEMENT\n\nSection 1: Trade Secrets\nAll information shared within Humphrey Virtual Farms is protected under 5 U.S.C. § 552(b)(4)...\n\nSCROLL TO ACCEPT", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 800),
        ElevatedButton(onPressed: () => setState(() => msaAccepted = true), child: const Text("I ACCEPT TERMS"))
      ])),
      if (msaAccepted) Padding(padding: const EdgeInsets.all(30), child: Column(children: [
        DropdownButton<String>(value: r, dropdownColor: Colors.black, items: ["PRODUCER", "BUYER"].map((e)=>DropdownMenuItem(value:e, child:Text(e, style:const TextStyle(color:Colors.white)))).toList(), onChanged: (v)=>setState(()=>r=v!)),
        _input(t, "FULL NAME"),
        ElevatedButton(onPressed: () async {
          String uid = "HVF-${Random().nextInt(9999)}";
          await _db.collection('vetted_participants').add({'name': t.text, 'uid': uid, 'pin': "1234", 'role': r});
          setState(() { view = "GATE"; msaAccepted = false; });
        }, child: const Text("GENERATE COMMISSION CREDENTIALS"))
      ])),
    ]);
  }

  void _ceoLogin() {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("CEO ACCESS"), content: TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white)), actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = "CEO"; activeRole = "CEO"; }); } }, child: const Text("ACCESS"))]));
  }

  void _vettedLogin() {
    TextEditingController u = TextEditingController();
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("VALIDATE"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: u, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")), TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN"))]), actions: [ElevatedButton(onPressed: () async {
      var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get();
      if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) {
        Navigator.pop(context);
        setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; });
      }
    }, child: const Text("LOGIN"))]));
  }

  Widget _input(TextEditingController c, String l) => Padding(padding: const EdgeInsets.only(bottom: 15), child: TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white24))));
  Widget _cmdBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
