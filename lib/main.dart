import 'package:flutter/material.dart';

// HVF NEXUS CORE V11.0 - THE TOTAL TRANSPARENCY BUILD
// FEATURE: DEEP-DETAIL DISCLOSURE / SME VERIFIED SPECS
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
        appBar: _buildHeader(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceLockBanner(),
              const SizedBox(height: 20),
              _buildTile(context, "VIRTUAL STOCKYARD", Icons.account_balance, LivestockMarketplace()),
              _buildTile(context, "SME ADMIN PORTAL", Icons.verified_user_sharp, const Scaffold()),
              _buildTile(context, "FINANCIAL AUDIT", Icons.analytics, const Scaffold()),
              const SizedBox(height: 40),
              const Text("DATA TRANSPARENCY: ABSOLUTE", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildHeader() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cardGray,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 4)),
              const Text("SOVEREIGN TRANSPARENCY ENGINE", style: TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceLockBanner() {
    return Container(
      width: double.infinity,
      color: gold.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Text("LEGACY LOCK: $25 BUYER ACCESS ACTIVE", style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
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
        shape: Border.all(color: gold.withOpacity(0.3)),
      ),
    );
  }
}

class LivestockMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildAssetCard(context, "BLACK ANGUS UNIT #001", "Weight: 1,450 lbs", "SME VERIFIED"),
        ],
      ),
    );
  }

  Widget _buildAssetCard(BuildContext context, String title, String weight, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: cardGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
              const Icon(Icons.verified, color: Colors.green, size: 20),
            ],
          ),
          Text(weight, style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white10, height: 30),
          const Text("TOTAL DISCLOSURE LEDGER:", style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildInfoRow("LINEAGE:", "Purebred / Certified"),
          _buildInfoRow("DIET:", "Non-GMO Grass Fed"),
          _buildInfoRow("HEALTH:", "All Vax Current / Nexus Logged"),
          _buildInfoRow("SME NOTES:", "Superior Frame / Calm Temperament"),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {}, 
            child: const Text("SECURE UNIT (\$200/MO PRODUCER LINKED)", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
