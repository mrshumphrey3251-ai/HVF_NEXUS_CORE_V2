import 'package:flutter/material.dart';

// HVF NEXUS CORE V10.1 - THE PREMIUM SOVEREIGN BUILD (DYNAMIC)
// RATES: $200 FARMER / $25 BUYER (LOCKED FOREVER)
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
              _buildTile(context, "SME ADMIN PORTAL", Icons.verified_user_sharp, SMEAdminPortal()),
              _buildTile(context, "FARMER SUBSCRIPTION (\$200)", Icons.agriculture, OnboardingPortal("FARMER", "\$200")),
              _buildTile(context, "BUYER SUBSCRIPTION (\$25)", Icons.shopping_cart_checkout, OnboardingPortal("BUYER", "\$25")),
              _buildTile(context, "FINANCIAL AUDIT", Icons.analytics, AuditLedger()),
              const SizedBox(height: 40),
              const Text("90/10 REVENUE ARCHITECTURE: ACTIVE", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const Text("SOVEREIGNTY STATUS: VERIFIED", 
                style: TextStyle(color: Colors.white24, fontSize: 10)),
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
              const Text("PREMIUM COMMAND CORE", style: TextStyle(color: Colors.white54, fontSize: 10)),
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
      padding: const EdgeInsets.all(15),
      child: const Column(
        children: [
          Text("LEGACY PRICE PROTECTION: GUARANTEED", style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          Text("Rates Fixed Permanently by Sovereign Decree", style: TextStyle(color: Colors.white54, fontSize: 10)),
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
        trailing: const Icon(Icons.arrow_forward_ios, color: gold, size: 12),
        shape: Border.all(color: gold.withOpacity(0.3)),
      ),
    );
  }
}

class OnboardingPortal extends StatelessWidget {
  final String role;
  final String rate;
  OnboardingPortal(this.role, this.rate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: Text("$role ACCESS", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOCKED LEGACY RATE: $rate/MO", style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Non-Escalating Membership Agreement", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(280, 70)),
              onPressed: () {}, 
              child: const Text("INITIALIZE SOVEREIGN LINK", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class SMEAdminPortal extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("SME SEAL", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
class AuditLedger extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }
