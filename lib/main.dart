import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// GLOBAL LOGISTICS & FINANCIAL CONSTANTS
const List<String> globalStates = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];
const double FARMER_NODE_FEE = 200.00;
const double BUYER_NODE_FEE = 25.00;

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
  runApp(const MaterialApp(home: HVFPaymentCore(), debugShowCheckedModeBanner: false));
}

class HVFPaymentCore extends StatefulWidget {
  const HVFPaymentCore({super.key});
  @override
  State<HVFPaymentCore> createState() => _HVFPaymentCoreState();
}

class _HVFPaymentCoreState extends State<HVFPaymentCore> {
  bool hasAcceptedTerms = false;
  bool paymentVerified = false; // FINANCIAL GATE
  String view = "GATE";
  String? buyerID;
  String? agentID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  
  String assetCategory = "LIVESTOCK";
  String selectedState = "OK";
  String mediaStatus = "NO_MEDIA";
  
  final nC = TextEditingController();
  final cC = TextEditingController();
  final pC = TextEditingController();
  final aC = TextEditingController();
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

  void _processPayment(double amount, String type) {
    // STRIPE GATEWAY SIMULATION - PREPARING FOR PRODUCTION RAIL
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        title: Text("HVF SECURE CHECKOUT: $type", style: const TextStyle(color: Color(0xFFC5A059))),
        content: Text("TOTAL DUE: \$${amount.toStringAsFixed(2)}\n\nProcessing through HVF Sovereign Rail...", style: const TextStyle(color: Colors.white70)),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() => paymentVerified = true);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("PAYMENT VERIFIED: ACCESS GRANTED")));
            },
            child: const Text("EXECUTE TRANSACTION"),
          )
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
        centerTitle: true,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        leading: IconButton(
          icon: const Icon(Icons.apps_rounded, color: Color(0xFFC5A059)), 
          onPressed: () { setState(() { view = "GATE"; paymentVerified = false; }); }
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
              Text("MASTER SERVICE AGREEMENT v6.0.0\n\n"
              "ARTICLE I: FINANCIAL OBLIGATIONS\nAccess to the Sovereign Ledger requires node activation fees (\$200/\$25). All sales are final.\n\n"
              "ARTICLE II: TRANSACTIONAL OVERRIDE\nHVF LLC retains a 10% platform fee on all gross asset exchanges.\n\n"
              "ARTICLE III: AGENT SETTLEMENT\nResiduals are disbursed monthly based on verified agent code uplinks.\n\n"
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
    if (!paymentVerified && view != "GATE" && view != "CEO") {
      double fee = (view == "PRODUCER") ? FARMER_NODE_FEE : BUYER_NODE_FEE;
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.lock_person_rounded, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        Text("NODE ACTIVATION REQUIRED", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text("DUE: \$${fee.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(250, 60)),
          onPressed: () => _processPayment(fee, view), 
          child: const Text("ACTIVATE NODE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        ),
      ]));
    }
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT": return _agentTerminal();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => setState(() => view = "PRODUCER")),
      _gateBtn("AGENT RESIDUALS", () => _agentLogin()),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _agentLogin() {
    TextEditingController aID = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("AGENT AUTHORIZATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: aID, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter Agent Code")),
      actions: [ElevatedButton(onPressed: () { setState(() { agentID = aID.text; view = "AGENT"; }); Navigator.pop(context); }, child: const Text("ACCESS"))],
    ));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pinController = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pinController, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () {
          if (pinController.text == pin) { setState(() => view = target); Navigator.pop(context); }
      }, child: const Text("ACCESS"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _producerTerminal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        DropdownButton<String>(
          dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white),
          items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => assetCategory = v!),
        ),
        TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        Row(children: [
          Expanded(child: TextField(controller: cC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY"))),
          const SizedBox(width: 10),
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedState, isExpanded: true, style: const TextStyle(color: Colors.white),
            items: globalStates.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => selectedState = v!),
          )),
        ]),
        TextField(controller: dC, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "HEALTH / PEDIGREE")),
        Row(children: [
          Expanded(child: TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: aC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE"))),
        ]),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () => setState(() => mediaStatus = "MEDIA_VERIFIED_HVF_600"),
          icon: const Icon(Icons.camera_enhance, color: Color(0xFFC5A059)),
          label: Text(mediaStatus == "NO_MEDIA" ? "ATTACH VISUAL PROOF" : "PROOF SECURED", style: const TextStyle(color: Color(0xFFC5A059))),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (nC.text.isNotEmpty) {
              _db.collection('sovereign_ledger').add({
                'category': assetCategory, 'name': nC.text, 'location': "${cC.text}, $selectedState", 
                'price': double.tryParse(pC.text) ?? 0, 'agent': aC.text, 'details': dC.text,
                'media': mediaStatus, 'status': 'LIVE', 'timestamp': FieldValue.serverTimestamp()
              });
              nC.clear(); cC.clear(); pC.clear(); aC.clear(); dC.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("VAULTED")));
            }
          },
          child: Container(
            height: 60, width: double.infinity,
            color: const Color(0xFFC5A059),
            alignment: Alignment.center,
            child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(height: 300, child: _ledgerFeed(true, "ALL"))
      ]),
    );
  }

  Widget _agentTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('agent', isEqualTo: agentID).snapshots(),
      builder: (context, snap) {
        double monthlyResidual = snap.hasData ? snap.data!.docs.length * 20.0 : 0;
        return Column(children: [
          Container(
            padding: const EdgeInsets.all(30), color: const Color(0xFF0A0A0A), width: double.infinity,
            child: Column(children: [
              Text("AGENT IDENTIFIER: $agentID", style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text("RESIDUAL PORTFOLIO: \$${monthlyResidual.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold)),
            ]),
          ),
          Expanded(child: _ledgerFeed(false, "ALL"))
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
      Expanded(child: TabBarView(children: [_ledgerFeed(false, "LIVE"), _ledgerFeed(false, "SECURED")])),
    ]));
  }

  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        double total = 0;
        if (snap.hasData) for (var d in snap.data!.docs) total += (d['price'] as num).toDouble();
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), width: double.infinity, 
          child: Text("TOTAL AUM: \$${total.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold))),
          Expanded(child: _ledgerFeed(true, "ALL"))
        ]);
      }
    );
  }

  Widget _ledgerFeed(bool isAdmin, String filter) {
    Query query = _db.collection('sovereign_ledger');
    if (filter == "LIVE") query = query.where('status', isEqualTo: 'LIVE');
    if (filter == "SECURED") query = query.where('status', isEqualTo: 'SECURED').where('buyer', isEqualTo: buyerID);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("LEDGER EMPTY", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          bool hasMedia = data['media'] != "NO_MEDIA";

          return Card(
            color: const Color(0xFF0D0D0D), 
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(children: [
              if(hasMedia) Container(height: 100, width: double.infinity, color: Colors.white10, child: const Icon(Icons.image_search, color: Color(0xFFC5A059))),
              ListTile(
                title: Text("${data['name']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("${data['location']} | VAL: \$${data['price']}\nPEDIGREE: ${data['details'] ?? 'N/A'}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
                trailing: isAdmin ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : (live ? ElevatedButton(onPressed: () {
                    // TRANSACTION TRIGGER: ASSET ACQUISITION
                    _processPayment(data['price'] * 0.10, "10% PLATFORM OVERRIDE");
                    d.reference.update({'status': 'SECURED', 'buyer': buyerID});
                  }, child: const Text("SECURE")) : const Icon(Icons.verified, color: Colors.green)),
              ),
            ]),
          );
        }).toList());
      },
    );
  }
}
