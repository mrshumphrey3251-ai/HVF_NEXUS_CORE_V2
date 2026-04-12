import 'package:flutter/material.dart';

// HVF NEXUS CORE V9.0 - THE SOVEREIGN AUTHORITY BUILD
// INTEGRATED: SME ADMIN PORTAL & BUYER SUBSCRIPTION GATE
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
              _buildStatusRibbon(),
              const SizedBox(height: 20),
              _buildTile(context, "SME ADMIN PORTAL", Icons.verified_user_sharp, const SMEAdminPortal()),
              _buildTile(context, "BUYER SUBSCRIPTION", Icons.shopping_cart_checkout, const BuyerPortal()),
              _buildTile(context, "FARMER ONBOARDING", Icons.agriculture, const OnboardingPortal()),
              _buildTile(context, "FINANCIAL AUDIT", Icons.analytics, const Scaffold()),
              const SizedBox(height: 40),
              const Text("90/10 PROTOCOL: ENFORCED", style: TextStyle(color: gold, fontSize: 10, letterSpacing: 2)),
              const Text("SME CERTIFICATION: ACTIVE", style: TextStyle(color: Colors.white24, fontSize: 10)),
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
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 3)),
              const Text("SOVEREIGN COMMAND CORE", style: TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRibbon() {
    return Container(
      width: double.infinity,
      color: Colors.green.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: const Center(
        child: Text("LEGACY LOCK PRICING ACTIVE | SME SEAL: READY", 
        style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
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
        trailing: const Icon(Icons.arrow_forward_ios, color: gold, size: 12),
        shape: const Border(left: BorderSide(color: gold, width: 4)),
      ),
    );
  }
}

// --- NEW: SME ADMIN PORTAL ---
class SMEAdminPortal extends StatelessWidget {
  const SMEAdminPortal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME VERIFICATION", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("PENDING LISTINGS FOR SEAL", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildSealCard("Angus Unit #091", "Status: Unverified"),
          _buildSealCard("Cedar Timber Lot #12", "Status: Unverified"),
        ],
      ),
    );
  }

  Widget _buildSealCard(String title, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      color: cardGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
            onPressed: () {}, 
            child: const Text("APPLY SME SEAL"),
          ),
        ],
      ),
    );
  }
}

// --- NEW: BUYER PORTAL ---
class BuyerPortal extends StatelessWidget {
  const BuyerPortal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("BUYER SUBSCRIPTION", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, color: gold, size: 80),
            const Text("\$10.00 / MONTH", style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.bold)),
            const Text("LEGACY RATE GUARANTEED", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, minimumSize: const Size(250, 60)),
              onPressed: () {}, 
              child: const Text("SUBSCRIBE NOW", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
