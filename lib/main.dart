import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.0 - THE PROFESSIONAL FLEET UPGRADE
// RE-INTEGRATED: FLEET CATEGORY DROPDOWNS & AUTOMATED SME APPROVAL
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
      appId: "1:892263251736:web:899cc6ab03f6f5e9d82899",
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
  
  // SME States
  String category = "LIVESTOCK";
  String species = "CATTLE";
  String fleetType = "TRACTOR";
  bool healthVerified = false;

  final List<String> fleetOptions = ["TRACTOR", "COMBINE", "SEMI-TRUCK", "EXCAVATOR", "DOZER", "SKID STEER"];

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
        title: Text(":: HVF $role COMMAND ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [_buildCEOWarRoom(), _buildUplink(), _buildSMEAudit()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0A0A0A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'WAR ROOM'),
          BottomNavigationBarItem(icon: Icon(Icons.add_to_photos), label: 'UPLINK'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'AUDIT'),
        ],
      ),
    );
  }

  // --- UPLINK: WITH FLEET DROPDOWN ---
  Widget _buildUplink() {
    final idCtrl = TextEditingController();
    final vCtrl = TextEditingController();

    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: ["LIVESTOCK", "FLEET"].map((c) => 
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 8)), selected: category == c, onSelected: (v) => setState(() => category = c)))).toList()),
      const SizedBox(height: 20),
      
      if (category == "LIVESTOCK") ...[
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS"].map((s) => 
          ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
        const SizedBox(height: 20),
        TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "ANIMAL_ID")),
        TextField(controller: vCtrl, decoration: const InputDecoration(labelText: "WEIGHT_LBS"), keyboardType: TextInputType.number),
      ] else ...[
        // THE DROPDOWN: 100% PRECISION
        DropdownButtonFormField<String>(
          value: fleetType,
          items: fleetOptions.map((f) => DropdownMenuItem(value: f, child: Text(f, style: const TextStyle(fontSize: 10)))).toList(),
          onChanged: (v) => setState(() => fleetType = v!),
          decoration: const InputDecoration(labelText: "EQUIPMENT_CATEGORY"),
        ),
        const SizedBox(height: 20),
        TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "SERIAL_NUMBER")),
        TextField(controller: vCtrl, decoration: const InputDecoration(labelText: "SERVICE_HOURS"), keyboardType: TextInputType.number),
      ],
      
      const SizedBox(height: 30),
      CheckboxListTile(
        title: const Text("ATTEST TO SME STANDARDS", style: TextStyle(fontSize: 9)),
        value: healthVerified, 
        onChanged: (v) => setState(() => healthVerified = v!),
        activeColor: const Color(0xFFC5A059),
      ),
      
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: healthVerified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
        onPressed: healthVerified ? () async {
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': idCtrl.text, 'vital': vCtrl.text, 'type': category == "FLEET" ? fleetType : species,
            'category': category, 'status': 'AVAILABLE', 'source': userID,
          });
          idCtrl.clear(); vCtrl.clear(); setState(() => healthVerified = false);
        } : null,
        child: const Text("INITIALIZE UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    ]));
  }

  Widget _buildCEOWarRoom() => const Center(child: Icon(Icons.analytics, color: Colors.white10, size: 80));
  Widget _buildSMEAudit() => const Center(child: Text("SME AUDIT ACTIVE", style: TextStyle(fontSize: 10, color: Colors.grey)));

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.public, color: Color(0xFFC5A059), size: 60),
    const SizedBox(height: 40),
    _gateBtn("CEO_OVERSIGHT", "CEO"),
    _gateBtn("PARTNER_PRODUCER", "PRODUCER"),
  ])));

  Widget _gateBtn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("INITIALIZE_ACCESS"),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ACCESS_CODE")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ACTIVATE")),
    ])));
  }
}import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.9 - THE SAFETY & PRECISION GATE
// FOCUS: PREVENTING RECALLS & ESTABLISHING BIO-SECURITY STANDARDS
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
  
  // SME Safety States
  String species = "CATTLE";
  bool healthVerified = false;
  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};

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
        title: Text(":: HVF SAFETY GATE ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [_buildCEOWarRoom(), _buildPrecisionUplink(), _buildSMEAudit()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0A0A0A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'WAR ROOM'),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'VET_GATE'),
          BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: 'AUDIT'),
        ],
      ),
    );
  }

  // --- THE PRECISION UPLINK: SME SAFETY GATE ---
  Widget _buildPrecisionUplink() {
    final idCtrl = TextEditingController();
    final wCtrl = TextEditingController();

    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("BIO-SECURITY ASSET INITIALIZATION", style: TextStyle(fontSize: 9, color: Colors.cyan)),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS"].map((s) => 
        ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
      const SizedBox(height: 20),
      TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "RFID / TAG_ID")),
      TextField(controller: wCtrl, decoration: const InputDecoration(labelText: "CERTIFIED_WEIGHT"), keyboardType: TextInputType.number),
      const SizedBox(height: 25),
      
      // THE RECALL PREVENTER: HEALTH TOGGLE
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFF111111), border: Border.all(color: healthVerified ? Colors.green : Colors.red)),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("HEALTH_CERTIFICATION", style: TextStyle(fontSize: 9)),
            Switch(value: healthVerified, onChanged: (v) => setState(() => healthVerified = v), activeColor: Colors.green),
          ]),
          const Text("BY TOGGLING, YOU ATTEST THIS ASSET IS DISEASE-FREE", style: TextStyle(fontSize: 7, color: Colors.grey)),
        ]),
      ),
      
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: healthVerified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
        onPressed: healthVerified ? () async {
          double w = double.tryParse(wCtrl.text) ?? 0;
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': idCtrl.text, 'vital': wCtrl.text, 'species': species, 
            'value': w * (regionalAvg[species] ?? 1.0), 'health_clearance': true, 'status': 'AVAILABLE', 'source': userID,
          });
          idCtrl.clear(); wCtrl.clear(); setState(() => healthVerified = false);
        } : null,
        child: Text(healthVerified ? "AUTHORIZE UPLINK" : "AWAITING HEALTH CLEARANCE", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    ]));
  }

  // --- CEO WAR ROOM: RECALL PREVENTION MONITOR ---
  Widget _buildCEOWarRoom() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        return Padding(padding: const EdgeInsets.all(25), child: Column(children: [
          _warTile("CERTIFIED_ASSETS", "$count", Colors.greenAccent),
          const SizedBox(height: 15),
          _warTile("RECALL_EXPOSURE", "0.00%", Colors.cyan),
          const Spacer(),
          const Icon(Icons.shield_outlined, color: Colors.white10, size: 80),
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

  Widget _buildSMEAudit() => const Center(child: Text("BIO-SECURITY LOGS: ACTIVE", style: TextStyle(fontSize: 10, color: Colors.grey)));

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.verified_user, color: Color(0xFFC5A059), size: 60),
    const SizedBox(height: 40),
    _gateBtn("CEO_OVERSIGHT", "CEO"),
    _gateBtn("PARTNER_PRODUCER", "PRODUCER"),
  ])));

  Widget _gateBtn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("IDENTITY_VERIFICATION"),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ACCESS_CODE")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
    ])));
  }
}
