import 'package:flutter/material.dart';

// HVF NEXUS CORE V14.0 - THE FINANCIAL COMMAND BUILD
// FEATURE: 40-CITY REVENUE PROJECTION / 90% SOVEREIGN CALC
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
              _buildLargeHeader("REVENUE COMMAND"),
              _buildBigButton(context, "FINANCIAL PROJECTIONS", Icons.payments, FinancialsScreen()),
              _buildBigButton(context, "TOUR MOMENTUM", Icons.speed, const PlaceholderScreen("MOMENTUM")),
              _buildBigButton(context, "SME AUDIT", Icons.fact_check, const PlaceholderScreen("SME AUDIT")),
              const SizedBox(height: 40),
              const Text("90/10 SETTLEMENT PROTOCOL: ACTIVE", style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
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
          height: 100,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 4)),
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

// --- NEW: FINANCIAL PROJECTION SCREEN ---
class FinancialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIALS", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 28)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildRevenueCard("40-CITY TOTAL (MONTHLY)", "\$5,850,000", "90% SOVEREIGN SHARE"),
          const SizedBox(height: 30),
          _buildRevenueCard("PER CITY SATURATION", "\$146,250", "BASED ON 500 PRODUCERS / 2.5K BUYERS"),
          const SizedBox(height: 30),
          _buildRevenueCard("AGENCY PAYOUT (10%)", "\$650,000", "TOTAL 40-CITY COMMISSION"),
          const SizedBox(height: 50),
          const Text("ALL RATES LOCKED PERMANENTLY", style: TextStyle(color: gold, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(String title, String amount, String sub) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(color: cardGray, border: Border(left: BorderSide(color: gold, width: 8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          Text(sub, style: const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: Text(title, style: const TextStyle(color: gold))), body: Center(child: Text("$title SECURE", style: const TextStyle(color: Colors.white, fontSize: 30))));
  }
}
