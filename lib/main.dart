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
  runApp(const MaterialApp(home: HVFExecutiveCore(), debugShowCheckedModeBanner: false));
}

class HVFExecutiveCore extends StatefulWidget {
  const HVFExecutiveCore({super.key});
  @override
  State<HVFExecutiveCore> createState() => _HVFExecutiveCoreState();
}

class _HVFExecutiveCoreState extends State<HVFExecutiveCore> {
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
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
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
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.chevron_left, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildCurrentView(),
    );
  }

  Widget _legalShield() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          const SizedBox(height: 40),
          const Icon(Icons.shield, color: Color(0xFFC5A059), size: 50),
          const SizedBox(height: 10),
          const Text("SOVEREIGN TERMS OF USE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
            child: ListView(controller: _legalScroll, children: const [
              Text("1. LIABILITY: HVF LLC is not liable for livestock health or mechanical asset failure.\n\n2. PATH TO WEALTH: Future value is a projection and requires active stewardship.\n\n3. JURISDICTION: Disputes resolved in Oklahoma.\n\n4. AGENT CODE: All uploads require a verified attribution code.\n\n(SCROLL TO BOTTOM TO ENABLE ACCESS)", 
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.6)),
              SizedBox(height: 400),
              Text("VALIDATED. YOU MAY NOW ACCEPT.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
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

  Widget _buildCurrentView() {
    switch (view) {
      case "PRODUCER": return _producerTheater();
      case "BUYER": return _buyerTheater();
      case "CEO": return _ceoTheater();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("CEO OVERWATCH", () => _pinAccess("CEO", "1978")),
      _gateBtn("FARMER DISPATCH", () => _pinAccess("PRODUCER", "2026")),
      _gateBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
    ]));
  }

  void _pinAccess(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [TextButton(onPressed: () { if(c.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059)))),
  );

  Widget _producerTheater() {
    final n = TextEditingController(), l = TextEditingController(), p = TextEditingController(), a = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "LOCATION (CITY, STATE)")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE")),
        TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE")),
        const SizedBox(height: 15),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), onPressed: () {
          _db.collection('sovereign_ledger').add({'name': n.text, 'location': l.text, 'price': p.text, 'agent': a.text, 'status': 'LIVE', 'timestamp': FieldValue.serverTimestamp()});
          n.clear(); l.clear(); p.clear(); a.clear();
        }, child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
      ])),
      Expanded(child: _liveFeed(isAdmin: true))
    ]);
  }

  Widget _buyerTheater() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("MARKET ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
        ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("INITIALIZE"))
      ]));
    }
    return _liveFeed(isAdmin: false);
  }

  Widget _ceoTheater() => _liveFeed(isAdmin: true);

  Widget _liveFeed({required bool isAdmin}) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("NO DATA ON LEDGER", style: TextStyle(color: Colors.white24)));

        return ListView(children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          return Card(
            color: const Color(0xFF151515),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListTile(
              title: Text(data['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("${data['location']} | Agent: ${data['agent']}", style: const TextStyle(color: Colors.white38, fontSize: 11)),
              trailing: isAdmin 
                ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
                : (live ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")) : const Text("SECURED", style: TextStyle(color: Colors.green))),
            ),
          );
        }).toList());
      },
    );
  }
}
