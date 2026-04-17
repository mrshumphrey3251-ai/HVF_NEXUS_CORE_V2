import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// GLOBAL LOGISTICS & FINANCIAL CONSTANTS
const List<String> globalStates = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];

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
  runApp(const MaterialApp(home: HVFSafetyCore(), debugShowCheckedModeBanner: false));
}

class HVFSafetyCore extends StatefulWidget {
  const HVFSafetyCore({super.key});
  @override
  State<HVFSafetyCore> createState() => _HVFSafetyCoreState();
}

class _HVFSafetyCoreState extends State<HVFSafetyCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // Controllers
  final nC = TextEditingController();
  final cC = TextEditingController();
  final pC = TextEditingController();
  final aC = TextEditingController();
  final dC = TextEditingController();
  final eventCityC = TextEditingController();
  final eventDateC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  // THE SAFETY SWITCH: CONFIRMATION MODAL
  void _confirmDeletion(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        shape: const BeveledRectangleBorder(side: BorderSide(color: Colors.red, width: 2)),
        title: const Text("DESTRUCTIVE COMMAND DETECTED", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
        content: const Text("DO YOU REALLY WANT TO DELETE THIS DATA?\nThis action cannot be undone on the Sovereign Ledger.", style: TextStyle(color: Colors.white70, fontSize: 12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // RETURNS TO PAGE
            child: const Text("CANCEL", style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: const Text("YES, PERMANENTLY DELETE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
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
        leading: IconButton(
          icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), 
          onPressed: () { setState(() { view = "GATE"; }); }
        ),
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
              Text("MASTER SERVICE AGREEMENT v6.8.0\n\n"
              "ARTICLE I: DESTRUCTIVE COMMAND PROTOCOL\nAll deletions require multi-stage executive verification. Data integrity is the primary directive.\n\n"
              "ARTICLE II: SOVEREIGN SETTLEMENT\nHVF LLC maintains the final authority on all ledger modifications.\n\n"
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
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT_DASHBOARD": return _agentMissionDashboard();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => setState(() => view = "PRODUCER")),
      _gateBtn("AGENT MISSION CONTROL", () => _vettedAgentLogin()),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _vettedAgentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: aID, style: const TextStyle(color: Colors.white)),
      actions: [
        ElevatedButton(onPressed: () async {
          var snap = await _db.collection('commissioned_agents').where('agent_id', isEqualTo: aID.text).get();
          if (snap.docs.isNotEmpty) { setState(() { agentID = aID.text; view = "AGENT_DASHBOARD"; }); Navigator.pop(context); }
          else { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ACCESS DENIED"))); }
        }, child: const Text("VALIDATE")),
      ],
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

  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: cC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY")),
        TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE")),
        TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION")),
        TextField(controller: aC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {
          _db.collection('sovereign_ledger').add({'name': nC.text, 'location': cC.text, 'price': double.tryParse(pC.text) ?? 0, 'agent': aC.text, 'details': dC.text, 'status': 'PENDING_SORTER'});
          nC.clear(); cC.clear(); pC.clear(); dC.clear(); aC.clear();
        }, child: const Text("UPLINK TO SORTER")),
    ]));
  }

  Widget _agentMissionDashboard() {
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), width: double.infinity, child: Text("AGENT ID: $agentID", style: const TextStyle(color: Color(0xFFC5A059)))),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('tour_calendar').where('agent_id', isEqualTo: agentID).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const LinearProgressIndicator();
          return ListView(children: snap.data!.docs.map((d) => ListTile(
            title: Text(d['city'], style: const TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.white12),
              onPressed: () => _confirmDeletion(context, () => d.reference.delete()),
            ),
          )).toList());
        },
      )),
      Container(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: eventCityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PROPOSE CITY")),
        TextField(controller: eventDateC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "DATE")),
        ElevatedButton(onPressed: () {
          _db.collection('tour_calendar').add({'agent_id': agentID, 'city': eventCityC.text, 'date': eventDateC.text, 'status': 'PROPOSED', 'actual_sales': 0});
          eventCityC.clear(); eventDateC.clear();
        }, child: const Text("PROPOSE TOUR NODE")),
      ])),
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(controller: b, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "ENTER NAME")),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE")),
      ]));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)), 
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE"))
        )).toList());
      },
    );
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 3, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "TOUR NODES"), Tab(text: "ASSET SORTER"), Tab(text: "AGENT LIST")]),
      Expanded(child: TabBarView(children: [
        _ceoTourReview(),
        _ceoAssetReview(),
        _ceoAgentReview(),
      ])),
    ]));
  }

  Widget _ceoTourReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO PENDING TOUR NODES", style: TextStyle(color: Colors.white10)));
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['city'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("Agent: ${d['agent_id']}"), 
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'SCHEDULED'})),
            IconButton(icon: const Icon(Icons.cancel, color: Colors.red), onPressed: () => _confirmDeletion(context, () => d.reference.delete())),
          ])
        )).toList());
      },
    );
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("SORTER EMPTY", style: TextStyle(color: Colors.white10)));
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)), 
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _confirmDeletion(context, () => d.reference.delete())),
          ])
        )).toList());
      },
    );
  }

  Widget _ceoAgentReview() {
    final aNC = TextEditingController();
    return Column(children: [
      Padding(padding: const EdgeInsets.all(20), child: Row(children: [
        Expanded(child: TextField(controller: aNC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NEW AGENT NAME"))),
        ElevatedButton(onPressed: () { String id = Random().nextInt(9999).toString().padLeft(4, '0'); _db.collection('commissioned_agents').add({'name': aNC.text, 'agent_id': id}); aNC.clear(); }, child: const Text("COMMISSION")),
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot>(stream: _db.collection('commissioned_agents').snapshots(), builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)), 
          subtitle: Text("ID: ${d['agent_id']}", style: const TextStyle(color: Color(0xFFC5A059))),
          trailing: IconButton(icon: const Icon(Icons.person_remove, color: Colors.red), onPressed: () => _confirmDeletion(context, () => d.reference.delete())),
        )).toList());
      })),
    ]);
  }
}
