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
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController(); // Name/Asset
  final pC = TextEditingController(); // Valuation
  final fsaC = TextEditingController(); // FSA
  final yrC = TextEditingController(); // Years
  final docC = TextEditingController(); // Vault Docs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole | $sessionUID", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
        actions: const [Center(child: Text("5 USC 552(B)(4) SHIELD ACTIVE   ", style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "CEO": return _ceoDeck();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerExchange();
      case "AGENT": return _agentTicker();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 8)),
      const SizedBox(height: 60),
      _cmdBtn("EXECUTIVE COMMAND (CEO)", () => _ceoAuth()),
      _cmdBtn("SECURE ENTRY (UID/PIN)", () => _vettedLogin()),
      const SizedBox(height: 30),
      const Text("MISSION STATUS: 95% COMPLETE - COMMISSIONING PHASE", style: TextStyle(color: Colors.white24, fontSize: 8, letterSpacing: 2)),
    ]));
  }

  // --- THE RED TEAM PRODUCER TERMINAL ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
      const SizedBox(height: 25),
      _input(nC, "ASSET NAME / UNIT ID"),
      _input(pC, "VALUATION (\$)"),
      _input(fsaC, "FSA FARM NUMBER"),
      _input(yrC, "YEARS IN OPERATION"),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': pC.text, 'fsa': fsaC.text, 'yrs': yrC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'shield': '5_USC_552_B4',
            'timestamp': FieldValue.serverTimestamp()
          });
          nC.clear(); pC.clear(); fsaC.clear(); yrC.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SECURED: AWAITING CEO GREEN-LIGHT")));
        }, 
        child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      ),
    ]));
  }

  // --- THE BUYER EXCHANGE ---
  Widget _buyerExchange() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("PRICE: \$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")),
          ),
        )).toList());
      },
    );
  }

  // --- THE CEO COMMAND DECK ---
  Widget _ceoDeck() {
    return DefaultTabController(length: 3, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "SORTER"), Tab(text: "TOUR"), Tab(text: "LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetSorter(),
        const Center(child: Text("40-CITY TOUR TICKER: ACTIVE", style: TextStyle(color: Colors.white24))),
        _ceoLedger(),
      ])),
    ]));
  }

  Widget _ceoAssetSorter() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa']} | YRS: ${d['yrs']}"),
          trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLedger() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'USER', style: const TextStyle(color: Colors.white)),
          subtitle: Text("UID: ${d['uid']} | PIN: ${d['pin']} | ROLE: ${d['role']}"),
        )).toList());
      },
    );
  }

  // --- AUTHENTICATION ---
  void _ceoAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("EXECUTIVE ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter PIN")),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _vettedLogin() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("VALIDATE CREDENTIALS"),
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

  // --- HELPERS ---
  Widget _input(TextEditingController c, String l) => Padding(padding: const EdgeInsets.only(bottom: 15), child: TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white38), enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)))));
  Widget _cmdBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(400, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))));
  Widget _agentTicker() => const Center(child: Text("AGENT TICKER: PENDING DATA", style: TextStyle(color: Colors.white)));
}
