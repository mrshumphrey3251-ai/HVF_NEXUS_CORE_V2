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
  runApp(const MaterialApp(home: HVFOverwatchCore(), debugShowCheckedModeBanner: false));
}

class HVFOverwatchCore extends StatefulWidget {
  const HVFOverwatchCore({super.key});
  @override
  State<HVFOverwatchCore> createState() => _HVFOverwatchCoreState();
}

class _HVFOverwatchCoreState extends State<HVFOverwatchCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  void _confirmAction(BuildContext context, String title, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        shape: const BeveledRectangleBorder(side: BorderSide(color: Color(0xFFC5A059), width: 1)),
        title: Text(title, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 14, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.white24))),
          ElevatedButton(onPressed: () { onConfirm(); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), child: const Text("EXECUTE", style: TextStyle(color: Colors.black))),
        ],
      ),
    );
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
              Text("MASTER SERVICE AGREEMENT v6.9.0\n\n"
              "ARTICLE I: STRATEGIC TOUR OVERSIGHT\nThe CEO maintains absolute control over the 40-City Tour Timeline. No node is active without SME verification.\n\n"
              "ARTICLE II: REVENUE DATA\nProjected vs. Actual sales data is trade-secret protected and restricted to Executive Overwatch.\n\n"
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
      case "AGENT": return _agentMissionControl();
      case "CEO": return _ceoExecutiveOverwatch();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("AGENT MISSION CONTROL", () => _agentLogin()),
    ]));
  }

  void _agentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT ID", style: TextStyle(color: Color(0xFFC5A059))),
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

  Widget _agentMissionControl() {
    final cityC = TextEditingController(), dateC = TextEditingController(), projC = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), child: Column(children: [
        const Text("PROPOSE NEW TOUR NODE", style: TextStyle(color: Colors.white38, fontSize: 10)),
        TextField(controller: cityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY/STATE")),
        Row(children: [
          Expanded(child: TextField(controller: dateC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "DATE (MM/DD)"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: projC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PROJECTED SALES \$"))),
        ]),
        const SizedBox(height: 15),
        ElevatedButton(onPressed: () {
          _db.collection('tour_calendar').add({
            'agent_id': agentID, 'city': cityC.text, 'date': dateC.text, 'projected': double.tryParse(projC.text) ?? 0,
            'status': 'PROPOSED', 'actual': 0, 'notes': '', 'timestamp': FieldValue.serverTimestamp()
          });
          cityC.clear(); dateC.clear(); projC.clear();
        }, child: const Text("SUBMIT NODE")),
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('tour_calendar').where('agent_id', isEqualTo: agentID).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const LinearProgressIndicator();
          return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['city'], style: const TextStyle(color: Colors.white)), subtitle: Text("${d['date']} | Status: ${d['status']}", style: const TextStyle(color: Colors.white38)))).toList());
        },
      ))
    ]);
  }

  Widget _ceoExecutiveOverwatch() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "STRATEGIC TIMELINE"), Tab(text: "PIPELINE APPROVAL")]),
      Expanded(child: TabBarView(children: [
        _ceoMasterTimeline(),
        _ceoPipelineApproval(),
      ])),
    ]));
  }

  Widget _ceoMasterTimeline() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isNotEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("TIMELINE EMPTY", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          double proj = (d['projected'] as num).toDouble();
          double act = (d['actual'] as num).toDouble();
          double delta = act - proj;
          bool isCompleted = d['status'] == 'COMPLETED';

          return Card(color: const Color(0xFF0D0D0D), margin: const EdgeInsets.only(bottom: 15), child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(d['city'].toUpperCase(), style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, fontSize: 16)),
                Text(d['date'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ]),
              const Divider(color: Colors.white10, height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _statNode("PROJECTED", "\$${proj.toStringAsFixed(0)}", Colors.white70),
                _statNode("ACTUAL", "\$${act.toStringAsFixed(0)}", isCompleted ? Colors.green : Colors.white24),
                _statNode("DELTA", "\$${delta.toStringAsFixed(0)}", delta >= 0 ? Colors.green : Colors.red),
              ]),
              const SizedBox(height: 15),
              if (!isCompleted) ElevatedButton(
                onPressed: () => _settleEvent(d), 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 40)),
                child: const Text("SETTLE EVENT & CLOSE NODE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
              )
            ]),
          ));
        }).toList());
      },
    );
  }

  Widget _statNode(String label, String val, Color c) => Column(children: [
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8)),
    Text(val, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 14)),
  ]);

  void _settleEvent(DocumentSnapshot d) {
    final sC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("SETTLE EVENT NODE", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: sC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FINAL ACTUAL SALES \$")),
      actions: [ElevatedButton(onPressed: () { d.reference.update({'status': 'COMPLETED', 'actual': double.parse(sC.text)}); Navigator.pop(context); }, child: const Text("SETTLE"))],
    ));
  }

  Widget _ceoPipelineApproval() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO PENDING NODES", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['city'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("PROJ: \$${d['projected']} | AGENT: ${d['agent_id']}"),
          trailing: IconButton(icon: const Icon(Icons.bolt, color: Colors.green), onPressed: () => d.reference.update({'status': 'ACTIVE'})),
        )).toList());
      },
    );
  }
}
