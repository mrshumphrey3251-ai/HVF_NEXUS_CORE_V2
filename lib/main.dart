import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  runApp(const MaterialApp(home: HVFNexusSovereign(), debugShowCheckedModeBanner: false));
}

class HVFNexusSovereign extends StatefulWidget {
  const HVFNexusSovereign({super.key});
  @override
  State<HVFNexusSovereign> createState() => _HVFNexusSovereignState();
}

class _HVFNexusSovereignState extends State<HVFNexusSovereign> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 50) {
        setState(() => canAccept = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasAcceptedTerms) return _legalShield();
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 3)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.apps, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
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
          const Text("LEGAL DISCLAIMER & TERMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
            child: ListView(controller: _legalScroll, children: const [
              Text("HUMPHREY VIRTUAL FARMS LLC - TERMS OF USE\n\n1. RISK OF LOSS: User acknowledges livestock and machinery carry inherent risks. HVF is not liable for mortality or mechanical failure.\n\n2. NO FINANCIAL GUARANTEE: The 'Path to Wealth' is a projection. Market volatility applies.\n\n3. JURISDICTION: All disputes shall be settled in the State of Oklahoma.\n\n4. STEWARDSHIP: Carrying costs are mandatory for on-site asset management.\n\n(SCROLL TO BOTTOM TO ACCEPT)", 
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)),
              SizedBox(height: 500),
              Text("END OF TERMS. YOU MAY NOW ACCEPT.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            ]),
          )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 50)),
            child: const Text("I ACCEPT THE HUMPHREY STANDARD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoAudit();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE OVERWATCH", () => _auth("CEO", "1978")),
      _gateBtn("FARMER DISPATCH", () => _auth("PRODUCER", "2026")),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _auth(String t, String p) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $t", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [TextButton(onPressed: () { if(c.text == p) { setState(() => view = t); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(300, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _producerTerminal() {
    final n = TextEditingController(), s = TextEditingController(), p = TextEditingController(), l = TextEditingController(), ac = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        double cap = 0;
        if (snap.hasData) for (var d in snap.data!.docs) { cap += double.tryParse(d['price'].toString()) ?? 0; }
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Text("MARKET CAP: \$${cap.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.w900))),
          Expanded(child: ListView(padding: const EdgeInsets.all(20), children: [
            const Text("DISPATCH ASSET", style: TextStyle(color: Colors.white38)),
            TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Asset Identity")),
            TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Location (City, State)")),
            TextField(controller: s, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Specs / Provenance")),
            TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FMV Price")),
            TextField(controller: ac, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Agent Source Code")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              _db.collection('sovereign_ledger').add({
                'name': n.text, 'location': l.text, 'specs': s.text, 'price': p.text, 'agent': ac.text, 'status': 'LIVE', 'carrying_cost': '3.00/day', 'timestamp': FieldValue.serverTimestamp()
              });
              n.clear(); l.clear(); s.clear(); p.clear(); ac.clear();
            }, child: const Text("UPLINK TO LEDGER")),
            const Divider(height: 40, color: Colors.white10),
            _ledgerList(true, snap)
          ]))
        ]);
      },
    );
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("BUYER SIGN-IN", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) => Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(10), color: Colors.green.withOpacity(0.1), child: Center(child: Text("BUYER: $buyerID", style: const TextStyle(color: Colors.green)))),
        Expanded(child: _ledgerList(false, snap)),
      ]),
    );
  }

  Widget _ceoAudit() => StreamBuilder<QuerySnapshot>(stream: _db.collection('sovereign_ledger').snapshots(), builder: (context, snap) => _ledgerList(true, snap, isCEO: true));

  Widget _ledgerList(bool isExec, AsyncSnapshot<QuerySnapshot> snap, {bool isCEO = false}) {
    if (!snap.hasData) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      itemCount: snap.data!.docs.length,
      itemBuilder: (context, i) {
        var d = snap.data!.docs[i];
        return Card(
          color: const Color(0xFF151515),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("LOC: ${d['location']} | AGENT: ${d['agent']}\nCOST: \$${d['price']} | CARRY: ${d['carrying_cost']}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
            trailing: isExec || isCEO 
              ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
              : ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID, 'secured_at': FieldValue.serverTimestamp()}), child: const Text("SECURE")),
          ),
        );
      },
    );
  }
}
