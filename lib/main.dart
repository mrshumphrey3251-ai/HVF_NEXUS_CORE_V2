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
  runApp(const MaterialApp(home: HVFNexusV2(), debugShowCheckedModeBanner: false));
}

class HVFNexusV2 extends StatefulWidget {
  const HVFNexusV2({super.key});
  @override
  State<HVFNexusV2> createState() => _HVFNexusV2State();
}

class _HVFNexusV2State extends State<HVFNexusV2> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  String? currentBuyer; 
  final _db = FirebaseFirestore.instance;

  void _securePin(String target, String pin) {
    TextEditingController pinEntry = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        content: TextField(controller: pinEntry, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
        actions: [
          TextButton(onPressed: () { if (pinEntry.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("HVF NEXUS CORE V2", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    if (view == "BUYER") return _buyerMarketTheater();
    if (view == "PRODUCER") return _producerDeck();
    if (view == "CEO") return _ceoOversight();
    if (view == "LOGISTICS") return _logisticsManifest();
    return _gateway();
  }

  Widget _gateway() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.admin_panel_settings, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 40),
      _cmdBtn("CEO COMMAND", () => _securePin("CEO", "1978")),
      _cmdBtn("PRODUCER DECK", () => _securePin("PRODUCER", "2026")),
      _cmdBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
      const SizedBox(height: 50),
      GestureDetector(onLongPress: () => _securePin("LOGISTICS", "1776"), child: Container(height: 30, width: 200, color: Colors.transparent)),
    ]));
  }

  Widget _cmdBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(280, 60)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold))
    ),
  );

  Widget _buyerMarketTheater() {
    final b = TextEditingController();
    if (currentBuyer == null) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("AUTHORIZE BUYER IDENTITY", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "Enter Name or ID", hintStyle: TextStyle(color: Colors.white24))),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(200, 50)),
            onPressed: () { if (b.text.isNotEmpty) setState(() => currentBuyer = b.text); }, 
            child: const Text("ACCESS MARKET", style: TextStyle(color: Colors.white))
          ),
          const SizedBox(height: 20),
          TextButton(onPressed: () => setState(() => view = "GATE"), child: const Text("RETURN TO GATE", style: TextStyle(color: Colors.redAccent)))
        ]),
      );
    }
    
    return Column(children: [
      Container(padding: const EdgeInsets.all(15), color: Colors.green.withOpacity(0.1), child: Row(children: [
        Text("BUYER: $currentBuyer", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        const Spacer(),
        IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() { currentBuyer = null; view = "GATE"; }))
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          if (snap.data!.docs.isEmpty) return const Center(child: Text("DATABASE EMPTY - UPLINK REQUIRED", style: TextStyle(color: Colors.white24)));
          return ListView(children: snap.data!.docs.map((d) => Card(
            color: const Color(0xFF1A1A1A), margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              title: Text(d['name'] ?? "Asset", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("FMV: \$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
              trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => d.reference.update({'status': 'CLAIMED', 'buyer': currentBuyer}), child: const Text("SECURE")),
            ),
          )).toList());
        },
      ))
    ]);
  }

  Widget _producerDeck() {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return SingleChildScrollView(child: Column(children: [
      Container(padding: const EdgeInsets.all(25), color: const Color(0xFF111111), child: Column(children: [
        DropdownButton<String>(value: sector, dropdownColor: Colors.black, style: const TextStyle(color: Color(0xFFC5A059)), items: ["LIVESTOCK", "CROPS", "FLEET"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (val) => setState(() => sector = val!)),
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET ID")),
        TextField(controller: v, style: const TextStyle(color: Colors.greenAccent), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.yellowAccent), decoration: const InputDecoration(labelText: "FMV")),
        const SizedBox(height: 20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)), onPressed: () {
          _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': double.tryParse(p.text) ?? 0.0, 'status': 'AVAILABLE', 'sector': sector, 'timestamp': FieldValue.serverTimestamp()});
          n.clear(); v.clear(); p.clear();
        }, child: const Text("UPLINK")),
        const SizedBox(height: 10),
        TextButton(onPressed: () => setState(() => view = "GATE"), child: const Text("EXIT TO GATE", style: TextStyle(color: Colors.redAccent)))
      ])),
    ]));
  }

  Widget _ceoOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return Column(children: [
          const Padding(padding: EdgeInsets.all(10), child: Text("GLOBAL AUDIT: ALL STATUSES", style: TextStyle(color: Colors.white38))),
          Expanded(child: ListView(children: snap.data!.docs.map((d) => ListTile(
            title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)), 
            subtitle: Text("STATUS: ${d['status']} | OWNER: ${d['buyer'] ?? 'None'}"), 
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()))).toList())),
          IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() => view = "GATE"))
        ]);
      },
    );
  }

  Widget _logisticsManifest() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'CLAIMED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return Column(children: [
          Expanded(child: ListView(children: snap.data!.docs.map((d) => Card(color: const Color(0xFF0D0D1F), margin: const EdgeInsets.all(10), child: ListTile(title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)), subtitle: Text("FOR: ${d['buyer']}"), trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'COMPLETED'}), child: const Text("DONE"))))).toList())),
          IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() => view = "GATE"))
        ]);
      },
    );
  }
}
