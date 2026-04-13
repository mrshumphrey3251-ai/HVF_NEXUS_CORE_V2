import 'package:flutter/material.dart';

// HVF NEXUS CORE V44.0 - THE DUAL-PORTAL COMMAND
// INTEGRATED: BUYER VAULT, PRODUCER CONSOLE, & SETTLEMENT GATES
// FOCUS: DUAL-STREAM REVENUE CAPTURE ($200 / $25)
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

// --- STAGE 1: THE HUMPHREY CREST ---
class HVFCrestSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_rounded, size: 100, color: goldAccent), 
          const SizedBox(height: 20),
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
          const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          const TextField(decoration: InputDecoration(labelText: "CEO ACCESS KEY", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoleSelectionScreen())),
            child: const Text("INITIALIZE SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 2: THE SOVEREIGN FORK ---
class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), backgroundColor: pureWhite, elevation: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, ProducerDashboard()),
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, BuyerDashboard()),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, const PlaceholderScreen("AGENT CONSOLE")),
        ]),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExecutiveSummaryGate(title: title, target: target))),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: lightGray, border: Border.all(color: goldAccent, width: 2)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: goldAccent, size: 30),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}

// --- STAGE 3: EXECUTIVE BRIEFING ---
class ExecutiveSummaryGate extends StatelessWidget {
  final String title;
  final Widget target;
  ExecutiveSummaryGate({required this.title, required this.target});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.description, color: goldAccent, size: 50),
          Text("$title BRIEFING", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          const Text(
            "Accessing the Nexus requires acknowledgment of HVF Superior Grading standards and secure DNA-verification protocols.",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => target)),
            child: const Text("AUTHORIZE & PROCEED", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 4A: PRODUCER CONSOLE ---
class ProducerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("PRODUCER CONSOLE"), backgroundColor: pureWhite, elevation: 0),
      body: ListView(children: [
        _buildSectionHeader("INVENTORY COMMAND"),
        _buildNavTile(context, "UPLOAD NEW ASSET", Icons.add_a_photo, const PlaceholderScreen("UPLOAD")),
        _buildNavTile(context, "GRADING TRACKER", Icons.analytics, const PlaceholderScreen("TRACKER")),
        _buildSectionHeader("FINANCIALS"),
        _buildNavTile(context, "LICENSE ACTIVATION (\$200)", Icons.credit_card, const PlaceholderScreen("PAYMENT")),
      ]),
    );
  }
}

// --- STAGE 4B: BUYER VAULT ---
class BuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER VAULT"), backgroundColor: pureWhite, elevation: 0),
      body: ListView(children: [
        _buildSectionHeader("SUPERIOR MARKETPLACE"),
        _buildNavTile(context, "BROWSE LIVE MARKET", Icons.shopping_cart, const PlaceholderScreen("MARKET")),
        _buildSectionHeader("PRIVATE COLLECTION"),
        _buildNavTile(context, "MY SECURED ASSETS", Icons.lock, const PlaceholderScreen("VAULT")),
        _buildNavTile(context, "DNA CERTIFICATES", Icons.verified, const PlaceholderScreen("DNA")),
      ]),
    );
  }
}

// --- SHARED UI HELPERS ---
Widget _buildSectionHeader(String title) {
  return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
}

Widget _buildNavTile(BuildContext context, String label, IconData icon, Widget target) {
  return ListTile(
    leading: Icon(icon, color: goldAccent),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
