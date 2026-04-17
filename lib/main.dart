import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// GLOBAL LOGISTICS & FINANCIAL CONSTANTS
const List<String> globalStates = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];
const double FARMER_NODE_FEE = 200.00;
const double BUYER_NODE_FEE = 25.00;
const double EXECUTIVE_THRESHOLD = 100000.00; 

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
  runApp(const MaterialApp(home: HVFStewardCore(), debugShowCheckedModeBanner: false));
}

class HVFStewardCore extends StatefulWidget {
  const HVFStewardCore({super.key});
  @override
  State<HVFStewardCore> createState() => _HVFStewardCoreState();
}

class _HVFStewardCoreState extends State<HVFStewardCore> {
  bool hasAcceptedTerms = false;
  bool paymentVerified = false;
  bool stewardVerified = false; // STEWARDSHIP AUDIT GATE
  String view = "GATE";
  String? buyerID;
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  
  // PRODUCER STEWARDSHIP CONTROLLERS
  final farmTaxID = TextEditingController();
  final fsaNumber = TextEditingController();
  final yearsOp = TextEditingController();
  
  // ASSET CONTROLLERS
  final nC = TextEditingController();
  final cC = TextEditingController();
  final pC = TextEditingController();
  final aC = TextEditingController();
  final dC = TextEditingController();
  
  // AGENT CONTROLLERS
  final agentNameC = TextEditingController();
  final agentRegionC = TextEditingController();

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
          onPressed: () { setState(() { view = "GATE"; paymentVerified = false; stewardVerified = false; }); }
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
              Text("MASTER SERVICE AGREEMENT v6.4.0\n\n"
              "ARTICLE I: STEWARDSHIP VERIFICATION\nOnly vetted Producers with a valid Tax ID and FSA Number are authorized to uplink. Middlemen are strictly prohibited.\n\n"
              "ARTICLE II: AGENT COMMISSIONING\nAgents must be formally commissioned. All residuals are tied to vetted Agent IDs.\n\n"
              "ARTICLE III: JURISDICTION\nJohnston County, Oklahoma. All data is Proprietary and Confidential.\n\n"
              "--- SCROLL TO EXECUTE MANDATE ---", 
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
    if (view == "PRODUCER" && !stewardVerified) return _stewardshipAudit();
    if (!paymentVerified && (view == "PRODUCER" || view == "BUYER")) {
      double fee = (view == "PRODUCER") ? FARMER_NODE_FEE : BUYER_NODE_FEE;
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.lock_person_rounded, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        Text("NODE ACTIVATION REQUIRED: \$${fee.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () { setState(() => paymentVerified = true); }, child: const Text("ACTIVATE NODE")),
      ]));
    }
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT": return _agentTerminal();
      case "AGENT_ONBOARD": return _agentOnboarding();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => setState(() => view = "PRODUCER")),
      _gateBtn("AGENT RESIDUALS", () => _agentLoginSelector()),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  Widget _stewardshipAudit() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Column(children: [
          const Icon(Icons.verified_user_outlined, color: Color(0xFFC5A059), size: 50),
          const SizedBox(height: 20),
          const Text("PRODUCER STEWARDSHIP AUDIT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
          const Text("To ensure 'No Rust on the Undercarriage,' please verify your dirt time.", style: TextStyle(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 30),
          TextField(controller: farmTaxID, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AG TAX ID / SCHEDULE F PROOF")),
          TextField(controller: fsaNumber, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA FARM NUMBER")),
          TextField(controller: yearsOp, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OPERATION")),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
            onPressed: () {
              if (farmTaxID.text.isNotEmpty && fsaNumber.text.isNotEmpty) {
                setState(() => stewardVerified = true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("VALID TAX ID & FSA REQUIRED FOR UPLINK")));
              }
            }, 
            child: const Text("VERIFY STEWARDSHIP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          )
        ]),
      ),
    );
  }

  void _agentLoginSelector() {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT PORTAL", style: TextStyle(color: Color(0xFFC5A059))),
      actions: [
        TextButton(onPressed: () { Navigator.pop(context); setState(() => view = "AGENT_ONBOARD"); }, child: const Text("ONBOARD NEW AGENT")),
        ElevatedButton(onPressed: () { Navigator.pop(context); _agentLogin(); }, child: const Text("LOGIN")),
      ],
    ));
  }

  void _agentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AUTHORIZE AGENT ID", style: TextStyle(color: Color(0xFFC5A059))),
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
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _agentOnboarding() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(children: [
        const Text("AGENT COMMISSIONING FORM", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        TextField(controller: agentNameC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FULL LEGAL NAME")),
        TextField(controller: agentRegionC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "REGION")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () {
          if (agentNameC.text.isNotEmpty) {
            String newID = Random().nextInt(9999).toString().padLeft(4, '0');
            _db.collection('commissioned_agents').add({'name': agentNameC.text, 'region': agentRegionC.text, 'agent_id': newID});
            setState(() => view = "GATE");
          }
        }, child: const Text("ACTIVATE COMMISSION"))
      ]),
    );
  }

  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        Row(children: [
          Expanded(child: TextField(controller: cC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY"))),
          const SizedBox(width: 10),
          Expanded(child: DropdownButton<String>(dropdownColor: Colors.black, value: "OK", items: [const DropdownMenuItem(value: "OK", child: Text("OK"))], onChanged: (v){})),
        ]),
        TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE DETAILS")),
        Row(children: [
          Expanded(child: TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: aC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE"))),
        ]),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if (nC.text.isNotEmpty) {
              double price = double.tryParse(pC.text) ?? 0;
              String initialStatus = (price >= EXECUTIVE_THRESHOLD || int.tryParse(yearsOp.text)! < 2) ? "PENDING_SORTER" : "LIVE";
              _db.collection('sovereign_ledger').add({
                'name': nC.text, 'location': "${cC.text}, OK", 'price': price, 'agent': aC.text, 'details': dC.text, 'status': initialStatus, 'steward_tax_id': farmTaxID.text
              });
              _resetControllers();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(initialStatus == "LIVE" ? "UPLINK SUCCESSFUL" : "SUBMITTED FOR CEO REVIEW")));
            }
          }, 
          child: const Text("UPLINK TO LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        ),
    ]));
  }

  void _resetControllers() {
    nC.clear(); cC.clear(); pC.clear(); aC.clear(); dC.clear();
  }

  Widget _agentTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('agent', isEqualTo: agentID).snapshots(),
      builder: (context, snap) {
        double monthlyResidual = snap.hasData ? snap.data!.docs.length * 20.0 : 0;
        return Column(children: [
          Container(padding: const EdgeInsets.all(30), color: const Color(0xFF0A0A0A), width: double.infinity, child: Column(children: [
              Text("AGENT ID: $agentID", style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text("ACTIVE RESIDUAL: \$${monthlyResidual.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
          Expanded(child: _ledgerFeed("AGENT_VIEW", "ALL"))
        ]);
      }
    );
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("PATH FOR SUCCESS", style: TextStyle(color: Color(0xFFC5A059))),
        TextField(controller: b, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "PORTFOLIO")]),
      Expanded(child: TabBarView(children: [_ledgerFeed("BUYER_VIEW", "LIVE"), _ledgerFeed("BUYER_VIEW", "SECURED")])),
    ]));
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 2, child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "SORTER"), Tab(text: "LEDGER")]),
        Expanded(child: TabBarView(children: [
          _ledgerFeed("CEO_SORTER", "PENDING_SORTER"),
          _ledgerFeed("CEO_VIEW", "ALL"),
        ]))
    ]));
  }

  Widget _ledgerFeed(String userRole, String filter) {
    Query query = _db.collection('sovereign_ledger');
    if (filter == "LIVE") query = query.where('status', isEqualTo: 'LIVE');
    if (filter == "SECURED") query = query.where('status', isEqualTo: 'SECURED').where('buyer', isEqualTo: buyerID);
    if (filter == "PENDING_SORTER") query = query.where('status', isEqualTo: 'PENDING_SORTER');

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF0D0D0D), margin: const EdgeInsets.only(bottom: 12), child: ListTile(
            title: Text("${data['name']} ${data['status'] == 'PENDING_SORTER' ? '[REVIEW]' : ''}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("${data['location']} | \$${data['price']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
            trailing: _buildActions(userRole, d, data['status'] == 'PENDING_SORTER'),
          ));
        }).toList());
      },
    );
  }

  Widget _buildActions(String role, DocumentSnapshot d, bool isPending) {
    if (role == "CEO_SORTER") {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        IconButton(icon: const Icon(Icons.cancel, color: Colors.red), onPressed: () => d.reference.delete()),
      ]);
    }
    if (role == "BUYER_VIEW" && !isPending) {
      return ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE"));
    }
    return isPending ? const Icon(Icons.warning, color: Colors.orange) : const Icon(Icons.verified, color: Colors.green);
  }
}
