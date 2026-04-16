import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'dart:html' as html;

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
  runApp(const MaterialApp(home: HVFResidualEngine(), debugShowCheckedModeBanner: false));
}

class HVFResidualEngine extends StatefulWidget {
  const HVFResidualEngine({super.key});
  @override
  State<HVFResidualEngine> createState() => _HVFResidualEngineState();
}

class _HVFResidualEngineState extends State<HVFResidualEngine> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  String selectedFileName = "NONE";
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

  void _startNativeUpload() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*,application/pdf';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      if (uploadInput.files!.isNotEmpty) setState(() => selectedFileName = uploadInput.files![0].name);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasAcceptedTerms) return _legalShield();
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildTheater(),
    );
  }

  Widget _legalShield() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const SizedBox(height: 30),
          const Icon(Icons.gavel, color: Color(0xFFC5A059), size: 50),
          const Text("MASTER SERVICE AGREEMENT", style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Expanded(child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
            child: ListView(controller: _legalScroll, children: const [
              Text("1. REVENUE MODEL: Farmers ($200/mo), Buyers ($25/mo).\n\n"
              "2. AGENT RESIDUAL: 10% of monthly subscriptions only. No sales commission.\n\n"
              "3. SALES FEE: Farmer pays 10% Platform Fee to HVF Corporate on gross sale price.\n\n"
              "4. HUMPHREY SHIELD: Optional $5.00/mo Mortality Guarantee covers replacement cost (except neglect).\n\n"
              "5. STEWARDSHIP: Farmer retains 100% of $3.00/day fees.\n\n"
              "6. JURISDICTION: Oklahoma Law.\n\n"
              "(SCROLL TO BOTTOM TO EXECUTE)", 
              style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.7)),
              SizedBox(height: 500),
              Text("AGREEMENT READY FOR EXECUTION.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            ]),
          )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 60)),
            child: Text("EXECUTE & ENTER", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoTheater();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("FARMER DISPATCH", () => _pinAuth("PRODUCER", "2026")),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _pinAuth(String t, String p) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $t", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [TextButton(onPressed: () { if(c.text == p) { setState(() => view = t); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _producerTerminal() {
    final n = TextEditingController(), l = TextEditingController(), p = TextEditingController(), a = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        Row(children: [
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white),
            items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => assetCategory = v!),
          )),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Asset Identity"))),
        ]),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Origin: City, State")),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Price (\$USD)"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Agent Code"))),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: _startNativeUpload, icon: const Icon(Icons.add_a_photo, color: Color(0xFFC5A059)), label: const Text("ATTACH", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
            if(n.text.isNotEmpty && l.text.isNotEmpty) {
              double price = double.tryParse(p.text) ?? 0;
              _db.collection('sovereign_ledger').add({
                'category': assetCategory, 'name': n.text, 'location': l.text, 'price': price, 
                'agent': a.text, 'platform_fee': price * 0.10, 'status': 'LIVE', 'guarantee': false,
                'hash': 'HVF-${Random().nextInt(9999)}', 'timestamp': FieldValue.serverTimestamp()
              });
              n.clear(); l.clear(); p.clear(); a.clear(); setState(() => selectedFileName = "NONE");
            }
          }, child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        ]),
      ])),
      Expanded(child: _ledgerFeed(true, "ALL"))
    ]);
  }

  Widget _buyerTheater() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("BUYER ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY PORTFOLIO")]),
        Expanded(child: TabBarView(children: [
          _ledgerFeed(false, "LIVE"),
          _ledgerFeed(false, "SECURED")
        ]))
      ]),
    );
  }

  Widget _ceoTheater() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        double totalAUM = 0;
        double platformSalesFees = 0;
        if (snap.hasData) {
          for (var d in snap.data!.docs) {
            final data = d.data() as Map<String, dynamic>;
            totalAUM += double.tryParse(data['price'].toString()) ?? 0;
            if(data['status'] == 'SECURED') platformSalesFees += (double.tryParse(data['platform_fee'].toString()) ?? 0);
          }
        }
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), width: double.infinity, child: Column(children: [
            Text("TOTAL ASSETS: \$${totalAUM.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold)),
            Text("PLATFORM SALES REVENUE: \$${platformSalesFees.toStringAsFixed(2)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
            const Text("AGENT EARNINGS: 10% RESIDUAL ON SUBSCRIPTIONS", style: TextStyle(color: Colors.white38, fontSize: 10)),
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
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA FOUND", style: TextStyle(color: Colors.white24)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          bool isLS = data['category'] == 'LIVESTOCK';
          bool shield = data['guarantee'] == true;

          return Card(
            color: const Color(0xFF111111),
            shape: RoundedRectangleBorder(side: BorderSide(color: live ? const Color(0xFFC5A059).withOpacity(0.3) : Colors.green.withOpacity(0.3))),
            child: ListTile(
              title: Text("${data['category']}: ${data['name']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("ORIGIN: ${data['location']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
                if (shield) const Text("SHIELD PROTECTED", style: TextStyle(color: Colors.cyanAccent, fontSize: 9, fontWeight: FontWeight.bold)),
              ]),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    if (live) ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")),
                    if (isLS && live && !shield) TextButton(onPressed: () => d.reference.update({'guarantee': true}), child: const Text("+SHIELD (\$5)", style: TextStyle(color: Colors.cyanAccent, fontSize: 10))),
                  ]),
            ),
          );
        }).toList());
      },
    );
  }
}
