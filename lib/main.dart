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
  runApp(const MaterialApp(home: HVFExchangePro(), debugShowCheckedModeBanner: false));
}

class HVFExchangePro extends StatefulWidget {
  const HVFExchangePro({super.key});
  @override
  State<HVFExchangePro> createState() => _HVFExchangeProState();
}

class _HVFExchangeProState extends State<HVFExchangePro> {
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS: COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.apps, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
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
        const Icon(Icons.shield_outlined, color: Color(0xFFC5A059), size: 100),
        const SizedBox(height: 10),
        const Text("SOVEREIGN EXCHANGE", style: TextStyle(color: Color(0xFFC5A059), letterSpacing: 5, fontSize: 12)),
        const SizedBox(height: 60),
        _gateBtn("EXECUTIVE AUDIT", () => _pinAuth("CEO", "1978")),
        _gateBtn("PRODUCER DISPATCH", () => _pinAuth("PRODUCER", "2026")),
        _gateBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
      ])),
    );
  }

  void _pinAuth(String t, String p) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $t", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
      actions: [TextButton(onPressed: () { if(c.text == p) { setState(() => view = t); Navigator.pop(context); } }, child: const Text("ENTER", style: TextStyle(color: Colors.green)))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 70)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))),
  );

  Widget _producerTheater() {
    final name = TextEditingController(), specs = TextEditingController(), price = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').snapshots(),
      builder: (context, snap) {
        double totalEquity = 0;
        if (snap.hasData) {
          for (var doc in snap.data!.docs) {
            totalEquity += double.tryParse(doc['price'].toString()) ?? 0;
          }
        }
        return Column(children: [
          _equityHeader("MARKET CAP", totalEquity),
          _inputPanel(name, specs, price),
          Expanded(child: _marketFeed(true, snap)),
        ]);
      },
    );
  }

  Widget _equityHeader(String label, double val) => Container(
    width: double.infinity, padding: const EdgeInsets.all(20), color: const Color(0xFF151515),
    child: Column(children: [
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 2)),
      Text("\$${val.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 28, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _inputPanel(TextEditingController n, TextEditingController s, TextEditingController p) => Container(
    padding: const EdgeInsets.all(20), color: Colors.black,
    child: Column(children: [
      TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: s, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS/SPECS")),
      TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "OFFER PRICE")),
      const SizedBox(height: 15),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          if(n.text.isNotEmpty) _db.collection('exchange_ledger').add({'name': n.text, 'specs': s.text, 'price': p.text, 'status': 'LIVE', 'timestamp': FieldValue.serverTimestamp()});
          n.clear(); s.clear(); p.clear();
        }, child: const Text("DISPATCH TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ]),
  );

  Widget _buyerTheater() {
    if (buyerID == null) return _buyerOnboard();
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) => Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(10), color: Colors.green.withOpacity(0.1), child: Center(child: Text("ACQUISITION ID: $buyerID", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))),
        Expanded(child: _marketFeed(false, snap)),
      ]),
    );
  }

  Widget _buyerOnboard() {
    final b = TextEditingController();
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("INITIALIZE BUYER PROTOCOL", style: TextStyle(color: Colors.white38)),
      const SizedBox(height: 20),
      SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "Enter ID"))),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("ACCESS EXCHANGE"))
    ]));
  }

  Widget _marketFeed(bool isExec, AsyncSnapshot<QuerySnapshot> snap) {
    if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
    if (snap.data!.docs.isEmpty) return const Center(child: Text("NO LIVE ASSETS", style: TextStyle(color: Colors.white10)));
    return ListView.builder(
      itemCount: snap.data!.docs.length,
      itemBuilder: (context, i) {
        var d = snap.data!.docs[i];
        return Card(
          color: const Color(0xFF111111),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          shape: RoundedRectangleBorder(side: BorderSide(color: d['status'] == 'LIVE' ? const Color(0xFFC5A059).withOpacity(0.3) : Colors.red.withOpacity(0.3))),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(d['specs'], style: const TextStyle(color: Colors.white38, fontSize: 11)),
            trailing: isExec ? Text(d['status'], style: TextStyle(color: d['status'] == 'LIVE' ? Colors.green : Colors.red)) 
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
        const Padding(padding: EdgeInsets.all(20), child: Text("EXECUTIVE AUDIT", style: TextStyle(color: Color(0xFFC5A059), letterSpacing: 5))),
        Expanded(child: _marketFeed(true, snap)),
      ]),
    );
  }
}
