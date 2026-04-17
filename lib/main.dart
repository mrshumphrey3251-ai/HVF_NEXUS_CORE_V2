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
  runApp(const MaterialApp(home: HVFFullStreamCore(), debugShowCheckedModeBanner: false));
}

class HVFFullStreamCore extends StatefulWidget {
  const HVFFullStreamCore({super.key});
  @override
  State<HVFFullStreamCore> createState() => _HVFFullStreamCoreState();
}

class _HVFFullStreamCoreState extends State<HVFFullStreamCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Controllers for Data Entry
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
        title: Text("HVF NEXUS | $activeRole | $sessionUID", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), 
          onPressed: () { setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; }); }
        ),
      ),
      body: _buildActiveTerminal(),
    );
  }

  Widget _buildActiveTerminal() {
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
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth()),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
      _gateBtn("REQUEST COMMISSION", () => _registrationPlaceholder()),
    ]));
  }

  // --- LOGIC: AUTHENTICATION ---
  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CEO PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("VALIDATE CREDENTIALS", style: TextStyle(color: Color(0xFFC5A059))),
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

  // --- THE TAIL: PRODUCER TERMINAL ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION")),
      TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE/DETAILS")),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': double.tryParse(pC.text) ?? 0, 'details': dC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'timestamp': FieldValue.serverTimestamp()
          });
          nC.clear(); pC.clear(); dC.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("VAULTED FOR CEO REVIEW")));
        }, child: const Text("UPLINK ASSET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ]));
  }

  // --- THE TAIL: BUYER EXCHANGE ---
  Widget _buyerTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        if (snap.data!.docs.isEmpty) return const Center(child: Text("MARKET EMPTY", style: TextStyle(color: Colors.white24)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("\$${d['price']} | ${d['details']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': sessionUID}), child: const Text("SECURE")),
          ),
        )).toList());
      },
    );
  }

  // --- THE TAIL: AGENT CONTROL ---
  Widget _agentTerminal() {
    return Column(children: [
      Container(padding: const EdgeInsets.all(25), color: const Color(0xFF0A0A0A), width: double.infinity, child: Column(children: [
        const Text("ESTIMATED RESIDUALS", style: TextStyle(color: Colors.white38, fontSize: 10)),
        const Text("\$2,450.00", style: TextStyle(color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold)),
      ])),
      const Expanded(child: Center(child: Text("40-CITY TOUR TICKER ACTIVE", style: TextStyle(color: Colors.white24)))),
    ]);
  }

  // --- THE TAIL: CEO OVERWATCH ---
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
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("\$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
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
          title: Text(d['name'] ?? "UNKNOWN", style: const TextStyle(color: Colors.white)),
          subtitle: Text("ID: ${d['uid']} | PIN: ${d['pin']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        )).toList());
      },
    );
  }

  void _registrationPlaceholder() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("REGISTRATION PORTAL ENCRYPTED")));
  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(8),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );
}
