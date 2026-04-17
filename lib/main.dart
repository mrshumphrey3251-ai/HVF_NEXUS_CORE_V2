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
  runApp(const MaterialApp(home: HVFFinalityCore(), debugShowCheckedModeBanner: false));
}

class HVFFinalityCore extends StatefulWidget {
  const HVFFinalityCore({super.key});
  @override
  State<HVFFinalityCore> createState() => _HVFFinalityCoreState();
}

class _HVFFinalityCoreState extends State<HVFFinalityCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // PRODUCER CONTROLLERS
  final nC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();
  final fsaC = TextEditingController();
  final taxC = TextEditingController();
  bool isAda = false;
  bool isBio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
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
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth()),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
    ]));
  }

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

  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("INDUSTRIAL UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: r"VALUATION ($)")),
      TextField(controller: dC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE")),
      TextField(controller: fsaC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA NUMBER")),
      TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "TAX ID")),
      CheckboxListTile(title: const Text("ADA COMPLIANT", style: TextStyle(color: Colors.white70)), value: isAda, onChanged: (v)=>setState(()=>isAda=v!), activeColor: const Color(0xFFC5A059)),
      CheckboxListTile(title: const Text("BIOSECURITY MET", style: TextStyle(color: Colors.white70)), value: isBio, onChanged: (v)=>setState(()=>isBio=v!), activeColor: const Color(0xFFC5A059)),
      ElevatedButton(onPressed: () {
        _db.collection('sovereign_ledger').add({'name': nC.text, 'price': pC.text, 'details': dC.text, 'fsa': fsaC.text, 'tax': taxC.text, 'ada': isAda, 'bio': isBio, 'status': 'PENDING_SORTER', 'producer': sessionUID});
        nC.clear(); pC.clear(); dC.clear(); fsaC.clear(); taxC.clear();
      }, child: const Text("UPLINK"))
    ]));
  }

  Widget _buyerTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "PORTFOLIO")]),
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
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
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
        return ListView(children: snap.data!.docs.map((d) {
          final tC = TextEditingController();
          return Card(color: const Color(0xFF0D0D0D), child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white)),
            subtitle: TextField(controller: tC, style: const TextStyle(color: Colors.white24, fontSize: 10), decoration: const InputDecoration(hintText: "UPLINK DOC LINK")),
            trailing: IconButton(icon: const Icon(Icons.upload, color: Color(0xFFC5A059)), onPressed: () => d.reference.update({'docs': tC.text, 'status': 'DOCS_UPLOADED'})),
          ));
        }).toList());
      },
    );
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "SORTER"), Tab(text: "LEDGER")]),
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
          subtitle: Text("ID: ${d['uid']} | PIN: ${d['pin']}", style: const TextStyle(color: Color(0xFFC5A059))),
        )).toList());
      },
    );
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
