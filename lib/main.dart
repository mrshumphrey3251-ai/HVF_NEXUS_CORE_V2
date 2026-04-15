import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.1 - THE CLEAN RESTORE
// FOCUS: FIXING COMPILATION ERRORS & RE-LOCKING FLEET/SAFETY LOGIC
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
  
  // SME Operational State
  String category = "LIVESTOCK";
  String species = "CATTLE";
  String fleetType = "TRACTOR";
  bool sseCertified = false;

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

  // HUB: THE COMMAND CENTER
  Widget _buildCEOWarRoom() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        return Padding(padding: const EdgeInsets.all(25), child: Column(children: [
          _summaryTile("NATIONAL ASSETS", "$count NODES", Colors.cyan),
          const SizedBox(height: 15),
          _summaryTile("PROJECTED DIVIDEND", "\$${(count * 50).toStringAsFixed(2)}", const Color(0xFFC5A059)),
          const Spacer(),
          const Icon(Icons.analytics_outlined, color: Colors.white10, size: 80),
        ]));
      },
    );
  }

  // UPLINK: THE PRODUCER'S ENTRY
  Widget _buildUplink() {
    final idCtrl = TextEditingController();
    final vCtrl = TextEditingController();

    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: ["LIVESTOCK", "FLEET"].map((c) => 
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 8)), selected: category == c, onSelected: (v) => setState(() => category = c)))).toList()),
      const SizedBox(height: 25),
      
      if (category == "LIVESTOCK") ...[
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ["CATTLE", "PIGS", "CHICKENS"].map((s) => 
          ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 8)), selected: species == s, onSelected: (v) => setState(() => species = s))).toList()),
        const SizedBox(height: 20),
        TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "ASSET_TAG_ID")),
        TextField(controller: vCtrl, decoration: const InputDecoration(labelText: "CERTIFIED_WEIGHT"), keyboardType: TextInputType.number),
      ] else ...[
        DropdownButtonFormField<String>(
          value: fleetType,
          items: fleetOptions.map((f) => DropdownMenuItem(value: f, child: Text(f, style: const TextStyle(fontSize: 10)))).toList(),
          onChanged: (v) => setState(() => fleetType = v!),
          decoration: const InputDecoration(labelText: "MACHINERY_CATEGORY"),
        ),
        const SizedBox(height: 20),
        TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "SERIAL_NUMBER")),
        TextField(controller: vCtrl, decoration: const InputDecoration(labelText: "SERVICE_HOURS"), keyboardType: TextInputType.number),
      ],
      
      const SizedBox(height: 30),
      CheckboxListTile(
        title: const Text("SAFETY & HEALTH CERTIFIED", style: TextStyle(fontSize: 9, color: Colors.greenAccent)),
        subtitle: const Text("I attest this asset meets HVF SME standards.", style: TextStyle(fontSize: 7)),
        value: sseCertified, 
        onChanged: (v) => setState(() => sseCertified = v!),
        activeColor: const Color(0xFFC5A059),
      ),
      
      const SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: sseCertified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
        onPressed: sseCertified ? () async {
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': idCtrl.text, 'vital': vCtrl.text, 'type': category == "FLEET" ? fleetType : species,
            'category': category, 'status': 'AVAILABLE', 'source': userID, 'certified': true
          });
          idCtrl.clear(); vCtrl.clear(); setState(() => sseCertified = false);
        } : null,
        child: const Text("AUTHORIZE INITIAL UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    ]));
  }

  Widget _buildSMEAudit() => const Center(child: Text("SME SECURITY PROTOCOLS: 100%", style: TextStyle(fontSize: 10, color: Colors.grey)));

  Widget _summaryTile(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.security, color: Color(0xFFC5A059), size: 60),
    const SizedBox(height: 40),
    _gateBtn("CEO_COMMAND", "CEO"),
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
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ACTIVATE")),
    ])));
  }
}
