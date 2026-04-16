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
  runApp(const MaterialApp(home: HVFVaultCore(), debugShowCheckedModeBanner: false));
}

class HVFVaultCore extends StatefulWidget {
  const HVFVaultCore({super.key});
  @override
  State<HVFVaultCore> createState() => _HVFVaultCoreState();
}

class _HVFVaultCoreState extends State<HVFVaultCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  String filterState = "ALL";

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 10) {
        if (!canAccept) setState(() => canAccept = true);
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
        title: const Text("HVF NEXUS: VAULT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
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
              Text("OFFICIAL TERMS OF USE\n\n1. ASSET VERIFICATION: HVF LLC provides the platform but does not guarantee livestock health or machine hours beyond documented provenance.\n\n2. JURISDICTION: This exchange operates under Oklahoma law.\n\n3. INTERSTATE COMPLIANCE: Buyers are responsible for CVI and DOT requirements for cross-state sales.\n\n4. AGENT QUOTA: 40-City mandate is verified via metadata attribution.\n\n(SCROLL TO BOTTOM TO ACCEPT)", 
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
    bool mediaAttached = false;

    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET IDENTITY")),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ORIGIN (CITY, STATE)")),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE (\$USD)"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE"))),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () => setState(() => mediaAttached = true), icon: const Icon(Icons.camera_alt, color: Color(0xFFC5A059)), label: const Text("UPLOAD MEDIA", style: TextStyle(color: Color(0xFFC5A059))))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
            _db.collection('sovereign_ledger').add({
              'name': n.text, 'location': l.text, 'price': p.text, 'agent': a.text, 'status': 'LIVE', 'hash': 'HVF-${Random().nextInt(9999)}', 'timestamp': FieldValue.serverTimestamp()
            });
            n.clear(); l.clear(); p.clear(); a.clear();
          }, child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        ]),
      ])),
      Expanded(child: _ledgerFeed(true))
    ]);
  }

  Widget _buyerTheater() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("BUYER ID REQUIRED", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("ENTER MARKET"))
      ]));
    }
    return Column(children: [
      Padding(padding: const EdgeInsets.all(10), child: Row(children: [
        const Text("FILTER BY STATE:", style: TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(width: 10),
        DropdownButton<String>(
          dropdownColor: Colors.black, value: filterState, style: const TextStyle(color: Color(0xFFC5A059)),
          items: ["ALL", "OK", "TX", "CA"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (v) => setState(() => filterState = v!),
        )
      ])),
      Expanded(child: _ledgerFeed(false))
    ]);
  }

  Widget _ceoTheater() => _ledgerFeed(true);

  Widget _ledgerFeed(bool isAdmin) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO ACTIVE LEDGER DATA", style: TextStyle(color: Colors.white10)));
        
        var docs = snap.data!.docs;
        if (filterState != "ALL" && !isAdmin) {
          docs = docs.where((d) => d['location'].toString().contains(filterState)).toList();
        }

        return ListView(padding: const EdgeInsets.all(15), children: docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool isLive = data['status'] == 'LIVE';
          return Card(
            color: const Color(0xFF111111),
            shape: RoundedRectangleBorder(side: BorderSide(color: isLive ? const Color(0xFFC5A059).withOpacity(0.3) : Colors.red.withOpacity(0.3))),
            child: ListTile(
              title: Text(data['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("LOC: ${data['location']} | ID: ${data['hash']}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : (isLive ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")) : const Text("SECURED", style: TextStyle(color: Colors.green))),
            ),
          );
        }).toList());
      },
    );
  }
}
