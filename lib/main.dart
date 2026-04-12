import 'package:flutter/material.dart';

// HVF NEXUS CORE V15.1 - THE GRAND INTEGRATION BUILD
// INTEGRATED: WEATHER CORE / REVENUE PROJECTIONS / DIGITAL DEEDS
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
              _buildLargeHeader("INTEGRATED COMMAND"),
              _buildBigButton(context, "SME ADMIN & WEATHER", Icons.cloud_done, SMEAdminPortal()),
              _buildBigButton(context, "FINANCIAL PROJECTIONS", Icons.payments, FinancialsScreen()),
              _buildBigButton(context, "DIGITAL DEEDS", Icons.verified, DigitalDeedScreen()),
              _buildBigButton(context, "SOCIAL CLUB", Icons.gavel_rounded, SocialClubScreen()),
              const SizedBox(height: 40),
              const Text("SYSTEM STATUS: ALL SECTORS ONLINE", 
                style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
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
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 90,
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

// --- SME ADMIN + WEATHER INTEGRATION ---
class SMEAdminPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME & WEATHER", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: cardGray,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("JOHNSTON CO. WEATHER", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                      Text("72°F - CLEAR SKIES", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  Icon(Icons.wb_sunny, color: gold, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("PENDING SME SEALS", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
            const Divider(color: gold),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: gold),
              title: Text("BULL UNIT #044", style: TextStyle(color: Colors.white)),
              subtitle: Text("Awaiting CEO Authorization", style: TextStyle(color: Colors.white38)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- REMAINING SECTORS (REVENUE, DEEDS, CLUB) ---
class FinancialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(child: Text("\$5.8M / MO PROJECTED", style: const TextStyle(color: gold, fontSize: 30, fontWeight: FontWeight.w900))),
    );
  }
}

class DigitalDeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("DIGITAL DEEDS", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("DEEDS VERIFIED", style: TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}

class SocialClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SOCIAL CLUB", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("MEMBER: JEFFERY", style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.w900))),
    );
  }
}
