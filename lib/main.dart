import 'package:flutter/material.dart';

// HVF NEXUS CORE V19.1 - THE SOVEREIGN STRIKE BUILD
// FIXED: CONST CONSTRUCTOR ERRORS / SANITIZED NAVIGATION
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
              _buildLeaderboardTile("3. MARSHALL CO.", "450 BUYERS", 0.45, Colors.white38),
              const SizedBox(height: 20),
              _buildBigButton(context, "SME ADMIN & SEAL", Icons.gavel_rounded, SMEAdminPortal()),
              _buildBigButton(context, "AGENCY COMMAND", Icons.groups_3, PlaceholderScreen("AGENCY")),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, PlaceholderScreen("FINANCIALS")),
              const SizedBox(height: 40),
              const Text("EMPIRE EXPANSION: ACTIVE", 
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

class SMEAdminPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME SEAL", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("SME STATION READY", style: TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  // Constructor is no longer const to allow dynamic data passing
  PlaceholderScreen(this.t, {super.key}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack, 
      appBar: AppBar(title: Text(t, style: const TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(child: Text("$t SECURE", style: const TextStyle(color: Colors.white, fontSize: 30))),
    );
  }
}
