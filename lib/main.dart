import 'package:flutter/material.dart';

// HVF NEXUS CORE V7.0 - THE SOVEREIGN LEDGER & AUDIT BUILD
// REVENUE MONITORING: 90/10 REAL-TIME SPLIT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

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
        appBar: _buildHeader("EXECUTIVE COMMAND"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildSovereignStat(context),
              const SizedBox(height: 20),
              _buildTile(context, "FINANCIAL AUDIT LEDGER", Icons.analytics, const AuditLedger()),
              _buildTile(context, "LIVESTOCK MARKETPLACE", Icons.account_balance, const LivestockMarketplace()),
              _buildTile(context, "SOCIAL CLUB INTERIOR", Icons.gavel_rounded, const GreatHallScreen()),
              const SizedBox(height: 40),
              const Text("SYSTEM STATUS: SOVEREIGN", style: TextStyle(color: gold, fontSize: 10, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildHeader(String sub) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        backgroundColor: cardGray,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 3)),
              Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSovereignStat(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 2)),
      child: const Column(
        children: [
          Text("TOTAL ECOSYSTEM VALUE", style: TextStyle(color: Colors.white54, fontSize: 12)),
          SizedBox(height: 10),
          Text("\$1,350,000.00", style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          Text("90% SOVEREIGN SHARE PROTECTED", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        tileColor: cardGray,
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios, color: gold, size: 14),
        shape: const Border(left: BorderSide(color: gold, width: 4)),
      ),
    );
  }
}

// --- SCREEN 2: THE FINANCIAL AUDIT LEDGER ---
class AuditLedger extends StatelessWidget {
  const AuditLedger({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIAL AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray, iconTheme: const IconThemeData(color: gold)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("CITY-BY-CITY PERFORMANCE", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          _buildCityAudit("JOHNSTON CO, OK", "\$45,000", "250 FARMERS"),
          _buildCityAudit("ATOKA CO, OK", "\$32,500", "180 FARMERS"),
          _buildCityAudit("MARSHALL CO, OK", "\$28,000", "150 FARMERS"),
          const SizedBox(height: 30),
          const Divider(color: gold),
          const ListTile(
            title: Text("AGENCY PAYOUT (10%)", style: TextStyle(color: Colors.white)),
            trailing: Text("\$10,550.00", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCityAudit(String city, String revenue, String growth) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: cardGray, border: Border(left: BorderSide(color: gold, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(city, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(growth, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ]),
          Text(revenue, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}

// --- SCREEN 3: MARKETPLACE & SOCIAL CLUB ---
class LivestockMarketplace extends StatelessWidget {
  const LivestockMarketplace({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray, iconTheme: const IconThemeData(color: gold)), body: const Center(child: Text("INVENTORY ACTIVE", style: TextStyle(color: Colors.white))));
  }
}

class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("GREAT HALL", style: TextStyle(color: gold)), backgroundColor: cardGray, iconTheme: const IconThemeData(color: gold)), body: const Center(child: Text("INTERIOR SECURE", style: TextStyle(color: Colors.white))));
  }
}
