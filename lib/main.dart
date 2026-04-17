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
  runApp(const MaterialApp(home: HVFOverwatchV82(), debugShowCheckedModeBanner: false));
}

class HVFOverwatchV82 extends StatefulWidget {
  const HVFOverwatchV82({super.key});
  @override
  State<HVFOverwatchV82> createState() => _HVFOverwatchV82State();
}

class _HVFOverwatchV82State extends State<HVFOverwatchV82> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      // GLOBAL NAV: SHIELD ICON IS NOW THE PERMANENT EXIT
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF COMMAND | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })
        ),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "REGISTER": return _registrationPortal();
      case "PRODUCER": return _producerUplink();
      case "BUYER": return _buyerExchange();
      case "AGENT": return _agentMissionControl();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 10),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _idPinLoginPrompt()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
      _gateBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("EXECUTIVE PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == pin) { setState(() { view = target; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _idPinLoginPrompt() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CREDENTIAL VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
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
      }, child: const Text("VALIDATE"))],
    ));
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSET SORTER"), Tab(text: "VETTED LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetSorter(),
        _ceoLidView(), // REBUILT FOR NULL-SAFETY
      ])),
    ]));
  }

  Widget _ceoAssetSorter() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (snap.data!.docs.isEmpty) return const Center(child: Text("SORTER CLEAR", style: TextStyle(color: Colors.white24)));
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
        // PREVENTS THE GREY SCREEN BY HANDLING EMPTY/LOADING STATES
        if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO VETTED PARTICIPANTS FOUND", style: TextStyle(color: Colors.white24)));
        
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return Card(
            color: const Color(0xFF0D0D0D),
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(data['name'] ?? "UNKNOWN", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("ID: ${data['uid']} | PIN: ${data['pin']} | ROLE: ${data['role']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
              trailing: const Icon(Icons.verified, color: Colors.green, size: 16),
            ),
          );
        }).toList());
      },
    );
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  // PLACEHOLDERS TO PREVENT ERRORS
  Widget _producerUplink() => const Center(child: Text("PRODUCER TERMINAL", style: TextStyle(color: Colors.white)));
  Widget _buyerExchange() => const Center(child: Text("BUYER EXCHANGE", style: TextStyle(color: Colors.white)));
  Widget _agentMissionControl() => const Center(child: Text("AGENT MISSION CONTROL", style: TextStyle(color: Colors.white)));
  Widget _registrationPortal() => const Center(child: Text("REGISTRATION PORTAL", style: TextStyle(color: Colors.white)));
  Widget _nexusAuditLoading() => const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
}
