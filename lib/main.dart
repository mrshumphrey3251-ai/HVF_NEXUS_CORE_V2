import 'package:flutter/material.dart';

// HVF NEXUS CORE V22.0 - THE GEOGRAPHIC DOMINANCE BUILD
// FEATURE: SLAB ROAD SITE MAP / INFRASTRUCTURE OVERLAY
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
              _buildLargeHeader("SOVEREIGN LEADERBOARD"),
              _buildLeaderboardTile("1. JOHNSTON CO.", "850 BUYERS", 0.9, Colors.green),
              _buildLeaderboardTile("2. ATOKA CO.", "620 BUYERS", 0.65, gold),
              const SizedBox(height: 20),
              _buildBigButton(context, "SITE MAP: SLAB ROAD", Icons.map, SiteMapScreen()),
              _buildBigButton(context, "SME ADMIN & SEAL", Icons.gavel_rounded, SMEAdminPortal()),
              _buildBigButton(context, "HELIOGRID POWER", Icons.solar_power, HelioGridScreen()),
              _buildBigButton(context, "AGENCY COMMAND", Icons.groups_3, AgencyDashboard()),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, FinancialsScreen()),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: gold,
      child: Center(
        child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24)),
      ),
    );
  }

  Widget _buildLeaderboardTile(String city, String count, double val, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(city, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
              Text(count, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: val, color: color, backgroundColor: Colors.white10, minHeight: 12),
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
          height: 85,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: gold, size: 35),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW SECTOR: SLAB ROAD SITE MAP ---
class SiteMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SLAB ROAD MAP", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _buildSummaryBox("GEOGRAPHIC DISCLOSURE: The 200-acre Johnston County Flagship features a 25-acre engineered reservoir, 94.2 kW HelioGrid array, and 200 planned livestock units. This site map dictates the infrastructure for the first 'Sovereign Campus'."),
        const SizedBox(height: 20),
        _buildSiteLabel("25-ACRE RESERVOIR", "ENGINEERED WATER SOURCE", Colors.blue),
        _buildSiteLabel("HELIOGRID ARRAY", "94.2 kW SOLAR DOMINANCE", gold),
        _buildSiteLabel("SOCIAL CLUB HQ", "SME MEETING GROUNDS", Colors.white),
        _buildSiteLabel("PRODUCER UNITS 1-200", "LIVESTOCK HOUSING GIRD", Colors.green),
        const SizedBox(height: 40),
        const Center(child: Icon(Icons.location_on, color: Colors.red, size: 50)),
        const Center(child: Text("JOHNSTON COUNTY, OK", style: TextStyle(color: Colors.white38, fontSize: 12))),
      ]),
    );
  }

  Widget _buildSiteLabel(String title, String sub, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardGray, border: Border(left: BorderSide(color: accent, width: 10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(sub, style: TextStyle(color: accent.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: gold.withOpacity(0.05), border: Border.all(color: gold.withOpacity(0.3))),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5, fontStyle: FontStyle.italic)),
    );
  }
}

// Support Classes (Harden existing portals)
class SMEAdminPortal extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("SME ADMIN", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class HelioGridScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("HELIOGRID", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class AgencyDashboard extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("AGENCY", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class FinancialsScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
