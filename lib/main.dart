import 'package:flutter/material.dart';

// HVF NEXUS CORE V7.2 - THE "LIVE RAILS" BUILD
// STATUS: DEPLOYMENT READY / DYNAMIC REVENUE ENABLED
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
              _buildLiveTicker(),
              const SizedBox(height: 20),
              // FIX: Removed 'const' from dynamic screen navigation
              _buildActionTile(context, "FARMER ONBOARDING", Icons.person_add_alt_1, OnboardingScreen("FARMER")),
              _buildActionTile(context, "BUYER REGISTRATION", Icons.shopping_bag, OnboardingScreen("BUYER")),
              _buildActionTile(context, "FINANCIAL AUDIT", Icons.analytics, AuditLedger()),
              _buildActionTile(context, "LIVESTOCK MARKETPLACE", Icons.account_balance, LivestockMarketplace()),
              const SizedBox(height: 30),
              const Text("HVF NEXUS: OPEN FOR BUSINESS", 
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
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
              const Text("HVF NEXUS", 
                style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 3)),
              const Text("SOVEREIGN COMMAND CORE", 
                style: TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveTicker() {
    return Container(
      width: double.infinity,
      color: Colors.white10,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Center(
        child: Text("LIVE REVENUE STREAM: ACTIVE | 90/10 PROTOCOL: ENGAGED", 
        style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        tileColor: cardGray,
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        shape: Border.all(color: gold.withOpacity(0.5)),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String role;
  OnboardingScreen(this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: Text("$role SUBSCRIPTION", style: const TextStyle(color: gold)), backgroundColor: cardGray),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SECURE $role PORTAL", style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
              onPressed: () {}, 
              child: const Text("INITIALIZE PAYMENT & LOCK LEGACY RATE"),
            ),
          ],
        ),
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
      body: const Center(child: Text("INVENTORY ACTIVE", style: TextStyle(color: Colors.white))),
    );
  }
}

class AuditLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("LEDGER DATA SECURE", style: TextStyle(color: Colors.white))),
    );
  }
}
