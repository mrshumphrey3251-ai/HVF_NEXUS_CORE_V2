import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// GLOBAL CONSTANTS
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
  runApp(const MaterialApp(home: HVFMissionControl(), debugShowCheckedModeBanner: false));
}

class HVFMissionControl extends StatefulWidget {
  const HVFMissionControl({super.key});
  @override
  State<HVFMissionControl> createState() => _HVFMissionControlState();
}

class _HVFMissionControlState extends State<HVFMissionControl> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // AGENT EVENT INPUTS
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
          icon: const Icon(Icons.apps_rounded, color: Color(0xFFC5A059)), 
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
              Text("MASTER SERVICE AGREEMENT v6.5.0\n\n"
              "ARTICLE I: AGENT MISSION PARAMETERS\nAgents are logistics facilitators. Access is restricted to event calendars and real-time commission tracking.\n\n"
              "ARTICLE II: 40-CITY TOUR SETTLEMENT\nPost-event audits verify actual sales vs. projections. Residuals are settled within 24 hours of event closure.\n\n"
              "ARTICLE III: PROPRIETARY DATA LOCK\nAgents do not have authorization to view Producer pedigree or Buyer personal data.\n\n"
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
      case "CEO": return _ceoTerminal(); // To manage the tour
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
      title: const Text("AGENT ID VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: aID, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter 4-Digit Agent Code")),
      actions: [ElevatedButton(onPressed: () { setState(() { agentID = aID.text; view = "AGENT_DASHBOARD"; }); Navigator.pop(context); }, child: const Text("INITIALIZE DASHBOARD"))],
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
      // TOP HEADER: REVENUE TICKER
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
              const Text("LIVE EVENT SALES REVENUE", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 2)),
              Text("\$${realTimeSales.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 28, fontWeight: FontWeight.bold)),
              Text("EST. AGENT RESIDUAL: \$${(realTimeSales * 0.10).toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
            ]),
          );
        }
      ),
      // MIDDLE SECTION: LOGISTICS CALENDAR
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Icon(Icons.calendar_today, color: Color(0xFFC5A059), size: 16),
              SizedBox(width: 10),
              Text("40-CITY TOUR CALENDAR", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
            ]),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('tour_calendar').where('agent_id', isEqualTo: agentID).snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO SCHEDULED EVENTS", style: TextStyle(color: Colors.white10)));
                  return ListView(children: snap.data!.docs.map((d) {
                    bool isPassed = d['status'] == 'COMPLETED';
                    return Card(
                      color: const Color(0xFF0D0D0D),
                      child: ListTile(
                        leading: Icon(isPassed ? Icons.check_circle : Icons.pending_actions, color: isPassed ? Colors.green : Colors.orangeAccent),
                        title: Text("${d['city']}, ${d['state']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text("DATE: ${d['date']} | SALES: \$${d['actual_sales'] ?? '0.00'}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                        trailing: Text(isPassed ? "SETTLED" : "UPCOMING", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
                      ),
                    );
                  }).toList());
                }
              ),
            ),
          ]),
        ),
      ),
      // BOTTOM: INPUT FOR UPCOMING EVENTS
      Container(
        padding: const EdgeInsets.all(20), decoration: const BoxDecoration(color: Color(0xFF0A0A0A), border: Border(top: BorderSide(color: Colors.white10))),
        child: Column(children: [
          const Text("PROPOSE NEW EVENT NODE", style: TextStyle(color: Colors.white38, fontSize: 10)),
          Row(children: [
            Expanded(child: TextField(controller: eventCityC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY/STATE"))),
            const SizedBox(width: 10),
            Expanded(child: TextField(controller: eventDateC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "DATE (MM/DD)"))),
          ]),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (eventCityC.text.isNotEmpty) {
                _db.collection('tour_calendar').add({
                  'agent_id': agentID, 'city': eventCityC.text, 'state': 'TBD', 'date': eventDateC.text,
                  'status': 'PROPOSED', 'actual_sales': 0, 'timestamp': FieldValue.serverTimestamp()
                });
                eventCityC.clear(); eventDateC.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("EVENT NODE PROPOSED FOR CEO APPROVAL")));
              }
            }, 
            child: const Text("SUBMIT EVENT NODE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ),
        ]),
      )
    ]);
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "APPROVE TOUR NODES"), Tab(text: "SETTLE EVENTS")]),
        Expanded(child: TabBarView(children: [
          _tourApprovalList(),
          _eventSettlementList(),
        ]))
    ]));
  }

  Widget _tourApprovalList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO PENDING TOUR NODES", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) {
          return Card(color: const Color(0xFF0D0D0D), child: ListTile(
            title: Text("${d['city']} (Agent: ${d['agent_id']})", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("DATE: ${d['date']}", style: const TextStyle(color: Colors.white38)),
            trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'SCHEDULED'})),
          ));
        }).toList());
      }
    );
  }

  Widget _eventSettlementList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'SCHEDULED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO EVENTS READY FOR SETTLEMENT", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) {
          final sC = TextEditingController();
          return Card(color: const Color(0xFF0D0D0D), child: ListTile(
            title: Text("${d['city']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: SizedBox(width: 100, child: TextField(controller: sC, decoration: const InputDecoration(hintText: "ENTER TOTAL SALES"))),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'COMPLETED', 'actual_sales': double.parse(sC.text)}), child: const Text("SETTLE")),
          ));
        }).toList());
      }
    );
  }
}
