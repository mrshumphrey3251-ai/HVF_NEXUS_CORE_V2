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
  runApp(const MaterialApp(home: HVFShowroomCore(), debugShowCheckedModeBanner: false));
}

class HVFShowroomCore extends StatefulWidget {
  const HVFShowroomCore({super.key});
  @override
  State<HVFShowroomCore> createState() => _HVFShowroomCoreState();
}

class _HVFShowroomCoreState extends State<HVFShowroomCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  String assetCategory = "LIVESTOCK";

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
    if (!hasAcceptedTerms) return _polishedLegalGate();
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 16)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.grid_view_sharp, color: Color(0xFFC5A059), size: 18), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildPolishedTheater(),
    );
  }

  Widget _polishedLegalGate() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(children: [
          const Icon(Icons.shield_outlined, color: Color(0xFFC5A059), size: 90),
          const SizedBox(height: 15),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 5)),
          const Text("EST. 2026 | SOVEREIGN EXCHANGE", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 2)),
          const SizedBox(height: 30),
          Expanded(child: Container(
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.15))),
            child: ListView(controller: _legalScroll, padding: const EdgeInsets.all(25), children: const [
              Text(
                "MASTER SERVICE AGREEMENT v5.1.0\nPROPRIETARY & CONFIDENTIAL\n\n"
                "ARTICLE I: PATENT PROTECTION & IP\nThis system, including the Nexus Core and HelioGrid logic, is protected under HVF Patent Filings. Unauthorized duplication is a federal offense.\n\n"
                "ARTICLE II: DATA CONFIDENTIALITY\nAll information on this ledger is Personal and Confidential. No third-party data extraction is permitted.\n\n"
                "ARTICLE III: THE DISCIPLINED BUYER\nHVF provides a path for success exclusively for the well-disciplined buyer. Success is contingent upon stewardship and protocol adherence.\n\n"
                "ARTICLE IV: REVENUE INFRASTRUCTURE\n• Farmer Node: \$200/mo\n• Buyer Node: \$25/mo\n• Agent Residual: 10% Sub-Fee Credit\n• Platform Override: 10% Gross Sales Fee\n\n"
                "ARTICLE V: THE HUMPHREY SHIELD\n\$5.00/mo Mortality Guarantee. Replacement warranted except in cases of proven neglect.\n\n"
                "ARTICLE VI: LOGISTICS\nMandatory City/State origin verification. Buyer assumes all CVI/DOT compliance.\n\n"
                "ARTICLE VII: DISPUTE ESCALATION\n1. Executive Review | 2. Johnston Co. Mediation | 3. Binding Arbitration. Jury Trials Waived.\n\n"
                "--- SCROLL TO EXECUTE MANDATE ---",
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.9, fontFamily: 'Courier'),
              ),
              SizedBox(height: 2000),
              Text("MANDATE VALIDATED. PROCEED TO COMMAND.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
          )),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10,
              minimumSize: const Size(double.infinity, 70),
              shape: const BeveledRectangleBorder(), // Sharp Industrial Edges
            ),
            child: Text("EXECUTE MANDATE", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.w900, letterSpacing: 3)),
          )
        ]),
      ),
    );
  }

  Widget _buildPolishedTheater() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE OVERWATCH", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => _pinAuth("PRODUCER", "2026")),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
      const SizedBox(height: 40),
      const Text("DISCIPLINE EQUALS WEALTH", style: TextStyle(color: Colors.white10, letterSpacing: 4, fontSize: 10)),
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
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(320, 75), shape: const BeveledRectangleBorder()), 
      onPressed: a, 
      child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13))
    ),
  );

  Widget _producerTerminal() {
    final n = TextEditingController(), l = TextEditingController(), p = TextEditingController(), a = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(25), decoration: const BoxDecoration(color: Color(0xFF0A0A0A), border: Border(bottom: BorderSide(color: Colors.white10))), child: Column(children: [
        Row(children: [
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white, fontSize: 12),
            items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => assetCategory = v!),
          )),
          const SizedBox(width: 15),
          Expanded(child: TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET IDENTITY", labelStyle: TextStyle(fontSize: 10)))),
        ]),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ORIGIN (CITY, STATE)", labelStyle: TextStyle(fontSize: 10))),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VALUATION (\$USD)", labelStyle: TextStyle(fontSize: 10)))),
          const SizedBox(width: 15),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE", labelStyle: TextStyle(fontSize: 10)))),
        ]),
        const SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 55), shape: const BeveledRectangleBorder()), 
          onPressed: () {
            if(n.text.isNotEmpty && l.text.isNotEmpty) {
              double price = double.tryParse(p.text) ?? 0;
              _db.collection('sovereign_ledger').add({
                'category': assetCategory, 'name': n.text, 'location': l.text, 'price': price, 
                'agent': a.text, 'platform_fee': price * 0.10, 'status': 'LIVE', 'guarantee': false,
                'timestamp': FieldValue.serverTimestamp()
              });
              n.clear(); l.clear(); p.clear(); a.clear();
            }
          }, 
          child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12))
        ),
      ])),
      Expanded(child: _polishedLedger(true, "ALL"))
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.analytics_outlined, color: Color(0xFFC5A059), size: 50),
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
        const TabBar(indicatorColor: Color(0xFFC5A059), labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 2), tabs: [Tab(text: "LIVE MARKET"), Tab(text: "MY ACQUISITIONS")]),
        Expanded(child: TabBarView(children: [
          _polishedLedger(false, "LIVE"),
          _polishedLedger(false, "SECURED")
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
          Expanded(child: _polishedLedger(true, "ALL"))
        ]);
      }
    );
  }

  Widget _polishedLedger(bool isAdmin, String filterStatus) {
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
