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
  runApp(const MaterialApp(home: HVFVettedForce(), debugShowCheckedModeBanner: false));
}

class HVFVettedForce extends StatefulWidget {
  const HVFVettedForce({super.key});
  @override
  State<HVFVettedForce> createState() => _HVFVettedForceState();
}

class _HVFVettedForceState extends State<HVFVettedForce> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

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

  @override
  Widget build(BuildContext context) {
    if (!hasAcceptedTerms) return _marshalFederalGate();
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        centerTitle: true,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        leading: IconButton(
          icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), 
          onPressed: () { setState(() => view = "GATE"); }
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
              Text("MASTER SERVICE AGREEMENT v6.6.0\n\n"
              "ARTICLE I: VETTED AGENT ACCESS\nUnauthorized attempts to access the Agent Terminal are strictly prohibited. Access is granted only to Commissioned Agents with valid IDs.\n\n"
              "ARTICLE II: DATA INTEGRITY\nAll mission data, calendar nodes, and revenue tickers are the proprietary property of HVF LLC.\n\n"
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
      case "AGENT_DASHBOARD": return _agentMissionDashboard();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("AGENT MISSION CONTROL", () => _vettedAgentLogin()),
    ]));
  }

  // REINFORCED: NO ID, NO ACCESS.
  void _vettedAgentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT ID VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: aID, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter Vetted Agent ID")),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // DATABASE CHECK: DOES THIS AGENT EXIST?
            var agentSnap = await _db.collection('commissioned_agents').where('agent_id', isEqualTo: aID.text).get();
            if (agentSnap.docs.isNotEmpty) {
              setState(() { agentID = aID.text; view = "AGENT_DASHBOARD"; });
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("INVALID AGENT ID: ACCESS DENIED")));
            }
          }, 
          child: const Text("VALIDATE")
        )
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
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(320, 75)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))),
  );

  Widget _agentMissionDashboard() {
    return Column(children: [
      StreamBuilder<QuerySnapshot>(
        stream: _db.collection('sovereign_ledger').where('agent', isEqualTo: agentID).snapshots(),
        builder: (context, snap) {
          double realTimeSales = 0;
          if (snap.hasData) {
            for (var d in snap.data!.docs) {
              if (d['status'] == 'SECURED') realTimeSales += (d['price'] as num).toDouble();
            }
          }
          return Container(
            padding: const EdgeInsets.all(25), color: const Color(0xFF0A0A0A), width: double.infinity,
            child: Column(children: [
              Text("ID: $agentID | REAL-TIME COMMISSION", style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 2)),
              Text("\$${(realTimeSales * 0.10).toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold)),
              Text("GROSS EVENT SALES: \$${realTimeSales.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12)),
            ]),
          );
        }
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("40-CITY MISSION LOG", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('tour_calendar').where('agent_id', isEqualTo: agentID).snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("LOG EMPTY", style: TextStyle(color: Colors.white10)));
                  return ListView(children: snap.data!.docs.map((d) {
                    bool isPassed = d['status'] == 'COMPLETED';
                    return Card(
                      color: const Color(0xFF0D0D0D),
                      child: ListTile(
                        leading: Icon(isPassed ? Icons.check_circle : Icons.gps_fixed, color: isPassed ? Colors.green : Colors.cyanAccent),
                        title: Text("${d['city']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text("DATE: ${d['date']} | VOLUME: \$${d['actual_sales']}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                      ),
                    );
                  }).toList());
                }
              ),
            ),
          ]),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20), decoration: const BoxDecoration(color: Color(0xFF0A0A0A), border: Border(top: BorderSide(color: Colors.white10))),
        child: Column(children: [
          const Text("PROPOSE TOUR NODE", style: TextStyle(color: Colors.white38, fontSize: 10)),
          Row(children: [
            Expanded(child: TextField(controller: eventCityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY"))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: eventDateC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "DATE"))),
          ]),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (eventCityC.text.isNotEmpty) {
                _db.collection('tour_calendar').add({
                  'agent_id': agentID, 'city': eventCityC.text, 'date': eventDateC.text,
                  'status': 'PROPOSED', 'actual_sales': 0, 'timestamp': FieldValue.serverTimestamp()
                });
                eventCityC.clear(); eventDateC.clear();
              }
            }, 
            child: const Text("SUBMIT FOR CEO APPROVAL", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ),
        ]),
      )
    ]);
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 3, child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "TOUR NODES"), Tab(text: "COMMISSION AGENTS"), Tab(text: "GLOBAL LEDGER")]),
        Expanded(child: TabBarView(children: [
          _tourApprovalList(),
          _agentManagementList(),
          _globalLedgerView(),
        ]))
    ]));
  }

  Widget _tourApprovalList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO NODES PENDING", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) {
          return Card(color: const Color(0xFF0D0D0D), child: ListTile(
            title: Text("${d['city']} (Agent: ${d['agent_id']})"),
            trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'SCHEDULED'})),
          ));
        }).toList());
      }
    );
  }

  Widget _agentManagementList() {
    final aNC = TextEditingController();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          Expanded(child: TextField(controller: aNC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NEW AGENT NAME"))),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              if (aNC.text.isNotEmpty) {
                String newID = Random().nextInt(9999).toString().padLeft(4, '0');
                _db.collection('commissioned_agents').add({'name': aNC.text, 'agent_id': newID});
                aNC.clear();
              }
            }, 
            child: const Text("COMMISSION")
          )
        ]),
      ),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('commissioned_agents').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const LinearProgressIndicator();
          return ListView(children: snap.data!.docs.map((d) {
            return ListTile(title: Text(d['name'], style: const TextStyle(color: Colors.white)), subtitle: Text("ID: ${d['agent_id']}", style: const TextStyle(color: Color(0xFFC5A059))), trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()));
          }).toList());
        }
      ))
    ]);
  }

  Widget _globalLedgerView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) {
          return ListTile(title: Text(d['name'], style: const TextStyle(color: Colors.white)), subtitle: Text("\$${d['price']} | Status: ${d['status']}", style: const TextStyle(color: Colors.white38)));
        }).toList());
      }
    );
  }
}
