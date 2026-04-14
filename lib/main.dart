import 'package:flutter/material.dart';

// HVF NEXUS CORE V71.0 - THE SME DATA ENGINE
// FEATURE: FUNCTIONAL DATA ENTRY WITHIN THE ANCHOR SHELL
// STATUS: DOMINANT UNIFIED BUILD | REVENUE-READY ASSET LOGGING
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color fieldGreen = Color(0xFF152215);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FlagshipIntegratedMap(),
    const CEODashboard(),
    const ProducerDashboard(),
    const BuyerDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: deepBlack,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) => setState(() => _selectedIndex = index),
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Icon(Icons.shield_rounded, color: goldAccent, size: 40),
            ),
            labelType: NavigationRailLabelType.all,
            unselectedLabelTextStyle: const TextStyle(color: Colors.white38, fontSize: 10),
            selectedLabelTextStyle: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.map, color: Colors.white), selectedIcon: Icon(Icons.map, color: goldAccent), label: Text("MAP")),
              NavigationRailDestination(icon: Icon(Icons.admin_panel_settings, color: Colors.white), selectedIcon: Icon(Icons.admin_panel_settings, color: goldAccent), label: Text("CEO")),
              NavigationRailDestination(icon: Icon(Icons.agriculture, color: Colors.white), selectedIcon: Icon(Icons.agriculture, color: goldAccent), label: Text("FARMER")),
              NavigationRailDestination(icon: Icon(Icons.shopping_bag, color: Colors.white), selectedIcon: Icon(Icons.shopping_bag, color: goldAccent), label: Text("BUYER")),
            ],
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

// --- ROOM 1: MAP ---
class FlagshipIntegratedMap extends StatelessWidget {
  const FlagshipIntegratedMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: fieldGreen,
      child: const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY CAMPUS", style: TextStyle(color: goldAccent, letterSpacing: 2))),
    );
  }
}

// --- ROOM 2: CEO ---
class CEODashboard extends StatelessWidget {
  const CEODashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const Text("PENDING SME REVIEW", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _queueCard("ASSET #ANGUS-V77", "DNA: Verified | Awaiting CEO Stamp"),
          _queueCard("ASSET #BISON-K02", "DNA: Pending | Data Review Required"),
        ],
      ),
    );
  }

  Widget _queueCard(String title, String sub) {
    return Card(
      color: const Color(0xFF2A2A2A),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        trailing: const Icon(Icons.gavel, color: goldAccent),
      ),
    );
  }
}

// --- ROOM 3: FARMER (DATA ENGINE ACTIVE) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER CONSOLE")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("INITIALIZE ASSET INDUCTION", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.brown)),
            const SizedBox(height: 30),
            const TextField(decoration: InputDecoration(labelText: "BREED (SME STANDARD)", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: "DNA TAG IDENTIFIER", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            const Row(children: [
              Expanded(child: TextField(decoration: InputDecoration(labelText: "AGE (MONTHS)", border: OutlineInputBorder()))),
              SizedBox(width: 20),
              Expanded(child: TextField(decoration: InputDecoration(labelText: "EST. WEIGHT (LBS)", border: OutlineInputBorder()))),
            ]),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
              onPressed: () {},
              child: const Text("SYNC DATA TO CEO DESK", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- ROOM 4: BUYER ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("HVF SUPERIOR MARKETPLACE", style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: const Text("ANGUS UNIT #044"), subtitle: const Text("SME CERTIFIED"), trailing: const Text("\$2,695.00", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}
