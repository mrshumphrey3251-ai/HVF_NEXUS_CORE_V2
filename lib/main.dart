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
  runApp(const MaterialApp(home: HVFShell(), debugShowCheckedModeBanner: false));
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String activeRole = "GATE"; // Roles: GATE, CEO, PRODUCER, BUYER
  String activeCategory = "LIVESTOCK";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // PERMANENT EMERGENCY EXIT DOCK
      bottomNavigationBar: activeRole == "GATE" ? null : Container(
        height: 60,
        color: const Color(0xFF111111),
        child: TextButton.icon(
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text("EXIT TO SOVEREIGN GATE", style: TextStyle(color: Colors.white, fontSize: 10)),
          onPressed: () => setState(() => activeRole = "GATE"),
        ),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (activeRole) {
      case "CEO": return _buildCEODashboard();
      case "PRODUCER": return _buildProducerDeck();
      case "BUYER": return _buildBuyerMarket();
      default: return _buildGate();
    }
  }

  Widget _buildGate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 50),
      const SizedBox(height: 30),
      _gateBtn("CEO OVERSIGHT", "CEO"),
      _gateBtn("PRODUCER ENTRY", "PRODUCER"),
      _gateBtn("BUYER MARKET", "BUYER"),
    ]));
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 55)),
      onPressed: () => setState(() => activeRole = r),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ),
  );

  Widget _buildProducerDeck() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const SizedBox(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _sectorTab("LIVESTOCK"), _sectorTab("CROPS"), _sectorTab("FLEET"),
        ]),
        const Spacer(),
        Text("ACTIVE SECTOR: $activeCategory", style: const TextStyle(color: Color(0xFFC5A059))),
        const Text("READY FOR DATA UPLINK", style: TextStyle(color: Colors.white24, fontSize: 10)),
        const Spacer(),
      ]),
    );
  }

  Widget _sectorTab(String cat) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ChoiceChip(
      label: Text(cat), 
      selected: activeCategory == cat,
      onSelected: (s) => setState(() => activeCategory = cat),
      selectedColor: const Color(0xFFC5A059),
    ),
  );

  Widget _buildCEODashboard() => const Center(child: Text("CEO COMMAND DECK - REVENUE: \$0.00", style: TextStyle(color: Colors.greenAccent)));
  Widget _buildBuyerMarket() => const Center(child: Text("MARKETPLACE OPEN", style: TextStyle(color: Colors.cyan)));
}
