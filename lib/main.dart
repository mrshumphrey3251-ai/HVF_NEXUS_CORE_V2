import 'package:flutter/material.dart';

// HVF NEXUS CORE V24.0 - THE INDUSTRIAL CLARITY BUILD
// AESTHETIC: HIGH-CONTRAST WHITE & GOLD (CEO LIGHT MODE)
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFCommandDashboard(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); // High-Polished Gold
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pureWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 5)),
          backgroundColor: pureWhite,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLargeHeader("SOVEREIGN STOCKYARD"),
              const SizedBox(height: 10),
              _buildBigButton(context, "VIRTUAL STOCKYARD", Icons.agriculture, StockyardScreen()),
              _buildBigButton(context, "SITE MAP: SLAB ROAD", Icons.map, PlaceholderScreen("SITE MAP")),
              _buildBigButton(context, "SME ADMIN & SEAL", Icons.gavel_rounded, PlaceholderScreen("SME ADMIN")),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, PlaceholderScreen("FINANCIALS")),
              const SizedBox(height: 40),
              const Text("MARKET STATUS: 850 BUYERS ACTIVE", 
                style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
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
      color: lightGray,
      child: Center(
        child: Text(title, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 24)),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pureWhite, 
            border: Border.all(color: goldAccent, width: 3),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: goldAccent, size: 35),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SECTOR: VIRTUAL STOCKYARD ---
class StockyardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(
        title: const Text("LIVE STOCKYARD", style: TextStyle(color: deepBlack, fontWeight: FontWeight.bold)), 
        backgroundColor: pureWhite,
        iconTheme: const IconThemeData(color: deepBlack),
        elevation: 0,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _buildSummaryBox("MARKET DISCLOSURE: Connecting 500 Producers per city to \$25/mo Buyer community. Total transparency on lineage and health is mandatory."),
        const SizedBox(height: 20),
        const Text("PREMIUM INVENTORY", style: TextStyle(color: goldAccent, fontSize: 22, fontWeight: FontWeight.w900)),
        const Divider(color: deepBlack, thickness: 1),
        _buildAssetCard("BLACK ANGUS #091", "PRODUCER: SMITH FARMS", "GRADE: SUPERIOR", "STATUS: AVAILABLE"),
        _buildAssetCard("HEREFORD UNIT #112", "PRODUCER: DOE RANCH", "GRADE: SUPERIOR", "STATUS: PENDING"),
        const SizedBox(height: 30),
        const Text("BUYER DEMAND", style: TextStyle(color: goldAccent, fontSize: 22, fontWeight: FontWeight.w900)),
        _buildBuyerTicker("ACTIVE BUYERS: JOHNSTON CO.", "850"),
      ]),
    );
  }

  Widget _buildAssetCard(String title, String producer, String grade, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightGray, 
        border: Border(left: BorderSide(color: goldAccent, width: 8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: deepBlack, fontSize: 20, fontWeight: FontWeight.bold)),
              const Icon(Icons.verified, color: goldAccent, size: 25),
            ],
          ),
          Text(producer, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(grade, style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              Text(status, style: TextStyle(color: status == "AVAILABLE" ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerTicker(String label, String count) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: goldAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: pureWhite, fontWeight: FontWeight.bold)),
          Text(count, style: const TextStyle(color: pureWhite, fontSize: 28, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: lightGray, border: Border.all(color: Colors.black12)),
      child: Text(text, style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.5)),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  PlaceholderScreen(this.t, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite, 
      appBar: AppBar(title: Text(t, style: const TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: Center(child: Text("$t SECURE", style: const TextStyle(color: deepBlack, fontSize: 30))),
    );
  }
}
