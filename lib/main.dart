import 'package:flutter/material.dart';

// HVF NEXUS CORE V72.0 - THE DIGITAL DEED
// FEATURE: INTEGRATED CERTIFICATE OF LINEAGE & ASSET VAULT
// STATUS: DOMINANT UNIFIED BUILD | COMPLETING THE TRANSACTION LOOP
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
const Color certificateGold = Color(0xFFD4AF37);

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
              NavigationRailDestination(icon: Icon(Icons.map), label: Text("MAP")),
              NavigationRailDestination(icon: Icon(Icons.admin_panel_settings), label: Text("CEO")),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("FARMER")),
              NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("BUYER")),
            ],
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

// --- MAP ---
class FlagshipIntegratedMap extends StatelessWidget {
  const FlagshipIntegratedMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFF152215), child: const Center(child: Text("HVF FLAGSHIP CAMPUS", style: TextStyle(color: goldAccent))));
  }
}

// --- CEO ---
class CEODashboard extends StatelessWidget {
  const CEODashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND")),
      body: const Center(child: Text("Executive Approval Queue: 2 Pending", style: TextStyle(color: Colors.white70))),
    );
  }
}

// --- FARMER ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER CONSOLE")),
      body: const Center(child: Text("SME Data Induction Active")),
    );
  }
}

// --- BUYER (VAULT ACTIVE) ---
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
          const Text("MY SECURED ASSETS", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified, color: goldAccent),
              title: const Text("ANGUS UNIT #044"),
              subtitle: const Text("SME Certified Superior"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateView())),
            ),
          ),
        ],
      ),
    );
  }
}

// --- THE CERTIFICATE (THE DEED) ---
class CertificateView extends StatelessWidget {
  const CertificateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF7),
            border: Border.all(color: certificateGold, width: 10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("HVF - EST. 1880", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent, fontSize: 24)),
              const Divider(color: goldAccent, thickness: 2),
              const SizedBox(height: 20),
              const Text("CERTIFICATE OF LINEAGE", style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 40),
              const Text("ASSET ID: ANGUS-UNIT-044", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const Text("GRADE: SUPERIOR (SME CERTIFIED)", style: TextStyle(fontSize: 12, color: Colors.brown)),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(children: [Text("ISSUED BY", style: TextStyle(fontSize: 8)), Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.bold))]),
                  const Icon(Icons.shield, color: goldAccent, size: 50),
                  const Column(children: [Text("SME SIGNATURE", style: TextStyle(fontSize: 8)), Text("CEO J. HUMPHREY", style: TextStyle(fontWeight: FontWeight.bold))]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
