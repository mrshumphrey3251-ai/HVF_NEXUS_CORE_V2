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
  runApp(const MaterialApp(home: HVFResidualCore(), debugShowCheckedModeBanner: false));
}

class HVFResidualCore extends StatefulWidget {
  const HVFResidualCore({super.key});
  @override
  State<HVFResidualCore> createState() => _HVFResidualCoreState();
}

class _HVFResidualCoreState extends State<HVFResidualCore> {
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
          const SizedBox(height: 50),
          const Icon(Icons.gavel, color: Color(0xFFC5A059), size: 60),
          const Text("LIABILITY SHIELD", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
            child: ListView(controller: _legalScroll, children: const [
              Text("SUBSCRIPTION & FEE PROTOCOL\n\n1. SUBSCRIPTIONS: Farmers (\$200/mo), Buyers (\$25/mo).\n\n2. AGENT RESIDUAL: 10% of monthly subscription fees.\n\n3. SALES FEE: Farmers pay 10% of gross sale price to the platform.\n\n4. STEWARDSHIP: Farmers keep 100% of the \$3.00/day fees.\n\n(SCROLL TO BOTTOM TO ACCEPT)", 
              style: TextStyle(color: Colors.white60, fontSize: 14, height: 1.8)),
              SizedBox(height: 500),
              Text("DOCUMENT VALIDATED. ACCESS GRANTED.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            ]),
          )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 60)),
            child: Text("I ACCEPT", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _producerTheater();
      case "BUYER": return _buyerTheater();
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

  Widget _producerTheater() {
    final n = TextEditingController(), l = TextEditingController(), p = TextEditingController(), a = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        const Text("PRODUCER UPLINK (\$200/mo Sub)", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        Row(children: [
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white),
            items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => assetCategory = v!),
          )),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Asset Identity"))),
        ]),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "City, State")),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Price (\$USD)"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Agent Code"))),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: _startNativeUpload, icon: const Icon(Icons.attach_file, color: Color(0xFFC5A059)), label: const Text("ATTACH", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
            if(n.text.isNotEmpty) {
              double price = double.tryParse(p.text) ?? 0;
              _db.collection('sovereign_ledger').add({
                'category': assetCategory, 'name': n.text, 'location': l.text, 'price': price, 
                'agent': a.text, 'platform_fee': price * 0.10, 'status': 'LIVE', 'hash': 'HVF-${Random().nextInt(9999)}', 'timestamp': FieldValue.serverTimestamp()
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
        const Text("BUYER ACCESS (\$25/mo Sub)", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY ACQUISITIONS")]),
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
        double salesFees = 0;
        if (snap.hasData) {
          for (var d in snap.data!.docs) {
            totalAUM += double.tryParse(d['price'].toString()) ?? 0;
            if(d['status'] == 'SECURED') salesFees += double.tryParse(d['platform_fee'].toString()) ?? 0;
          }
        }
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), width: double.infinity, child: Column(children: [
            Text("TOTAL ASSETS: \$${totalAUM.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
            Text("ACCRIUED SALES FEES (10%): \$${salesFees.toStringAsFixed(0)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
            const Text("AGENT RESIDUAL: 10% OF SUBSCRIPTIONS", style: TextStyle(color: Colors.white38, fontSize: 10)),
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
          bool isLive = data['status'] == 'LIVE';
          return Card(
            color: const Color(0xFF111111),
            shape: RoundedRectangleBorder(side: BorderSide(color: isLive ? const Color(0xFFC5A059).withOpacity(0.3) : Colors.green.withOpacity(0.3))),
            child: ListTile(
              title: Text("${data['category']}: ${data['name']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("LOC: ${data['location']} | PLATFORM FEE: \$${data['platform_fee']}\nSTEWARDSHIP: \$3.00/DAY (FARMER KEEPS)", style: const TextStyle(color: Colors.white38, fontSize: 10)),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : (isLive ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")) : const Icon(Icons.verified, color: Colors.green)),
            ),
          );
        }).toList());
      },
    );
  }
}
