import 'package:flutter/material.dart';

// HVF NEXUS CORE V13.1 - HIGH-VISIBILITY COMMAND BUILD
// FEATURE: ENHANCED TEXT CONTRAST / BRIGHTENED CITY METRICS
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF0A0A0A);
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, letterSpacing: 4)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceLockBanner(),
              const SizedBox(height: 20),
              _buildSovereignButton(context, "TOUR MOMENTUM", Icons.speed, TourMomentumScreen()),
              _buildSovereignButton(context, "HUMPHREY SOCIAL CLUB", Icons.gavel_rounded, SocialClubScreen()),
              _buildSovereignButton(context, "SME RAPID AUDIT", Icons.fact_check, SMEAdminPortal()),
              _buildSovereignButton(context, "FINANCIAL AUDIT", Icons.analytics, AuditLedger()),
              const SizedBox(height: 40),
              const Text("40-CITY TOUR STATUS: ACTIVE", 
                style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceLockBanner() {
    return Container(
      width: double.infinity,
      color: gold.withOpacity(0.15),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Text("LEGACY LOCK: \$25 BUYER / \$200 PRODUCER", 
          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSovereignButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        tileColor: cardGray,
        leading: Icon(icon, color: gold, size: 28),
        title: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        shape: Border.all(color: gold, width: 1.5),
      ),
    );
  }
}

// --- TOUR MOMENTUM: HARDENED VISIBILITY ---
class TourMomentumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("TOUR MOMENTUM", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("CITY INTEREST LEADERBOARD", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 18)),
          const SizedBox(height: 30),
          _buildMomentumTile("JOHNSTON COUNTY, OK", 0.85, "850 BUYERS / 120 PRODUCERS"),
          _buildMomentumTile("ATOKA COUNTY, OK", 0.62, "620 BUYERS / 45 PRODUCERS"),
          _buildMomentumTile("MARSHALL COUNTY, OK", 0.45, "450 BUYERS / 30 PRODUCERS"),
        ],
      ),
    );
  }

  Widget _buildMomentumTile(String city, double progress, String stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(city, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress, 
          color: gold, 
          backgroundColor: Colors.white24, 
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        // SME FIX: Brighter white and bold for the metrics
        Text(stats, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.1)),
        const SizedBox(height: 25),
        const Divider(color: Colors.white10),
      ],
    );
  }
}

class SocialClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SOCIAL CLUB", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(border: Border.all(color: gold, width: 2), color: cardGray),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("OFFICIAL MEMBER", style: TextStyle(color: gold, letterSpacing: 4, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Text("JEFFERY HUMPHREY", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              Text("SOVEREIGN FOUNDER", style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class SMEAdminPortal extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("SME AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class AuditLedger extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("FINANCIAL AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
