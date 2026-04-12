import 'package:flutter/material.dart';

// HVF NEXUS CORE V21.0 - THE SOVEREIGN TRUST BUILD
// FEATURE: EMBEDDED EXECUTIVE SUMMARIES / TOTAL DISCLOSURE
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

// --- SHARED UI COMPONENT FOR SUMMARIES ---
class SummaryBox extends StatelessWidget {
  final String text;
  SummaryBox(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: gold.withOpacity(0.05), border: Border.all(color: gold.withOpacity(0.3))),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5, fontStyle: FontStyle.italic)),
    );
  }
}

// --- SECTOR 1: SME ADMIN & SEAL STATION ---
class SMEAdminPortal extends StatefulWidget {
  @override
  _SMEAdminPortalState createState() => _SMEAdminPortalState();
}

class _SMEAdminPortalState extends State<SMEAdminPortal> {
  bool isSealed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME SEAL STATION", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SummaryBox("HVF SME DISCLOSURE: Every asset certified through this portal has undergone a multi-point biological and structural audit. We guarantee 'Superior' grade cattle by enforcing 1880s standards with 2026 technical oversight."),
          isSealed ? _buildCert() : _buildAudit(),
        ]),
      ),
    );
  }

  Widget _buildAudit() {
    return Column(children: [
      const Text("UNIT #044: BLACK ANGUS", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(250, 80)),
        onPressed: () => setState(() => isSealed = true),
        child: const Text("APPLY SME SEAL", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      )
    ]);
  }

  Widget _buildCert() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(border: Border.all(color: gold, width: 8), color: cardGray),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text("HVF CERTIFIED", style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.w900)),
        const Icon(Icons.verified, color: Colors.green, size: 80),
        const Text("UNIT #044", style: TextStyle(color: Colors.white, fontSize: 24)),
        const Text("SME GRADE: SUPERIOR", style: TextStyle(color: gold, fontSize: 20)),
        TextButton(onPressed: () => setState(() => isSealed = false), child: const Text("RESET", style: TextStyle(color: Colors.white24)))
      ]),
    );
  }
}

// --- SECTOR 2: HELIOGRID POWER ---
class HelioGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("HELIOGRID", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        SummaryBox("INFRASTRUCTURE DISCLOSURE: The HelioGrid 94.2 kW system provides 100% power sovereignty for the 200-acre Johnston County campus. This system ensures the Nexus Core remains online regardless of public grid failure."),
        const Icon(Icons.bolt, color: gold, size: 100),
        const Center(child: Text("94.2 kW", style: TextStyle(color: gold, fontSize: 60, fontWeight: FontWeight.w900))),
      ]),
    );
  }
}

// --- SECTOR 3: AGENCY DASHBOARD ---
class AgencyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("AGENCY PORTAL", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        SummaryBox("AGENCY DISCLOSURE: The 40-City Tour is governed by the 500-producer saturation quota. This dashboard tracks real-time licensing progress. Agency payout is strictly 10% of gross processed volume."),
        const Text("120 PRODUCERS", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
        const Text("\$2,400 ACCRUED", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.w900)),
      ]),
    );
  }
}

// --- SECTOR 4: FINANCIAL COMMAND ---
class FinancialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        SummaryBox("REVENUE DISCLOSURE: Financial projections are calculated on the 90/10 Sovereign Settlement Protocol. \$25/mo Buyer Access and \$200/mo Producer Access rates are locked for 'Legacy' status users."),
        const Center(child: Text("\$5,850,000", style: TextStyle(color: gold, fontSize: 50, fontWeight: FontWeight.w900))),
        const Center(child: Text("PROJECTED MONTHLY REVENUE", style: TextStyle(color: Colors.white, fontSize: 16))),
      ]),
    );
  }
}
