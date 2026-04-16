import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'dart:html' as html; // NATIVE WEB HARDWARE LINK

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
  runApp(const MaterialApp(home: HVFFollowThroughCore(), debugShowCheckedModeBanner: false));
}

class HVFFollowThroughCore extends StatefulWidget {
  const HVFFollowThroughCore({super.key});
  @override
  State<HVFFollowThroughCore> createState() => _HVFFollowThroughCoreState();
}

class _HVFFollowThroughCoreState extends State<HVFFollowThroughCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  String selectedFileName = "NONE";

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  // NATIVE FOLLOW-THROUGH: TRIGGERS ACTUAL BROWSER UPLOAD
  void _startNativeUpload() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*,application/pdf'; // ACCEPT PHOTOS AND DEEDS
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        setState(() => selectedFileName = files[0].name);
      }
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
            decoration: BoxDecoration(border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)),
            child: ListView(controller: _legalScroll, children: const [
              Text("OFFICIAL TERMS OF USE\n\n1. ASSET VERIFICATION: HVF LLC provides the platform but does not guarantee livestock health or machine hours beyond documented provenance.\n\n2. CARRYING COSTS: Buyers agree to pay the farmer \$3.00/day for stewardship and growth until liquidation.\n\n3. INTERSTATE COMPLIANCE: Buyers are responsible for legal barriers when purchasing outside their state.\n\n4. DATA SOVEREIGNTY: All media uploads are locked to the asset's digital ID.\n\n(SCROLL TO BOTTOM TO ACCEPT)", 
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
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET IDENTITY")),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY, STATE")),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE (\$USD)"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE"))),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Expanded(child: OutlinedButton.icon(
            onPressed: _startNativeUpload, 
            icon: Icon(Icons.add_a_photo, color: selectedFileName == "NONE" ? const Color(0xFFC5A059) : Colors.green), 
            label: Text(selectedFileName == "NONE" ? "ATTACH PROOF" : "LINKED: $selectedFileName", style: TextStyle(color: selectedFileName == "NONE" ? const Color(0xFFC5A059) : Colors.green, fontSize: 10))
          )),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
            if(n.text.isNotEmpty) {
              _db.collection('sovereign_ledger').add({
                'name': n.text, 'location': l.text, 'price': p.text, 'agent': a.text, 'media': selectedFileName, 'status': 'LIVE', 'hash': 'HVF-${Random().nextInt(9999)}', 'timestamp': FieldValue.serverTimestamp()
              });
              n.clear(); l.clear(); p.clear(); a.clear(); setState(() => selectedFileName = "NONE");
            }
          }, child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        ]),
      ])),
      Expanded(child: _ledgerFeed(true))
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("BUYER ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return _ledgerFeed(false);
  }

  Widget _ceoTheater() => _ledgerFeed(true);

  Widget _ledgerFeed(bool isAdmin) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA ON LEDGER", style: TextStyle(color: Colors.white24)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          return Card(
            color: const Color(0xFF151515),
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(side: BorderSide(color: live ? const Color(0xFFC5A059).withOpacity(0.3) : Colors.green.withOpacity(0.3))),
            child: ListTile(
              title: Text(data['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("LOC: ${data['location']} | DOC: ${data['media']}\nSTEWARDSHIP: \$3.00 / DAY", style: const TextStyle(color: Colors.white38, fontSize: 10)),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : (live ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")) : const Icon(Icons.verified, color: Colors.green)),
            ),
          );
        }).toList());
      },
    );
  }
}
