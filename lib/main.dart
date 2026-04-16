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
  runApp(const MaterialApp(home: HVFCommandPro(), debugShowCheckedModeBanner: false));
}

class HVFCommandPro extends StatefulWidget {
  const HVFCommandPro({super.key});
  @override
  State<HVFCommandPro> createState() => _HVFCommandProState();
}

class _HVFCommandProState extends State<HVFCommandPro> {
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 8,
        shadowColor: const Color(0xFFC5A059).withOpacity(0.5),
        title: const Text("HVF NEXUS: COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.dashboard_customize, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _producerTheater();
      case "BUYER": return _buyerTheater();
      case "CEO": return _ceoTheater();
      default: return _gateTheater();
    }
  }

  Widget _gateTheater() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.account_balance_wallet, color: Color(0xFFC5A059), size: 100),
        const SizedBox(height: 10),
        const Text("SOVEREIGN WEALTH TERMINAL", style: TextStyle(color: Colors.white24, letterSpacing: 5, fontSize: 10)),
        const SizedBox(height: 60),
        _gateBtn("EXECUTIVE AUDIT", () => _pinAuth("CEO", "1978")),
        _gateBtn("FARMER DISPATCH", () => _pinAuth("PRODUCER", "2026")),
        _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
      ])),
    );
  }

  void _pinAuth(String t, String p) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      shape: RoundedRectangleBorder(side: const BorderSide(color: Color(0xFFC5A059))),
      title: Text("AUTHORIZE: $t", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
      actions: [TextButton(onPressed: () { if(c.text == p) { setState(() => view = t); Navigator.pop(context); } }, child: const Text("GRANT", style: TextStyle(color: Colors.green)))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(300, 70), backgroundColor: Colors.black),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))),
  );

  Widget _producerTheater() {
    final n = TextEditingController(), s = TextEditingController(), p = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').snapshots(),
      builder: (context, snap) {
        double cap = 0;
        if (snap.hasData) {
          for (var doc in snap.data!.docs) { cap += double.tryParse(doc['price'].toString()) ?? 0; }
        }
        return Column(children: [
          _summaryBar("TOTAL MARKET CAP", cap),
          _inputTerminal(n, s, p),
          Expanded(child: _ledgerFeed(true, snap)),
        ]);
      },
    );
  }

  Widget _summaryBar(String label, double val) => Container(
    width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 25), color: const Color(0xFF111111),
    child: Column(children: [
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 3)),
      Text("\$${val.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 32, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _inputTerminal(TextEditingController n, TextEditingController s, TextEditingController p) => Container(
    padding: const EdgeInsets.all(25), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: const Color(0xFFC5A059).withOpacity(0.2)))),
    child: Column(children: [
      TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET IDENTITY")),
      TextField(controller: s, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PROVENANCE / SPECS")),
      TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "OFFER VALUE (\$USD)")),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 55)),
        onPressed: () {
          if(n.text.isNotEmpty) _db.collection('exchange_ledger').add({'name': n.text, 'specs': s.text, 'price': p.text, 'status': 'LIVE', 'hash': 'HVF-${DateTime.now().millisecondsSinceEpoch}', 'timestamp': FieldValue.serverTimestamp()});
          n.clear(); s.clear(); p.clear();
        }, child: const Text("DISPATCH TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ]),
  );

  Widget _buyerTheater() {
    if (buyerID == null) return _buyerOnboard();
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) => Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.green.withOpacity(0.15), child: Center(child: Text("ACQUISITION SESSION: $buyerID", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)))),
        Expanded(child: _ledgerFeed(false, snap)),
      ]),
    );
  }

  Widget _buyerOnboard() {
    final b = TextEditingController();
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("ENTER BUYER CREDENTIALS", style: TextStyle(color: Colors.white24, letterSpacing: 2)),
      const SizedBox(height: 20),
      SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
      const SizedBox(height: 25),
      ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("ACCESS TERMINAL"))
    ]));
  }

  Widget _ledgerFeed(bool isExec, AsyncSnapshot<QuerySnapshot> snap) {
    if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
    if (snap.data!.docs.isEmpty) return const Center(child: Text("NO ACTIVE DATA", style: TextStyle(color: Colors.white10)));
    return ListView.builder(
      itemCount: snap.data!.docs.length,
      itemBuilder: (context, i) {
        var d = snap.data!.docs[i];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFF151515), border: Border.all(color: d['status'] == 'LIVE' ? const Color(0xFFC5A059).withOpacity(0.4) : Colors.red.withOpacity(0.4))),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("${d['specs']}\nID: ${d['hash']}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
            trailing: isExec ? Text(d['status'], style: TextStyle(color: d['status'] == 'LIVE' ? Colors.green : Colors.red, fontWeight: FontWeight.bold)) 
            : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE", style: TextStyle(color: Colors.black))),
          ),
        );
      },
    );
  }

  Widget _ceoTheater() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').snapshots(),
      builder: (context, snap) => Column(children: [
        const Padding(padding: EdgeInsets.all(25), child: Text("MASTER AUDIT LOG", style: TextStyle(color: Color(0xFFC5A059), letterSpacing: 4))),
        Expanded(child: _ledgerFeed(true, snap)),
      ]),
    );
  }
}
