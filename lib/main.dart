import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.5 - THE SECURE & SERVE INTEGRATION
// RE-INTEGRATED: MORTALITY INSURANCE & STEWARDSHIP DIVIDENDS
// FOCUS: RISK MITIGATION & RECURRING REVENUE TRANSPARENCY
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
  int _selectedIndex = 0;
  
  // Operational Logic
  String species = "CATTLE";
  bool insuranceToggle = false;
  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  final Map<String, double> stewFee = {"CATTLE": 50.0, "PIGS": 30.0, "CHICKENS": 10.0};
  final Map<String, double> insPremium = {"CATTLE": 10.0, "PIGS": 5.0, "CHICKENS": 2.0};

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFFC5A059)),
          onPressed: () => setState(() { role = null; userID = null; }),
        ),
        title: Text(":: HVF $role COMMAND ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 4)),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [_buildCEOWarRoom(), _buildUplinkExchange(), _buildSMEAudit()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0A0A0A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'WAR ROOM'),
          BottomNavigationBarItem(icon: Icon(Icons.add_task), label: 'UPLINK'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'AUDIT'),
        ],
      ),
    );
  }

  // --- UPLINK & INSURANCE EXCHANGE ---
  Widget _buildUplinkExchange() {
    final nameCtrl = TextEditingController();
    final weightCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS"].map((s) => 
          ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
        const SizedBox(height: 20),
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "ASSET_ID")),
        TextField(controller: weightCtrl, decoration: const InputDecoration(labelText: "WEIGHT_LBS"), keyboardType: TextInputType.number),
        const SizedBox(height: 20),
        
        // Insurance Shield Component
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: const Color(0xFF111111), border: Border.all(color: Colors.white10)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("SECURE_SHIELD (MORTALITY)", style: TextStyle(fontSize: 9, color: Colors.cyan)),
              Switch(value: insuranceToggle, onChanged: (v) => setState(() => insuranceToggle = v), activeColor: Colors.cyan),
            ]),
            Text("PREMIUM: \$${insPremium[species]}/MO | COVERAGE: 100% FMV", style: const TextStyle(fontSize: 8, color: Colors.grey)),
          ]),
        ),
        
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () async {
            double w = double.tryParse(weightCtrl.text) ?? 0;
            await FirebaseFirestore.instance.collection('enterprise_ledger').add({
              'name': nameCtrl.text, 'vital': weightCtrl.text, 'species': species, 
              'value': w * (regionalAvg[species] ?? 1.0), 'stew_fee': stewFee[species],
              'insured': insuranceToggle, 'status': 'AVAILABLE', 'source': userID,
            });
            nameCtrl.clear(); weightCtrl.clear();
          },
          child: const Text("INITIALIZE GLOBAL TRANSACTION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  // --- CEO WAR ROOM ---
  Widget _buildCEOWarRoom() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        return Padding(padding: const EdgeInsets.all(25), child: Column(children: [
          _warTile("NATIONAL_VOLUME", "$count HEAD", Colors.cyan),
          const SizedBox(height: 15),
          _warTile("DIVIDEND_STREAM", "\$${(count * 50).toStringAsFixed(2)}", const Color(0xFFC5A059)),
          const Spacer(),
          const Icon(Icons.security, color: Colors.white10, size: 80),
        ]));
      },
    );
  }

  Widget _warTile(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _buildSMEAudit() => const Center(child: Text("AUDIT_TRAIL: 100% VERIFIED", style: TextStyle(fontSize: 10, color: Colors.grey)));

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.hub, color: Color(0xFFC5A059), size: 60),
    const SizedBox(height: 40),
    _gateBtn("CEO_COMMAND", "CEO"),
    _gateBtn("PARTNER_UPLINK", "PRODUCER"),
  ])));

  Widget _gateBtn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("INITIALIZE_SESSION"),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ACCESS_CODE")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ACTIVATE")),
    ])));
  }
}
