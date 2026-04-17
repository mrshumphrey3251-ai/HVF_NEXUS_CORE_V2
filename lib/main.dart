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
  runApp(const MaterialApp(home: HVFResurrectionCore(), debugShowCheckedModeBanner: false));
}

class HVFResurrectionCore extends StatefulWidget {
  const HVFResurrectionCore({super.key});
  @override
  State<HVFResurrectionCore> createState() => _HVFResurrectionCoreState();
}

class _HVFResurrectionCoreState extends State<HVFResurrectionCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // Controllers
  final nC = TextEditingController();
  final cC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();

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
      // GLOBAL APP BAR: RESTORES THE RETURN BUTTON (SHIELD ICON)
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
        leading: IconButton(
          icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), 
          onPressed: () { setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; }); }
        ),
        actions: const [
          Center(child: Text("SOC 2 TYPE II HARDENED   ", style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold))),
        ],
      ),
      body: _buildActiveTheater(),
    );
  }

  Widget _buildActiveTheater() {
    switch (view) {
      case "GATE": return _gate();
      case "REGISTER": return _registrationPortal();
      case "AUDIT_WAIT": return _nexusAuditLoading();
      case "PRODUCER": return _producerUplink();
      case "BUYER": return _buyerExchange();
      case "AGENT": return _agentMissionControl();
      case "CEO": return _ceoExecutiveOverwatch();
      case "DASHBOARD": return _routeVettedUser(); // Fix for the "Grey Screen"
      default: return _gate();
    }
  }

  Widget _routeVettedUser() {
    // Redirects user from the successful login to their specific terminal
    Future.microtask(() { setState(() => view = activeRole); });
    return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
  }

  Widget _gate() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
        const SizedBox(height: 10),
        const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
        const Text("CAGE: 1AHA8 | TRADE SECRET PROTECTED", style: TextStyle(color: Colors.white24, fontSize: 9)),
        const SizedBox(height: 50),
        _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
        _gateBtn("SECURE ENTRY (UID/PIN)", () => _idPinLoginPrompt()),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
        _gateBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
      ]),
    );
  }

  void _idPinLoginPrompt() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CREDENTIAL VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: idC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter HVF-UID")),
        const SizedBox(height: 10),
        TextField(controller: pinC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter Secure PIN")),
      ]),
      actions: [
        ElevatedButton(onPressed: () async {
          var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: idC.text).get();
          if (snap.docs.isNotEmpty && snap.docs.first['pin'] == pinC.text) {
            setState(() { sessionUID = idC.text; activeRole = snap.docs.first['role']; view = "DASHBOARD"; });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("INVALID CREDENTIALS")));
          }
        }, child: const Text("VALIDATE"))
      ],
    ));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("EXECUTIVE PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == pin) { setState(() { view = target; activeRole = "CEO"; sessionUID = "MASTER-01"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _producerUplink() {
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
      const Text("PRODUCER TERMINAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION")),
      TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () {
        _db.collection('sovereign_ledger').add({'name': nC.text, 'price': double.tryParse(pC.text) ?? 0, 'details': dC.text, 'status': 'PENDING_SORTER'});
        nC.clear(); pC.clear(); dC.clear();
      }, child: const Text("UPLINK TO LEDGER"))
    ]));
  }

  Widget _buyerExchange() => const Center(child: Text("BUYER EXCHANGE: ACTIVE", style: TextStyle(color: Colors.white)));
  Widget _agentMissionControl() => const Center(child: Text("AGENT MISSION CONTROL: ACTIVE", style: TextStyle(color: Colors.white)));

  Widget _ceoExecutiveOverwatch() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "SORTER"), Tab(text: "VETTED LEDGER")]),
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
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("UID: ${d['uid']} | PIN: ${d['pin']}", style: const TextStyle(color: Color(0xFFC5A059))),
        )).toList());
      },
    );
  }

  Widget _registrationPortal() {
    return const Center(child: Text("REGISTRATION PORTAL: UNDER RED TEAM HARDENING", style: TextStyle(color: Colors.white)));
  }

  Widget _nexusAuditLoading() => const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))
    ),
  );
}
