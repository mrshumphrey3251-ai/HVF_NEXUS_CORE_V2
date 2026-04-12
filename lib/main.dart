import 'package:flutter/material.dart';

// HVF NEXUS CORE V5.0 - THE ALL-POWERFUL EXECUTIVE COMMAND
// STYLE: EXPENSIVE INDUSTRIAL / SOVEREIGN GOLD / DEEP SLATE
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

class HVFCommandDashboard extends StatelessWidget {
  const HVFCommandDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A), // Deep Industrial Black
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: const Color(0xFF1A1A1A),
            elevation: 20,
            flexibleSpace: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "HVF NEXUS",
                    style: TextStyle(
                      color: Color(0xFFFFD700), // Sovereign Gold
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      letterSpacing: 4.0,
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 150,
                    color: const Color(0xFFFFD700),
                  ),
                  const Text(
                    "AUDIT & COMMAND CORE",
                    style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              _buildSovereignButton(
                context, 
                "LIVESTOCK MARKETPLACE", 
                Icons.account_balance, 
                const LivestockMarketplace()
              ),
              const SizedBox(height: 20),
              _buildSovereignButton(
                context, 
                "SOCIAL CLUB INTERIOR", 
                Icons.gavel_rounded, 
                const GreatHallScreen()
              ),
              const SizedBox(height: 60),
              const Icon(Icons.security, color: Color(0xFFFFD700), size: 40),
              const Text(
                "90/10 REVENUE PROTOCOL ACTIVE",
                style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const Text(
                "SOVEREIGN DATA ENCRYPTION: VERIFIED",
                style: TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSovereignButton(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border.all(color: const Color(0xFFFFD700), width: 2),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))
            ],
          ),
          child: Row(
            children: [
              Container(width: 10, color: const Color(0xFFFFD700)),
              const SizedBox(width: 20),
              Icon(icon, color: const Color(0xFFFFD700), size: 30),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LivestockMarketplace extends StatelessWidget {
  const LivestockMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          title: const Text("VIRTUAL STOCKYARD", style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1A1A1A),
          iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildIndustrialAssetCard("BLACK ANGUS BULL", "ID: HVF-001", "1,450 LBS", "VERIFIED"),
            _buildIndustrialAssetCard("HEIFER BATCH", "ID: HVF-002", "800 LBS AVG", "VERIFIED"),
            _buildIndustrialAssetCard("BOER GOAT UNITS", "ID: HVF-003", "READY", "SME CERTIFIED"),
          ],
        ),
      ),
    );
  }

  Widget _buildIndustrialAssetCard(String title, String id, String data, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              Text(title, style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 18)),
              Text(status, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.white10),
          Text(id, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 5),
          Text(data, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}

class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("SOCIAL CLUB INTERIOR", style: TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: const Center(child: Text("ASSET INTERIOR LOADED", style: TextStyle(color: Color(0xFFFFD700)))),
    );
  }
}
