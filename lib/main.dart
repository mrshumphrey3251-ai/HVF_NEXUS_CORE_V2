import 'package:flutter/material.dart';

// HVF NEXUS CORE V13.2 - ULTRA-CONTRAST "CEO VISION" BUILD
// FEATURE: MAXIMUM FONT SCALING / HIGH-INTENSITY COLOR SCHEME
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF000000); // Pure black for max contrast
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 30, letterSpacing: 5)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLargeHeader("COMMAND CORE"),
              _buildBigButton(context, "TOUR MOMENTUM", Icons.speed, TourMomentumScreen()),
              _buildBigButton(context, "SOCIAL CLUB", Icons.gavel_rounded, SocialClubScreen()),
              _buildBigButton(context, "SME AUDIT", Icons.fact_check, const Scaffold()),
              _buildBigButton(context, "FINANCIALS", Icons.analytics, const Scaffold()),
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
        child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22)),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: gold, size: 40),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- TOUR MOMENTUM: MAXIMUM READABILITY ---
class TourMomentumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("MOMENTUM", style: TextStyle(color: gold, fontWeight: FontWeight.bold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildUltraTile("JOHNSTON CO.", "850 BUYERS", "120 PRODUCERS", 0.85),
          _buildUltraTile("ATOKA CO.", "620 BUYERS", "45 PRODUCERS", 0.62),
          _buildUltraTile("MARSHALL CO.", "450 BUYERS", "30 PRODUCERS", 0.45),
        ],
      ),
    );
  }

  Widget _buildUltraTile(String city, String buyers, String producers, double val) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(city, style: const TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 28)),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: val, color: gold, backgroundColor: Colors.white24, minHeight: 15),
          const SizedBox(height: 15),
          // MAX VISIBILITY TEXT
          Text(buyers, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          Text(producers, style: const TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(color: gold, thickness: 2, height: 40),
        ],
      ),
    );
  }
}

class SocialClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("CLUB", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(
        child: Text("MEMBER: JEFFERY", style: const TextStyle(color: gold, fontSize: 30, fontWeight: FontWeight.w900)),
      ),
    );
  }
}
