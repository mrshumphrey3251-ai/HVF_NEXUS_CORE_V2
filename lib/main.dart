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
  runApp(const MaterialApp(home: HVFIntegrityCore(), debugShowCheckedModeBanner: false));
}

class HVFIntegrityCore extends StatefulWidget {
  const HVFIntegrityCore({super.key});
  @override
  State<HVFIntegrityCore> createState() => _HVFIntegrityCoreState();
}

class _HVFIntegrityCoreState extends State<HVFIntegrityCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        title: Text("HVF COMMAND | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; })
        ),
      ),
      body: _buildActiveTheater(),
    );
  }

  Widget _buildActiveTheater() {
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
      const SizedBox(height: 10),
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
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter PIN")),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("LOGIN", style: TextStyle(color: Color(0xFFC5A059))),
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

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSET SORTER"), Tab(text: "VETTED LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetReview(),
        _ceoLidViewStabilized(),
      ])),
    ]));
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? "ASSET", style: const TextStyle(color: Colors.white)),
          trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLidViewStabilized() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO VETTED DATA", style: TextStyle(color: Colors.white24)));

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, index) {
            var data = snap.data!.docs[index].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF0D0D0D),
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(data['name'] ?? "UNKNOWN", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("ID: ${data['uid']} | PIN: ${data['pin']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
                trailing: Text(data['role'] ?? "N/A", style: const TextStyle(color: Colors.white24, fontSize: 10)),
              ),
            );
          },
        );
      },
    );
  }

  Widget _producerTerminal() => SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
    const Text("UPLINK NEW ASSET", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
    TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
    TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE")),
    TextField(controller: dC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "DETAILS")),
    const SizedBox(height: 20),
    ElevatedButton(onPressed: () {
      _db.collection('sovereign_ledger').add({'name': nC.text, 'price': double.tryParse(pC.text) ?? 0, 'details': dC.text, 'status': 'PENDING_SORTER'});
      nC.clear(); pC.clear(); dC.clear();
    }, child: const Text("UPLINK"))
  ]));

  Widget _buyerTerminal() => const Center(child: Text("BUYER EXCHANGE ACTIVE", style: TextStyle(color: Colors.white)));

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(8),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );
}
