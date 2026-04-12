import 'package:flutter/material.dart';

// HVF NEXUS CORE V15.0 - THE SOVEREIGN HANDSHAKE BUILD
// FEATURE: DIGITAL DEED / ESCROW SETTLEMENT / NO-LOGISTICS MODEL
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
              _buildLargeHeader("TRANSACTION HUB"),
              _buildBigButton(context, "DIGITAL DEEDS", Icons.verified, DigitalDeedScreen()),
              _buildBigButton(context, "PENDING SETTLEMENTS", Icons.handshake, const PlaceholderScreen("SETTLEMENTS")),
              _buildBigButton(context, "FINANCIALS", Icons.payments, const PlaceholderScreen("FINANCIALS")),
              const SizedBox(height: 40),
              const Text("CEO PROTOCOL: TRANSACTION OVERSIGHT ONLY", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
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

// --- NEW: DIGITAL DEED (THE PROOF OF SOVEREIGNTY) ---
class DigitalDeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("DIGITAL DEED", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 28)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDeedCard("DEED #HVF-0001", "ANGUS UNIT #001", "STATUS: SETTLED"),
          const SizedBox(height: 30),
          _buildDeedCard("DEED #HVF-0002", "CEDAR LOT #12", "STATUS: ESCROW"),
        ],
      ),
    );
  }

  Widget _buildDeedCard(String deedNo, String asset, String status) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(deedNo, style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Text(asset, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(color: gold, height: 30),
          Text(status, style: TextStyle(color: status.contains("SETTLED") ? Colors.green : Colors.orange, fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          const Text("AUTHORITY: JEFFERY D. HUMPHREY", style: TextStyle(color: Colors.white38, fontSize: 10)),
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
