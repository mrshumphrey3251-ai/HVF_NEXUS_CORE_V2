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
  runApp(const MaterialApp(home: HVFJustificationCore(), debugShowCheckedModeBanner: false));
}

class HVFJustificationCore extends StatefulWidget {
  const HVFJustificationCore({super.key});
  @override
  State<HVFJustificationCore> createState() => _HVFJustificationCoreState();
}

class _HVFJustificationCoreState extends State<HVFJustificationCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // AGENT INTELLIGENCE CONTROLLERS
  final cityC = TextEditingController();
  final dateC = TextEditingController();
  final statsC = TextEditingController(); // REGIONAL STATISTICS
  final goalC = TextEditingController();  // JUSTIFIED GOAL
  final potentialC = TextEditingController(); // KEY POTENTIALS

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  void _confirmDeletion(BuildContext context, VoidCallback onConfirm) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: const Text("PERMANENT DELETION?", style: TextStyle(color: Colors.red, fontSize: 12)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(onPressed: () { onConfirm(); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("DELETE")),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!hasAcceptedTerms) return _marshalFederalGate();
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        leading: IconButton(icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")),
      ),
      body: _buildTheater(),
    );
  }

  Widget _marshalFederalGate() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 80),
          const SizedBox(height: 10),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const Text("UEI: S1M4ENLHTDH5 | CAGE: REGISTERED", style: TextStyle(color: Colors.white38, fontSize: 10, fontFamily: 'Courier')),
          const SizedBox(height: 20),
          Expanded(child: Container(
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.2))),
            child: ListView(controller: _legalScroll, padding: const EdgeInsets.all(25), children: const [
              Text("MASTER SERVICE AGREEMENT v7.0.0\n\n"
              "ARTICLE I: STRATEGIC JUSTIFICATION\nNo tour node shall be scheduled without regional statistics and a justified economic goal.\n\n"
              "ARTICLE II: DATA INTEGRITY\nAll intelligence reports submitted by agents are the proprietary property of HVF LLC.\n\n"
              "--- SCROLL TO EXECUTE ---", 
              style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.8, fontFamily: 'Courier')),
              SizedBox(height: 1800),
            ]),
          )),
          const SizedBox(height: 20),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            child: Container(
              height: 60, width: double.infinity,
              color: canAccept ? const Color(0xFFC5A059) : Colors.white10,
              alignment: Alignment.center,
              child: Text("EXECUTE MANDATE", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "AGENT": return _agentStrategicTerminal();
      case "CEO": return _ceoExecutiveOverwatch();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("AGENT STRATEGIC TERMINAL", () => _agentLogin()),
    ]));
  }

  void _agentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: aID, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { setState(() { agentID = aID.text; view = "AGENT"; }); Navigator.pop(context); }, child: const Text("ACCESS"))],
    ));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pinController = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pinController, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pinController.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(320, 75)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _agentStrategicTerminal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF0A0A0A), border: Border.all(color: Colors.white10)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("INTELLIGENCE REPORT: NEW TOUR NODE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 15),
            TextField(controller: cityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY/STATE")),
            TextField(controller: dateC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PROPOSED DATE")),
            TextField(controller: statsC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "REGIONAL STATISTICS (Vets, Ag Density, etc)")),
            TextField(controller: goalC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "JUSTIFIED ECONOMIC GOAL")),
            TextField(controller: potentialC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "KEY POTENTIALS / STAKEHOLDERS")),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                if (cityC.text.isNotEmpty && statsC.text.isNotEmpty) {
                  _db.collection('tour_calendar').add({
                    'agent_id': agentID, 'city': cityC.text, 'date': dateC.text, 'stats': statsC.text,
                    'goal': goalC.text, 'potentials': potentialC.text, 'status': 'PROPOSED', 'timestamp': FieldValue.serverTimestamp()
                  });
                  cityC.clear(); dateC.clear(); statsC.clear(); goalC.clear(); potentialC.clear();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("STRATEGIC REPORT SUBMITTED")));
                }
              }, 
              child: const Text("SUBMIT FOR CEO AUDIT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
            ),
          ]),
        ),
        const SizedBox(height: 20),
        SizedBox(height: 300, child: StreamBuilder<QuerySnapshot>(
          stream: _db.collection('tour_calendar').where('agent_id', isEqualTo: agentID).snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const LinearProgressIndicator();
            return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['city'], style: const TextStyle(color: Colors.white)), subtitle: Text(d['status'], style: const TextStyle(color: Colors.white38)))).toList());
          },
        ))
      ]),
    );
  }

  Widget _ceoExecutiveOverwatch() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "STRATEGIC AUDIT"), Tab(text: "ACTIVE TIMELINE")]),
      Expanded(child: TabBarView(children: [
        _ceoAuditView(),
        _ceoActiveTimeline(),
      ])),
    ]));
  }

  Widget _ceoAuditView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO NODES PENDING AUDIT", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          return Card(color: const Color(0xFF0D0D0D), margin: const EdgeInsets.only(bottom: 15), child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(d['city'].toUpperCase(), style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _intelRow("STATS", d['stats']),
              _intelRow("GOAL", d['goal']),
              _intelRow("POTENTIALS", d['potentials']),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(child: ElevatedButton(onPressed: () => d.reference.update({'status': 'ACTIVE'}), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("RELEASE TO TIMELINE"))),
                const SizedBox(width: 10),
                IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _confirmDeletion(context, () => d.reference.delete())),
              ]),
            ]),
          ));
        }).toList());
      },
    );
  }

  Widget _intelRow(String label, String val) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text("$label: $val", style: const TextStyle(color: Colors.white70, fontSize: 10)),
  );

  Widget _ceoActiveTimeline() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'ACTIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("TIMELINE EMPTY", style: TextStyle(color: Colors.white10)));
        return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['city'], style: const TextStyle(color: Colors.white)), subtitle: Text(d['date']))).toList());
      },
    );
  }
}
