import 'package:flutter/material.dart';

// HVF NEXUS CORE V60.0 - THE SOVEREIGN DECISION ENGINE
// FEATURE: CEO APPROVAL WORKFLOW & SME DATA VERIFICATION
// STATUS: 100% UNIFIED | BUYER + PRODUCER + CEO COMMAND
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
            _roleCard(context, "CEO COMMAND DESK", Icons.admin_panel_settings, const CEODashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerDashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerDashboard()),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Widget target) {
    return SizedBox(width: 350, child: Card(color: warmBeige, child: ListTile(
      leading: Icon(icon, color: goldAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
    )));
  }
}

// --- 3. THE CEO COMMAND DESK & DECISION ENGINE ---
class CEODashboard extends StatelessWidget {
  const CEODashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND", style: TextStyle(color: goldAccent)), iconTheme: const IconThemeData(color: goldAccent)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("PENDING SME ACTIONS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 20),
          _decisionCard(context, "ASSET INDUCTION: #ANGUS-77", "DNA Verified - Awaiting Signature", Icons.biotech),
          _decisionCard(context, "EXTENSION: BUYER-404", "14-Day Grace Period Requested", Icons.timer),
        ],
      ),
    );
  }

  Widget _decisionCard(BuildContext context, String title, String sub, IconData icon) {
    return Card(
      color: const Color(0xFF2A2A2A),
      child: ListTile(
        leading: Icon(icon, color: goldAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        onTap: () => _showDecisionModal(context, title),
      ),
    );
  }

  void _showDecisionModal(BuildContext context, String title) {
    showModalBottomSheet(
      backgroundColor: deepBlack,
      context: context, 
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(title, style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          const Text("EXECUTE SME AUTHORITY", style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900, minimumSize: const Size(double.infinity, 50)),
            onPressed: () => Navigator.pop(context),
            child: const Text("APPROVE AS SUPERIOR", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red), minimumSize: const Size(double.infinity, 50)),
            onPressed: () => Navigator.pop(context),
            child: const Text("REJECT / RE-EVALUATE", style: TextStyle(color: Colors.red)),
          ),
        ]),
      ),
    );
  }
}

// --- 4. PRODUCER CONSOLE (STABILIZED) ---
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
          const Text("ASSET INDUCTION", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent)),
          Card(child: ListTile(
            leading: const Icon(Icons.add_a_photo, color: goldAccent),
            title: const Text("UPLOAD NEW ASSET", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          )),
        ],
      ),
    );
  }
}

// --- 5. BUYER VAULT (STABILIZED) ---
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
          Center(child: Text("Live Marketplace Ready")),
          Center(child: Text("Sovereign Assets Secured")),
        ]),
      ),
    );
  }
}
