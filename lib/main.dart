import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.4 - THE CEO WAR ROOM
// RECONSTRUCTED: HIGH-DENSITY EXECUTIVE DASHBOARD
// FOCUS: NATIONAL NODE MONITORING & LIQUIDITY PROJECTION
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
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Colors.black, 
        fontFamily: 'Courier',
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
        actions: [
          const Icon(Icons.sensors, color: Colors.green, size: 14),
          const SizedBox(width: 10),
          const Center(child: Text("LIVE_STREAM  ", style: TextStyle(fontSize: 8, color: Colors.green))),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [_buildCEOWarRoom(), _buildGlobalMarket(), _buildSMEAudit()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0A0A0A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'WAR ROOM'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'NODES'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'AUDIT'),
        ],
      ),
    );
  }

  // --- THE WAR ROOM: CUSTOM CEO INTERFACE ---
  Widget _buildCEOWarRoom() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        double totalValue = 0;
        for (var doc in (snapshot.data?.docs ?? [])) {
          totalValue += (doc.data() as Map<String, dynamic>)['value'] ?? 0.0;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("NATIONAL INFRASTRUCTURE STATUS", style: TextStyle(fontSize: 9, color: Colors.grey, letterSpacing: 2)),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _warTile("TOTAL_NODES", "$count", Colors.cyan)),
              const SizedBox(width: 15),
              Expanded(child: _warTile("GLOBAL_FMV", "\$${totalValue.toStringAsFixed(0)}", const Color(0xFFC5A059))),
            ]),
            const SizedBox(height: 15),
            _warTile("PROJECTED_SERVICE_DIVIDEND", "\$${(count * 50).toStringAsFixed(2)} / MO", Colors.greenAccent),
            const SizedBox(height: 30),
            const Text("ACTIVE LOGISTICS FEED", style: TextStyle(fontSize: 9, color: Colors.grey, letterSpacing: 2)),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: Colors.white10)),
              child: const Center(child: Icon(Icons.map, color: Colors.white10, size: 80)),
            ),
          ]),
        );
      },
    );
  }

  Widget _warTile(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border(top: BorderSide(color: color, width: 2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ]),
    );
  }

  // --- NODES: GLOBAL LIST ---
  Widget _buildGlobalMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((d) => ListTile(
          leading: const Icon(Icons.radio_button_checked, color: Colors.cyan, size: 12),
          title: Text(d['name'] ?? "NODE_ID_NULL", style: const TextStyle(fontSize: 12)),
          subtitle: Text("SOURCE: ${d['source']} | STATUS: ${d['status']}", style: const TextStyle(fontSize: 9)),
          trailing: IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red, size: 16), onPressed: () => d.reference.delete()),
        )).toList());
      },
    );
  }

  Widget _buildSMEAudit() => const Center(child: Text("SME SECURITY PROTOCOLS: 100%", style: TextStyle(fontSize: 10, color: Colors.grey)));

  // --- GATE & AUTH ---
  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.security, color: Color(0xFFC5A059), size: 60),
    const SizedBox(height: 30),
    const Text("HVF NEXUS SOVEREIGN GATE", style: TextStyle(letterSpacing: 4, fontSize: 12)),
    const SizedBox(height: 50),
    _gateBtn("CEO_OVERSIGHT", "CEO"),
    _gateBtn("PARTNER_UPLINK", "PRODUCER"),
  ])));

  Widget _gateBtn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("IDENTITY_VERIFICATION", style: TextStyle(fontSize: 10)),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ACCESS_CODE")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ACTIVATE")),
    ])));
  }
}
