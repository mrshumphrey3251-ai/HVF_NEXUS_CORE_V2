import 'package:flutter/material.dart';

// HVF NEXUS CORE V23.1 - THE MARKET REALITY BUILD
// FIXED: REMOVED INVALID CONST CONSTRUCTORS 
// FEATURE: VIRTUAL STOCKYARD / PRODUCER & BUYER VISIBILITY
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
              _buildLargeHeader("SOVEREIGN STOCKYARD"),
              _buildBigButton(context, "VIRTUAL STOCKYARD", Icons.agriculture, StockyardScreen()),
              _buildBigButton(context, "SITE MAP: SLAB ROAD", Icons.map, PlaceholderScreen("SITE MAP")),
              _buildBigButton(context, "SME ADMIN & SEAL", Icons.gavel_rounded, PlaceholderScreen("SME ADMIN")),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, PlaceholderScreen("FINANCIALS")),
              const SizedBox(height: 40),
              const Text("MARKET STATUS: 850 BUYERS ACTIVE", 
                style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
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

// --- SECTOR: VIRTUAL STOCKYARD (THE SELLING POINT) ---
class StockyardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("LIVE STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _buildSummaryBox("MARKET DISCLOSURE: Connecting 500 Producers per city to \$25/mo Buyer community. Total transparency on lineage and health is mandatory."),
        const SizedBox(height: 20),
        const Text("PREMIUM INVENTORY", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.w900)),
        const Divider(color: gold, thickness: 2),
        _buildAssetCard("BLACK ANGUS #091", "PRODUCER: SMITH FARMS", "GRADE: SUPERIOR", "STATUS: AVAILABLE"),
        _buildAssetCard("HEREFORD UNIT #112", "PRODUCER: DOE RANCH", "GRADE: SUPERIOR", "STATUS: PENDING"),
        const SizedBox(height: 30),
        const Text("BUYER DEMAND", style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.w900)),
        _buildBuyerTicker("ACTIVE BUYERS: JOHNSTON CO.", "850"),
      ]),
    );
  }

  Widget _buildAssetCard(String title, String producer, String grade, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Icon(Icons.verified, color: Colors.green, size: 25),
            ],
          ),
          Text(producer, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(grade, style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
              Text(status, style: TextStyle(color: status == "AVAILABLE" ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerTicker(String label, String count) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: gold.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(count, style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: gold.withOpacity(0.05), border: Border.all(color: gold.withOpacity(0.3))),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5, fontStyle: FontStyle.italic)),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  PlaceholderScreen(this.t, {super.key}); // Const removed to prevent build errors
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack, 
      appBar: AppBar(title: Text(t, style: const TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(child: Text("$t SECURE", style: const TextStyle(color: Colors.white, fontSize: 30))),
    );
  }
}
