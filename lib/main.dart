import 'package:flutter/material.dart';

// HVF NEXUS CORE V16.1 - THE TOTAL INTEGRATION BUILD
// FEATURE: HELIOGRID POWER / REVENUE / WEATHER / MASSIVE UI
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF000000); 
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 5)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLiveStatusRibbon(),
              const SizedBox(height: 10),
              _buildBigButton(context, "HELIOGRID POWER", Icons.solar_power, HelioGridScreen()),
              _buildBigButton(context, "SME ADMIN & WEATHER", Icons.cloud_done, SMEAdminPortal()),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, FinancialsScreen()),
              _buildBigButton(context, "SOCIAL CLUB", Icons.gavel_rounded, SocialClubScreen()),
              const SizedBox(height: 40),
              const Text("SYSTEMS INTEGRATED: 100%", 
                style: TextStyle(color: gold, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const Text("SOVEREIGNTY VERIFIED", style: TextStyle(color: Colors.white24, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveStatusRibbon() {
    return Container(
      width: double.infinity,
      color: Colors.green.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("GRID: ONLINE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900, fontSize: 14)),
          Text("REV: \$5.8M", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 14)),
          Text("WX: CLEAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: gold, size: 40),
              const SizedBox(width: 25),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- HELIOGRID POWER SECTOR ---
class HelioGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("HELIOGRID", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 28)), backgroundColor: cardGray),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(Icons.bolt, color: gold, size: 100),
            const Text("SYSTEM OUTPUT", style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("94.2 kW", style: TextStyle(color: gold, fontSize: 55, fontWeight: FontWeight.w900)),
            const SizedBox(height: 30),
            const Divider(color: gold, thickness: 3),
            _buildGridMetric("STORAGE", "98%"),
            _buildGridMetric("STATUS", "SOVEREIGN"),
            _buildGridMetric("AREA", "JOHNSTON CO."),
          ],
        ),
      ),
    );
  }

  Widget _buildGridMetric(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: gold, fontSize: 26, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

// --- SME ADMIN + WEATHER ---
class SMEAdminPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME & WEATHER", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 28)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 2)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("LOCAL WEATHER", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("72°F / CLEAR", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                  ],
                ),
                Icon(Icons.wb_sunny, color: gold, size: 50),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("PENDING AUTHORIZATION", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.w900)),
          const Divider(color: gold, thickness: 2),
          const ListTile(
            leading: Icon(Icons.check_circle, color: gold, size: 35),
            title: Text("BULL UNIT #044", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: Text("READY FOR CEO SEAL", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// --- REMAINING SECTORS ---
class FinancialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(child: Text("\$5,850,000 / MO", style: const TextStyle(color: gold, fontSize: 40, fontWeight: FontWeight.w900))),
    );
  }
}

class SocialClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("CLUB", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("CEO: JEFFERY", style: TextStyle(color: gold, fontSize: 45, fontWeight: FontWeight.w900))),
    );
  }
}
