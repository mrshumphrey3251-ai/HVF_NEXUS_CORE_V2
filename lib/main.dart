import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.2 - THE MASTER CORE
// RE-INTEGRATED: LIVESTOCK, FLEET, INSURANCE, & STEWARDSHIP
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
  bool insuranceOptIn = false;

  // SOVEREIGN PRICING & DIVIDENDS
  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  final Map<String, double> stewFee = {"CATTLE": 50.0, "PIGS": 30.0, "CHICKENS": 10.0};

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: HVF GLOBAL MIDDLEWARE ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        leading: IconButton(icon: const Icon(Icons.logout, color: Colors.red), onPressed: () => setState(() => role = null)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.hub, color: Color(0xFFC5A059), size: 80),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("PARTNER FARMER", "PRODUCER"),
        _gateBtn("GLOBAL BUYER", "BUYER"),
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
        const Text("ENTITY VERIFICATION"),
        TextField(controller: c, decoration: const InputDecoration(labelText: "NAME / ID")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildMarket();
    return _buildCEOOversight();
  }

  Widget _buildProducerEntry() {
    final n = TextEditingController(); final w = TextEditingController();
    return StatefulBuilder(builder: (context, setInternalState) {
      double weight = double.tryParse(w.text) ?? 0;
      double fmv = weight * (regionalAvg[species] ?? 1.85) * 1.15;

      return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
        const Text("LIVESTOCK / FLEET UPLINK", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: ["CATTLE", "PIGS", "CHICKENS", "FLEET"].map((s) => 
          Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 10)), selected: species == s, onSelected: (v) => setInternalState(() => species = s)))).toList()),
        const SizedBox(height: 20),
        TextField(controller: n, decoration: InputDecoration(labelText: species == "FLEET" ? "MODEL" : "ANIMAL ID")),
        TextField(controller: w, decoration: InputDecoration(labelText: species == "FLEET" ? "HOURS" : "WEIGHT (LBS)"), onChanged: (v) => setInternalState((){})),
        const SizedBox(height: 20),
        if (weight > 0 && species != "FLEET") Container(padding: const EdgeInsets.all(10), color: Colors.white10, child: Text("EST. FMV: \$${fmv.toStringAsFixed(2)}\nDIVIDEND: \$${stewFee[species]}/MO", textAlign: TextAlign.center)),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
          onPressed: () async {
            await FirebaseFirestore.instance.collection('enterprise_ledger').add({
              'name': n.text, 'vital': w.text, 'species': species, 'value': fmv, 'stew_fee': stewFee[species],
              'status': 'AVAILABLE', 'source': userID, 'category': species == "FLEET" ? "FLEET" : "LIVESTOCK"
            });
            n.clear(); w.clear();
          },
          child: const Text("UPLINK TO GLOBAL RAILS", style: TextStyle(color: Colors.black)),
        )
      ])));
    });
  }

  Widget _buildMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF111111), margin: const EdgeInsets.all(10), child: ListTile(
            title: Text("${d['name']} (${d['species']})", style: const TextStyle(color: Color(0xFFC5A059))),
            subtitle: Text("PRICE: \$${d['value']} | DIVIDEND: \$${d['stew_fee']}/MO"),
            trailing: ElevatedButton(onPressed: () => snapshot.data!.docs[i].reference.update({'status': 'SECURED', 'buyer': userID}), child: const Text("SECURE")),
          ));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return ListTile(
            leading: Icon(Icons.cloud, color: d['status'] == 'SECURED' ? Colors.cyan : Colors.grey),
            title: Text(d['name'] ?? "ASSET"),
            subtitle: Text("SOURCE: ${d['source']} | STATUS: ${d['status']}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snapshot.data!.docs[i].reference.delete()),
          );
        });
      },
    );
  }
}
