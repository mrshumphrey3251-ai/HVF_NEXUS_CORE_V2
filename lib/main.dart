import 'package:flutter/material.dart';

// HVF NEXUS CORE V58.1 - COMPILER STABILIZATION
// FIX: REMOVED NON-ASCII CHARACTERS & REPAIRED STRING TERMINATION
// FOCUS: CLEAN WEB BUILD FOR DEMO CONTINUITY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color certificateGold = Color(0xFFD4AF37);

// --- 1. THE SOVEREIGN ENTRANCE ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
                const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: 4)),
                const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, letterSpacing: 2)),
                const SizedBox(height: 50),
                const TextField(decoration: InputDecoration(labelText: "ACCESS ID", border: OutlineInputBorder())),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen())),
                  child: const Text("INITIALIZE SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. THE ROLE FORK ---
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            _roleCard(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerDashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerDashboard()),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Widget target) {
    return SizedBox(
      width: 350,
      child: Card(
        color: warmBeige,
        child: ListTile(
          leading: Icon(icon, color: goldAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        ),
      ),
    );
  }
}

// --- 3. THE PRODUCER CONSOLE (INDUCTION ACTIVE) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER COMMAND")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("ASSET INDUCTION", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent, letterSpacing: 1.5)),
          const SizedBox(height: 10),
          _actionTile(context, "UPLOAD NEW ASSET", Icons.add_a_photo, "Initialize SME Grading", const AssetInductionScreen()),
          _actionTile(context, "SME GRADING STATUS", Icons.analytics, "Review Superior standards", null),
          const Divider(height: 40),
          const Text("OPERATIONAL STATUS", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent, letterSpacing: 1.5)),
          const ListTile(
            tileColor: Colors.white,
            title: Text("Producer License (\$200/mo)"),
            subtitle: Text("Status: ACTIVE"),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _actionTile(BuildContext context, String label, IconData icon, String sub, Widget? target) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: goldAccent),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 10)),
        onTap: () {
          if (target != null) Navigator.push(context, MaterialPageRoute(builder: (context) => target));
        },
      ),
    );
  }
}

// --- ASSET INDUCTION SCREEN ---
class AssetInductionScreen extends StatelessWidget {
  const AssetInductionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ASSET INDUCTION")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("SME LIVESTOCK DATA ENTRY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: goldAccent)),
          const SizedBox(height: 30),
          const TextField(decoration: InputDecoration(labelText: "BREED", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "DNA TAG IDENTIFIER", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          const Row(children: [
            Expanded(child: TextField(decoration: InputDecoration(labelText: "AGE", border: OutlineInputBorder()))),
            SizedBox(width: 20),
            Expanded(child: TextField(decoration: InputDecoration(labelText: "WEIGHT", border: OutlineInputBorder()))),
          ]),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
            onPressed: () => Navigator.pop(context),
            child: const Text("SUBMIT FOR SME REVIEW", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- 4. THE BUYER DASHBOARD ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: const Text("BUYER VAULT"),
          bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [
            Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
            Tab(text: "MY ASSETS", icon: Icon(Icons.lock)),
          ]),
        ),
        body: const TabBarView(children: [
          Center(child: Text("SME Marketplace Active")),
          Center(child: Text("Asset Vault Secured")),
        ]),
      ),
    );
  }
}
