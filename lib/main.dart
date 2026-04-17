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
  runApp(const MaterialApp(home: HVFFederalCore(), debugShowCheckedModeBanner: false));
}

class HVFFederalCore extends StatefulWidget {
  const HVFFederalCore({super.key});
  @override
  State<HVFFederalCore> createState() => _HVFFederalCoreState();
}

class _HVFFederalCoreState extends State<HVFFederalCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  
  String assetCategory = "LIVESTOCK";
  String selectedState = "OK";
  final List<String> states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];

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
        elevation: 1,
        centerTitle: true,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 16)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.shield_rounded, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildCurrentTerminal(),
    );
  }

  Widget _marshalFederalGate() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(children: [
          const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 90),
          const SizedBox(height: 10),
          const Text("HUMPHREY VIRTUAL FARMS LLC", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
          const SizedBox(height: 5),
          const Text("UEI: S1M4ENLHTDH5 | CAGE: [REGISTERED]", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 2, fontFamily: 'Courier')),
          const SizedBox(height: 20),
          Expanded(child: Container(
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.2))),
            child: ListView(controller: _legalScroll, padding: const EdgeInsets.all(25), children: const [
              Text(
                "MASTER SERVICE AGREEMENT v5.6.1\nFEDERAL ENTITY IDENTIFIED | PATENT PENDING\n\n"
                "ARTICLE I: FEDERAL REGISTRATION & AUTHORITY\n1.1 UEI IDENTIFICATION: HVF LLC is a registered federal entity under UEI S1M4ENLHTDH5.\n1.2 THE SEVEN-POINT BADGE: The Marshal's Crest represents the Sovereign Seal of Provenance.\n1.3 PATENT PROTECTION: Systems including Nexus Core and HelioGrid are protected under federal patent filings. Unauthorized use is a federal offense.\n\n"
                "ARTICLE II: DATA SOVEREIGNTY & CONFIDENTIALITY\nAll information processed on this platform—user data, transaction logs, and metadata—is classified as PERSONAL AND CONFIDENTIAL.\n\n"
                "ARTICLE III: REVENUE & RESIDUALS\n• Farmer Node: \$200.00/mo Access Fee.\n• Buyer Node: \$25.00/mo Portfolio Fee.\n• Platform Override: 10% Gross Sales Fee payable to HVF LLC.\n• Agent Residual: 10% Monthly Subscription Credit only.\n\n"
                "ARTICLE IV: STEWARDSHIP\nProducers maintain assets at the 'Humphrey Standard.' A \$3.00/day stewardship fee is 100% Producer retained.\n\n"
                "ARTICLE V: THE HUMPHREY SHIELD\nOptional mortality guarantee (\$5.00/mo). Coverage warrants replacement value EXCEPT IN CASES OF NEGLECT.\n\n"
                "ARTICLE VI: INTERSTATE LOGISTICS\nMandatory State Node selection. Buyers assume all burden for DOT and CVI compliance.\n\n"
                "ARTICLE VII: DISPUTE RESOLUTION PATHWAY\n1. Executive Review | 2. Johnston Co. Mediation | 3. Binding Arbitration. Jury Trials Waived.\n\n"
                "ARTICLE VIII: ELECTRONIC SIGNATURES\nGoverned by the Oklahoma Uniform Electronic Transactions Act (UETA) OK Stat § 12A-15-101.\n\n"
                "--- END OF MANDATE ---\n"
                "--- SCROLL FULLY TO EXECUTE ---",
                style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.8, fontFamily: 'Courier'),
              ),
              SizedBox(height: 2500),
              Text("MANDATE VALIDATED. SOVEREIGN ACCESS GRANTED.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 10)),
            ]),
          )),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 70), shape: const BeveledRectangleBorder()),
            child: Text("EXECUTE MANDATE", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.w900, letterSpacing: 3)),
          )
        ]),
      ),
    );
  }

  Widget _buildCurrentTerminal() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => _pinAuth("PRODUCER", "2026")),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      shape: const BeveledRectangleBorder(side: BorderSide(color: Color(0xFFC5A059), width: 0.5)),
      title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 14, fontWeight: FontWeight.bold)),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
      actions: [TextButton(onPressed: () { if(c.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS", style: TextStyle(color: Color(0xFFC5A059))))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(320, 75), shape: const BeveledRectangleBorder()), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13))),
  );

  Widget _producerTerminal() {
    final n = TextEditingController(), city = TextEditingController(), p = TextEditingController(), a = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(25), decoration: const BoxDecoration(color: Color(0xFF0A0A0A), border: Border(bottom: BorderSide(color: Colors.white10))), child: Column(children: [
        Row(children: [
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white, fontSize: 11),
            items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => assetCategory = v!),
          )),
          const SizedBox(width: 15),
          Expanded(child: TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET IDENTITY", labelStyle: TextStyle(fontSize: 10)))),
        ]),
        Row(children: [
          Expanded(flex: 2, child: TextField(controller: city, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY TERMINAL", labelStyle: TextStyle(fontSize: 10)))),
          const SizedBox(width: 15),
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedState, isExpanded: true, style: const TextStyle(color: Colors.white, fontSize: 11),
            items: states.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => selectedState = v!),
          )),
        ]),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION (\$USD)", labelStyle: TextStyle(fontSize: 10)))),
          const SizedBox(width: 15),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE", labelStyle: TextStyle(fontSize: 10)))),
        ]),
        const SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 55), shape: const BeveledRectangleBorder()), 
          onPressed: () {
            if(n.text.isNotEmpty && city.text.isNotEmpty) {
              double price = double.tryParse(p.text) ?? 0;
              _db.collection('sovereign_ledger').add({
                'category': assetCategory, 'name': n.text, 'location': "${city.text}, $selectedState", 
                'price': price, 'agent': a.text, 'platform_fee': price * 0.10, 'status': 'LIVE', 'guarantee': false,
                'timestamp': FieldValue.serverTimestamp()
              });
              n.clear(); city.clear(); p.clear(); a.clear();
            }
          }, 
          child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12))
        ),
      ])),
      Expanded(child: _ledgerFeed(true, "ALL"))
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.shield_moon_outlined, color: Color(0xFFC5A059), size: 50),
        const SizedBox(height: 15),
        const Text("PATH FOR SUCCESS INITIALIZATION", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 30),
        SizedBox(width: 280, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "ENTER FULL NAME", hintStyle: TextStyle(color: Colors.white10), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10))))),
        const SizedBox(height: 30),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), shape: const BeveledRectangleBorder(), minimumSize: const Size(280, 60)), onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE PORTFOLIO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
      ]));
    }
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 2), tabs: [Tab(text: "LIVE MARKET"), Tab(text: "MY PORTFOLIO")]),
        Expanded(child: TabBarView(children: [
          _ledgerFeed(false, "LIVE"),
          _ledgerFeed(false, "SECURED")
        ]))
      ]),
    );
  }

  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        double totalAUM = 0;
        if (snap.hasData) {
          for (var d in snap.data!.docs) {
            totalAUM += double.tryParse(d['price'].toString()) ?? 0;
          }
        }
        return Column(children: [
          Container(padding: const EdgeInsets.all(30), color: const Color(0xFF0A0A0A), width: double.infinity, child: Column(children: [
            const Text("EXECUTIVE COMMAND OVERWATCH", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 3)),
            const SizedBox(height: 10),
            Text("TOTAL AUM: \$${totalAUM.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 2)),
            const SizedBox(height: 5),
            const Divider(color: Color(0xFFC5A059), thickness: 0.5, indent: 80, endIndent: 80),
          ])),
          Expanded(child: _ledgerFeed(true, "ALL"))
        ]);
      }
    );
  }

  Widget _ledgerFeed(bool isAdmin, String filterStatus) {
    Query query = _db.collection('sovereign_ledger');
    if (filterStatus == "LIVE") query = query.where('status', isEqualTo: 'LIVE');
    if (filterStatus == "SECURED") query = query.where('status', isEqualTo: 'SECURED').where('buyer', isEqualTo: buyerID);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA ON LEDGER", style: TextStyle(color: Colors.white10, letterSpacing: 2)));
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          bool shield = data['guarantee'] == true;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: live ? const Color(0xFFC5A059).withOpacity(0.2) : Colors.green.withOpacity(0.2), width: 1)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text("${data['category']}: ${data['name']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 8),
                Text("ORIGIN: ${data['location']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("VALUATION: \$${data['price']} | FEE: 10%", style: const TextStyle(color: Colors.white38, fontSize: 9)),
                if (shield) const Padding(padding: EdgeInsets.only(top: 8), child: Text("● SHIELD PROTECTED", style: TextStyle(color: Colors.cyanAccent, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1))),
              ]),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20), onPressed: () => d.reference.delete()) 
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    if (live) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), shape: const BeveledRectangleBorder(), minimumSize: const Size(100, 35)), onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
                    if (live && !shield && data['category'] == 'LIVESTOCK') TextButton(onPressed: () => d.reference.update({'guarantee': true}), child: const Text("+SHIELD (\$5)", style: TextStyle(color: Colors.cyanAccent, fontSize: 9))),
                    if (!live) const Icon(Icons.verified, color: Colors.green, size: 24),
                  ]),
            ),
          );
        }).toList());
      },
    );
  }
}
