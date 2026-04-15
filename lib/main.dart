import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.6 - THE COMMAND CENTER
// RE-INTEGRATED: ALL MODULES (LIVESTOCK, FLEET, INSURANCE, BULK MODE)
// FOCUS: SCREEN REAL ESTATE MANAGEMENT & CLUTTER PREVENTION
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

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
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const HVFShell(),
    );
  }
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;
  String species = "CATTLE";
  bool bulkMode = false;
  bool insured = false;

  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  final Map<String, double> stewFee = {"CATTLE": 50.0, "PIGS": 30.0, "CHICKENS": 10.0};

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: HVF COMMAND CENTER ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
        actions: [IconButton(icon: const Icon(Icons.logout, color: Colors.red, size: 16), onPressed: () => setState(() => role = null))],
      ),
      body: _buildRouter(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.grid_view_rounded, color: Color(0xFFC5A059), size: 80),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("INSTITUTIONAL PARTNER", "PRODUCER"),
        _gateBtn("DISCIPLINED BUYER", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => role = r), child: Text(l)),
  );

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("GLOBAL AUTHENTICATION"),
        TextField(controller: c, decoration: const InputDecoration(labelText: "ENTITY ID")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildRouter() {
    if (role == "PRODUCER") return _buildProducerHub();
    if (role == "BUYER") return _buildMarketHub();
    return _buildCEODeck();
  }

  // --- REINFORCED PRODUCER HUB (NO CLUTTER) ---
  Widget _buildProducerHub() {
    final n = TextEditingController(); final v = TextEditingController();
    return SingleChildScrollView(child: Column(children: [
      Container(
        padding: const EdgeInsets.all(15), color: const Color(0xFF111111),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("INSTITUTIONAL BULK MODE", style: TextStyle(fontSize: 10)),
          Switch(value: bulkMode, onChanged: (v) => setState(() => bulkMode = v), activeColor: const Color(0xFFC5A059)),
        ]),
      ),
      if (bulkMode) _buildBulkTile() else ...[
        Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS", "FLEET"].map((s) => 
            ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
          TextField(controller: n, decoration: InputDecoration(labelText: species == "FLEET" ? "MODEL" : "ASSET ID")),
          TextField(controller: v, decoration: InputDecoration(labelText: species == "FLEET" ? "HOURS" : "WEIGHT"), keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () async {
              double val = double.tryParse(v.text) ?? 0;
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': n.text, 'vital': v.text, 'species': species, 'value': val * (regionalAvg[species] ?? 1.85),
                'stew_fee': stewFee[species], 'status': 'AVAILABLE', 'source': userID, 'category': species == "FLEET" ? "FLEET" : "LIVESTOCK"
              });
              n.clear(); v.clear();
            },
            child: const Text("UPLINK TO GLOBAL RAILS", style: TextStyle(color: Colors.black)),
          ),
        ])),
      ],
    ]));
  }

  Widget _buildBulkTile() => Container(
    height: 200, margin: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(border: Border.all(color: Colors.cyan, width: 2), borderRadius: BorderRadius.circular(10)),
    child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.upload_file, color: Colors.cyan, size: 50),
      Text("READY FOR INSTITUTIONAL CSV", style: TextStyle(fontSize: 10, color: Colors.cyan)),
    ]),
  );

  // --- REINFORCED MARKET HUB (DISCIPLINED BUYER) ---
  Widget _buildMarketHub() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return Card(
            color: const Color(0xFF111111), margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(children: [
              ListTile(
                title: Text(d['name'] ?? "ASSET", style: const TextStyle(color: Color(0xFFC5A059))),
                subtitle: Text("VALUE: \$${d['value']} | STEWARDSHIP: \$${d['stew_fee']}/MO"),
              ),
              CheckboxListTile(
                title: const Text("MORTALITY INSURANCE", style: TextStyle(fontSize: 10)),
                value: insured, onChanged: (v) => setState(() => insured = v!),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed: () => snapshot.data!.docs[i].reference.update({'status': 'SECURED', 'buyer': userID, 'insured': insured}), child: const Text("SECURE ASSET")),
              )
            ]),
          );
        });
      },
    );
  }

  // --- REINFORCED CEO COMMAND DECK ---
  Widget _buildCEODeck() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Column(children: [
          Container(
            padding: const EdgeInsets.all(20), width: double.infinity, color: const Color(0xFF1A1A1A),
            child: Text("NATIONAL NODES: ${snapshot.data!.docs.length}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: Color(0xFFC5A059))),
          ),
          Expanded(child: ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
            final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            return ListTile(
              leading: Icon(Icons.hub, color: d['status'] == 'SECURED' ? Colors.cyan : Colors.grey, size: 16),
              title: Text(d['name'] ?? "UNIT"),
              subtitle: Text("PROVIDER: ${d['source']}"),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 16), onPressed: () => snapshot.data!.docs[i].reference.delete()),
            );
          })),
        ]);
      },
    );
  }
}
