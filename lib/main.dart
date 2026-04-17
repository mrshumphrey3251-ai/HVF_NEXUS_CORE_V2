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
  runApp(const MaterialApp(home: HVFOverwatchV84(), debugShowCheckedModeBanner: false));
}

class HVFOverwatchV84 extends StatefulWidget {
  const HVFOverwatchV84({super.key});
  @override
  State<HVFOverwatchV84> createState() => _HVFOverwatchV84State();
}

class _HVFOverwatchV84State extends State<HVFOverwatchV84> {
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
        elevation: 2,
        title: Text("HVF COMMAND | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; })
        ),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
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
      const SizedBox(height: 10),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth()),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
      _gateBtn("REQUEST COMMISSION", () => _registerRedirect()),
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

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSET SORTER"), Tab(text: "VETTED LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetReview(),
        _ceoLidView(), // RE-STABILIZED
      ])),
    ]));
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'] ?? "UNNAMED ASSET", style: const TextStyle(color: Colors.white)),
            subtitle: Text("\$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
            trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
          ),
        )).toList());
      },
    );
  }

  Widget _ceoLidView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA", style: TextStyle(color: Colors.white24)));

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, index) {
            final data = snap.data!.docs[index].data() as Map<String, dynamic>?;
            if (data == null) return const SizedBox();

            // NULL-SAFETY GAUNTLET: Ensures no field crashes the UI
            String name = data['name'] ?? "LEGACY USER";
            String uid = data['uid'] ?? "NO-UID";
            String pin = data['pin'] ?? "****";
            String role = data['role'] ?? "UNKNOWN";
            String shield = data['foia_exemption'] ?? "STANDARD";

            return Card(
              color: const Color(0xFF0D0D0D),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("ID: $uid | PIN: $pin | SHIELD: $shield", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
                trailing: Text(role, style: const TextStyle(color: Colors.white24, fontSize: 10)),
              ),
            );
          },
        );
      },
    );
  }

  // TERMINAL WRAPPERS
  Widget _producerTerminal() => const Center(child: Text("PRODUCER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _buyerTerminal() => const Center(child: Text("BUYER ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _agentTerminal() => const Center(child: Text("AGENT ACTIVE", style: TextStyle(color: Colors.white)));
  
  void _registerRedirect() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("REGISTRATION PORTAL UNDER MAINTENANCE")));

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );
}
