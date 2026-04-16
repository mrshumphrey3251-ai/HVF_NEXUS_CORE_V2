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
  runApp(const MaterialApp(home: HVFNexusMarket(), debugShowCheckedModeBanner: false));
}

class HVFNexusMarket extends StatefulWidget {
  const HVFNexusMarket({super.key});
  @override
  State<HVFNexusMarket> createState() => _HVFNexusMarketState();
}

class _HVFNexusMarketState extends State<HVFNexusMarket> {
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("HVF NEXUS: EXCHANGE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 3)),
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.close, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")) : null,
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoAudit();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.account_balance, color: Color(0xFFC5A059), size: 80),
      const SizedBox(height: 50),
      _gateBtn("FARMER / PRODUCER", () => _auth("PRODUCER", "2026")),
      _gateBtn("ACQUISITION / BUYER", () => setState(() => view = "BUYER")),
      _gateBtn("CEO OVERWATCH", () => _auth("CEO", "1978")),
    ]));
  }

  void _auth(String t, String p) {
    TextEditingController c = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("SECURE LOGIN: $t", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [TextButton(onPressed: () { if(c.text == p) { setState(() => view = t); Navigator.pop(context); } }, child: const Text("ENTER"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A1A1A), side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(300, 60)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _producerTerminal() {
    final name = TextEditingController(), yield = TextEditingController(), price = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0F0F0F), child: Column(children: [
        const Text("ASSET DISPATCH", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        TextField(controller: name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME (e.g. Johnston 200)")),
        TextField(controller: yield, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YIELD/SPECS")),
        TextField(controller: price, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "OFFER PRICE (\$VAL)")),
        ElevatedButton(onPressed: () {
          _db.collection('exchange_ledger').add({'name': name.text, 'yield': yield.text, 'price': price.text, 'status': 'LIVE', 'owner': 'HVF'});
          name.clear(); yield.clear(); price.clear();
        }, child: const Text("POST TO EXCHANGE")),
      ])),
      Expanded(child: _marketStream(true))
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) return _buyerLogin();
    return Column(children: [
      Container(width: double.infinity, padding: const EdgeInsets.all(10), color: Colors.green.withOpacity(0.1), child: Text("BUYER ID: $buyerID", style: const TextStyle(color: Colors.green))),
      Expanded(child: _marketStream(false))
    ]);
  }

  Widget _buyerLogin() {
    final b = TextEditingController();
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("INITIALIZE BUYER SESSION", style: TextStyle(color: Colors.white)),
      SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
      ElevatedButton(onPressed: () => setState(() => buyerID = b.text), child: const Text("ACCESS MARKET"))
    ]));
  }

  Widget _marketStream(bool isProducer) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(10), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool isLive = data['status'] == 'LIVE';
          return Card(
            color: const Color(0xFF111111),
            child: ListTile(
              title: Text(data['name'] ?? "", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("SPECS: ${data['yield']}", style: const TextStyle(color: Colors.white54)),
              trailing: isProducer ? Text(data['status'], style: const TextStyle(color: Color(0xFFC5A059))) 
              : (isLive ? ElevatedButton(onPressed: () => d.reference.update({'status': 'PENDING', 'buyer': buyerID}), child: const Text("ACQUIRE")) : const Text("SOLD", style: TextStyle(color: Colors.red))),
            ),
          );
        }).toList());
      },
    );
  }

  Widget _ceoAudit() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('exchange_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)),
          subtitle: Text("STATUS: ${d['status']}"),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
        )).toList());
      },
    );
  }
}
