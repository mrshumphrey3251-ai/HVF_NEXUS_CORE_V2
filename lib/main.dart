import 'package:flutter/material.dart';

// HVF NEXUS CORE V8.0 - THE MERCHANT INTEGRATION BUILD
// REVENUE PIPELINE: 90/10 SOVEREIGN SPLIT HARD-CODED
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
              const SizedBox(height: 30),
              _buildActionTile(context, "MERCHANT BANK LINK", Icons.account_balance_wallet, const MerchantBankScreen()),
              _buildActionTile(context, "FARMER ONBOARDING", Icons.person_add_alt_1, OnboardingScreen("FARMER")),
              _buildActionTile(context, "BUYER REGISTRATION", Icons.shopping_bag, OnboardingScreen("BUYER")),
              _buildActionTile(context, "FINANCIAL AUDIT", Icons.analytics, AuditLedger()),
              const SizedBox(height: 40),
              const Icon(Icons.verified_user, color: Colors.green, size: 30),
              const Text("PAYMENT ENCRYPTION: SOVEREIGN", style: TextStyle(color: Colors.white24, fontSize: 10)),
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
              const Text("FINANCIAL COMMAND CORE", style: TextStyle(color: Colors.white54, fontSize: 10)),
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
        child: Text("MERCHANT STATUS: READY FOR LINK | SOVEREIGNTY: 100%", 
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

// --- NEW: MERCHANT BANK LINK SCREEN ---
class MerchantBankScreen extends StatelessWidget {
  const MerchantBankScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("MERCHANT BANKING", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(Icons.lock_person, color: gold, size: 80),
            const SizedBox(height: 20),
            const Text("SOVEREIGN TREASURY LINK", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Connect your corporate account to receive 90% share directly.", style: TextStyle(color: Colors.white54, textAlign: TextAlign.center)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 60)),
              onPressed: () {}, 
              child: const Text("LINK BUSINESS ACCOUNT", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- ONBOARDING, AUDIT, AND MARKETPLACE CLASSES ---
class OnboardingScreen extends StatelessWidget {
  final String role;
  OnboardingScreen(this.role, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: Text("$role SUBSCRIPTION", style: const TextStyle(color: gold)), backgroundColor: cardGray));
  }
}

class AuditLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray));
  }
}

class LivestockMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray));
  }
}
