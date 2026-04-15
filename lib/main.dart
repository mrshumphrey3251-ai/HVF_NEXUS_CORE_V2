import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.3 - THE INTEGRATED MASTER CORE
// RE-INTEGRATED: LIVESTOCK, FLEET, BULK MODE, & RETURN NAVIGATION
// TARGET: INSTITUTIONAL SCALE (10,000+ HEAD)
// AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Colors.black, 
        fontFamily: 'Courier',
        primaryColor: const Color(0xFFC5A059),
      ),
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
  int _selectedIndex = 0;
  
  // Operational States
  String species = "CATTLE";
  bool bulkMode = false;
  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  final Map<String, double> stewFee = {"CATTLE": 50.0, "PIGS": 30.0, "CHICKENS": 10.0};

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059), size: 18),
          onPressed: () => setState(() { role = null; userID = null; _selectedIndex = 0; }),
        ),
        title: Text(":: HVF $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 4)),
      ),
      body: IndexedStack(
        index: _selectedIndex, 
        children: [_buildHub(), _buildExchange(), _buildLedger()]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0D0D0D),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'HUB'),
          BottomNavigationBarItem(icon: Icon(Icons.add_business), label: 'UPLINK'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'LEDGER'),
        ],
      ),
    );
  }

  // --- TAB 1: INSTITUTIONAL HUB ---
  Widget _buildHub() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        return Padding(padding: const EdgeInsets.all(25), child: Column(children: [
          _card("NATIONAL MANAGED VOLUME", "$count HEAD", Colors.cyan),
          const SizedBox(height: 15),
          _card("PROJECTED PARTNER DIVIDEND", "\$${(count * 50).toStringAsFixed(2)}/MO", const Color(0xFFC5A059)),
          const Spacer(),
          const Icon(Icons.verified_user, size: 40, color: Colors.white10),
          const Text("100% OPERATIONAL CAPACITY", style: TextStyle(fontSize: 8, color: Colors.grey)),
        ]));
      },
    );
  }

  // --- TAB 2: UPLINK / EXCHANGE (INTEGRATED) ---
  Widget _buildExchange() {
    final nameCtrl = TextEditingController();
    final vitalCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        // Bulk Toggle for 10,000 Head Scale
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("INSTITUTIONAL BULK MODE", style: TextStyle(fontSize: 10)),
          Switch(value: bulkMode, onChanged: (v) => setState(() => bulkMode = v), activeColor: const Color(0xFFC5A059)),
        ]),
        const SizedBox(height: 20),
        if (bulkMode) _buildBulkUI() else ...[
          // Manual Entry Restored
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS", "FLEET"].map((s) => 
            ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
          TextField(controller: nameCtrl, decoration: InputDecoration(labelText: species == "FLEET" ? "MODEL" : "ASSET ID")),
          TextField(controller: vitalCtrl, decoration: InputDecoration(labelText: species == "FLEET" ? "HOURS" : "WEIGHT"), keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () async {
              double val = double.tryParse(vitalCtrl.text) ?? 0;
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': nameCtrl.text, 'vital': vitalCtrl.text, 'species': species, 
                'value': val * (regionalAvg[species] ?? 1.0), 'stew_fee': stewFee[species] ?? 0.0,
                'status': 'AVAILABLE', 'source': userID, 'category': species == "FLEET" ? "FLEET" : "LIVESTOCK"
              });
              nameCtrl.clear(); vitalCtrl.clear();
            },
            child: const Text("UPLINK TO GLOBAL RAILS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ]),
    );
  }

  Widget _buildBulkUI() => Container(
    height: 150, width: double.infinity,
    decoration: BoxDecoration(border: Border.all(color: Colors.cyan, width: 1), borderRadius: BorderRadius.circular(5)),
    child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.upload_file, color: Colors.cyan),
      SizedBox(height: 10),
      Text("READY FOR INSTITUTIONAL CSV", style: TextStyle(fontSize: 10, color: Colors.cyan)),
    ]),
  );

  // --- TAB 3: LEDGER ---
  Widget _buildLedger() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((d) => ListTile(
          leading: Icon(Icons.hub, color: d['status'] == 'AVAILABLE' ? Colors.grey : Colors.cyan, size: 16),
          title: Text(d['name'] ?? "UNIT"),
          subtitle: Text("SOURCE: ${d['source']} | CATEGORY: ${d['category']}"),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 14), onPressed: () => d.reference.delete()),
        )).toList());
      },
    );
  }

  // --- UTILS ---
  Widget _card(String t, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      Text(v, style: TextStyle(fontSize: 20, color: c, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.public, color: Color(0xFFC5A059), size: 80),
    const SizedBox(height: 40),
    _btn("CEO COMMAND", "CEO"),
    _btn("INSTITUTIONAL PARTNER", "PRODUCER"),
  ])));

  Widget _btn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("GLOBAL ENTITY AUTH"),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ENTITY ID")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
    ])));
  }
}
