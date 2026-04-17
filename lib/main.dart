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
  runApp(const MaterialApp(home: HVFIndustrialCore(), debugShowCheckedModeBanner: false));
}

class HVFIndustrialCore extends StatefulWidget {
  const HVFIndustrialCore({super.key});
  @override
  State<HVFIndustrialCore> createState() => _HVFIndustrialCoreState();
}

class _HVFIndustrialCoreState extends State<HVFIndustrialCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // PRODUCER UPLINK CONTROLLERS
  final nC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();
  final fsaC = TextEditingController(); // FSA Number
  final taxC = TextEditingController(); // Tax ID
  bool isAdaCompliant = false;
  bool bioProtocolMet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerExchange();
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
    ]));
  }

  // --- AUTHENTICATION ---
  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CEO ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("VALIDATE", style: TextStyle(color: Color(0xFFC5A059))),
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

  // --- REFINED PRODUCER TERMINAL ---
  Widget _producerTerminal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("PRODUCER INDUSTRIAL UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 25),
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME / UNIT ID")),
        TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION ($)")),
        TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE / TECHNICAL SPECS")),
        const Divider(color: Colors.white10, height: 40),
        const Text("FEDERAL & STEWARDSHIP IDENTIFIERS", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
        TextField(controller: fsaC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA FARM NUMBER")),
        TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AG TAX ID")),
        const SizedBox(height: 20),
        CheckboxListTile(
          title: const Text("ADA ACCESSIBILITY COMPLIANT", style: TextStyle(color: Colors.white70, fontSize: 12)),
          value: isAdaCompliant,
          onChanged: (v) => setState(() => isAdaCompliant = v!),
          activeColor: const Color(0xFFC5A059),
        ),
        CheckboxListTile(
          title: const Text("BIOSECURITY PROTOCOLS ADHERED", style: TextStyle(color: Colors.white70, fontSize: 12)),
          value: bioProtocolMet,
          onChanged: (v) => setState(() => bioProtocolMet = v!),
          activeColor: const Color(0xFFC5A059),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            _db.collection('sovereign_ledger').add({
              'name': nC.text, 'price': double.tryParse(pC.text) ?? 0, 'details': dC.text,
              'fsa_number': fsaC.text, 'tax_id': taxC.text, 'ada_compliant': isAdaCompliant,
              'biosecurity': bioProtocolMet, 'status': 'PENDING_SORTER', 'producer_id': sessionUID,
              'foia_exemption': '5_USC_552_B4', 'timestamp': FieldValue.serverTimestamp()
            });
            nC.clear(); pC.clear(); dC.clear(); fsaC.clear(); taxC.clear();
            setState(() { isAdaCompliant = false; bioProtocolMet = false; });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET VAULTED FOR CEO AUDIT")));
          }, 
          child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        ),
      ]),
    );
  }

  // --- OTHER TERMINALS ---
  Widget _buyerExchange() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("Price: \$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': sessionUID}), child: const Text("SECURE")),
          ),
        )).toList());
      },
    );
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSET SORTER"), Tab(text: "VETTED LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetReview(),
        _ceoLidView(),
      ])),
    ]));
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa_number'] ?? 'N/A'}", style: const TextStyle(color: Colors.white24, fontSize: 10)),
          trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLidView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? "USER", style: const TextStyle(color: Colors.white)),
          subtitle: Text("ID: ${d['uid']}", style: const TextStyle(color: Color(0xFFC5A059))),
        )).toList());
      },
    );
  }

  Widget _agentTerminal() => const Center(child: Text("AGENT TERMINAL: ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _gateBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
