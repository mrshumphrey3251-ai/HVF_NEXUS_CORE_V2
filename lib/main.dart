import 'package:flutter/material.dart';

// HVF NEXUS CORE V17.0 - THE AGENCY COMMAND BUILD
// FEATURE: AGENCY LOGGING / 40-CITY QUOTA TRACKER / CEO OVERRIDE
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
              _buildLargeHeader("EXECUTIVE COMMAND"),
              _buildBigButton(context, "AGENCY DASHBOARD", Icons.groups_3, AgencyDashboard()),
              _buildBigButton(context, "SME ADMIN & WEATHER", Icons.cloud_done, SMEAdminPortal()),
              _buildBigButton(context, "HELIOGRID POWER", Icons.solar_power, HelioGridScreen()),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, FinancialsScreen()),
              const SizedBox(height: 40),
              const Text("AGENCY STATUS: AWAITING DEPLOYMENT", 
                style: TextStyle(color: gold, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      color: gold,
      child: Center(
        child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 26)),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 90,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: gold, size: 40),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW: THE AGENCY DASHBOARD ---
class AgencyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("AGENCY PORTAL", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 26)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const Text("QUOTA PROGRESS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 22)),
          const SizedBox(height: 10),
          const Text("TARGET: 500 PRODUCERS PER CITY", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 30),
          _buildAgencyTile("CURRENT ENROLLMENT", "120", "24% OF GOAL"),
          _buildAgencyTile("AGENCY COMMISSION (10%)", "\$2,400", "CURRENT ACCRUED"),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 80)),
            onPressed: () {}, 
            icon: const Icon(Icons.person_add, size: 30),
            label: const Text("LOG NEW PRODUCER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyTile(String label, String value, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      color: cardGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value, style: const TextStyle(color: gold, fontSize: 36, fontWeight: FontWeight.w900)),
          Text(sub, style: const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Support Classes
class SMEAdminPortal extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("SME & WEATHER", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class HelioGridScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("HELIOGRID", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class FinancialsScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
