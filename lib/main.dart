import 'package:flutter/material.dart';

// HVF NEXUS CORE V6.1 - THE LEGACY LOCK BUILD
// ARCHITECTURE: FIXED-RATE SOVEREIGNTY (NO PRICE CREEP)
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
        appBar: _buildHeader(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildPriceLockBanner(),
              const SizedBox(height: 20),
              _buildTile(context, "LIVESTOCK MARKETPLACE", Icons.account_balance, const LivestockMarketplace()),
              _buildTile(context, "LOGISTICS & TRANSIT", Icons.local_shipping, const Scaffold()),
              _buildTile(context, "SOCIAL CLUB INTERIOR", Icons.gavel_rounded, const Scaffold()),
              const SizedBox(height: 40),
              const Text("90/10 REVENUE PROTOCOL: LOCKED", style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildHeader() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        backgroundColor: cardGray,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 28, letterSpacing: 4)),
              Container(height: 2, width: 140, color: gold),
              const Text("SOVEREIGN COMMAND CORE", style: TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceLockBanner() {
    return Container(
      width: double.infinity,
      color: Colors.green.withOpacity(0.1),
      padding: const EdgeInsets.all(15),
      child: const Column(
        children: [
          Text("LEGACY PRICE PROTECTION ACTIVE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          Text("Rates Guaranteed for Life of Membership", style: TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        tileColor: cardGray,
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: Border.all(color: gold, width: 1),
      ),
    );
  }
}

class LivestockMarketplace extends StatelessWidget {
  const LivestockMarketplace({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("VIRTUAL STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("FARMER SUBSCRIPTION: \$100/MO (LOCKED)", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          const Text("BUYER SUBSCRIPTION: \$10/MO (LOCKED)", style: TextStyle(color: Colors.white70, fontSize: 12)),
          const Divider(color: gold, height: 30),
          _buildEntry("ANGUS UNIT HVF-001", "1,450 LBS", "VERIFIED"),
          _buildEntry("HEIFER BATCH HVF-002", "800 LBS AVG", "VERIFIED"),
        ],
      ),
    );
  }

  Widget _buildEntry(String title, String weight, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      color: cardGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(weight, style: const TextStyle(color: Colors.white54)),
            ],
          ),
          Text(status, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
