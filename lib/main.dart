import 'package:flutter/material.dart';

// HVF NEXUS CORE V6.0 - THE PROCUREMENT & LOGISTICS ENGINE
// ARCHITECTURE: SOVEREIGN SETTLEMENT READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

// --- GLOBAL STYLES ---
const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF0A0A0A);
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  const HVFCommandDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: _buildExecutiveHeader("AUDIT & COMMAND CORE"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildSovereignTile(context, "LIVESTOCK MARKETPLACE", Icons.account_balance, const LivestockMarketplace()),
              _buildSovereignTile(context, "LOGISTICS & TRANSIT", Icons.local_shipping, const TransitHub()),
              _buildSovereignTile(context, "SOCIAL CLUB INTERIOR", Icons.gavel_rounded, const GreatHallScreen()),
              const SizedBox(height: 40),
              const Icon(Icons.security, color: gold, size: 40),
              const Text("90/10 REVENUE PROTOCOL ACTIVE", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 12)),
              const Text("ENCRYPTION LEVEL: SOVEREIGN", style: TextStyle(color: Colors.white24, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildExecutiveHeader(String subtitle) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cardGray,
        elevation: 20,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 28, letterSpacing: 4.0)),
              Container(height: 2, width: 140, color: gold),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSovereignTile(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 1)),
          child: Row(
            children: [
              Container(width: 8, color: gold),
              const SizedBox(width: 20),
              Icon(icon, color: gold, size: 28),
              const SizedBox(width: 20),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SCREEN 2: THE MARKETPLACE ---
class LivestockMarketplace extends StatelessWidget {
  const LivestockMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("VIRTUAL STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray, iconTheme: const IconThemeData(color: gold)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildAsset(context, "BLACK ANGUS BULL", "HVF-001", "1,450 LBS", "\$4,200"),
          _buildAsset(context, "HEIFER BATCH", "HVF-002", "800 LBS AVG", "\$12,500"),
          _buildAsset(context, "BOER GOAT UNITS", "HVF-003", "TRANSIT READY", "\$1,800"),
        ],
      ),
    );
  }

  Widget _buildAsset(BuildContext context, String name, String id, String spec, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardGray, border: Border.all(color: Colors.white10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
              Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(id, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 10),
          Text(spec, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 45)),
            onPressed: () => _showCommitDialog(context, name),
            child: const Text("COMMIT TO PURCHASE", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void _showCommitDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardGray,
        title: Text("CONFIRM COMMITMENT: $name", style: const TextStyle(color: gold, fontSize: 16)),
        content: const Text("Initiating SME Verification and 90/10 Revenue Split Protocol.", style: TextStyle(color: Colors.white)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("EXECUTE", style: TextStyle(color: Colors.green)))],
      ),
    );
  }
}

// --- SCREEN 3: TRANSIT HUB ---
class TransitHub extends StatelessWidget {
  const TransitHub({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("LOGISTICS & TRANSIT", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("MONITORING HUB: ALL TRANSIT LOOPS ACTIVE", style: TextStyle(color: Colors.white70))),
    );
  }
}

// --- SCREEN 4: GREAT HALL ---
class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SOCIAL CLUB", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("CEDAR & STONE ASSETS SECURE", style: TextStyle(color: gold))),
    );
  }
}
