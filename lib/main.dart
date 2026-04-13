import 'package:flutter/material.dart';

// HVF NEXUS CORE V46.0 - THE FULL SPECTRUM COMMAND
// INTEGRATED: AGENT TRACKER, PRODUCER CONSOLE, & BUYER VAULT
// FOCUS: SIMULTANEOUS RECRUITMENT & OPERATIONS
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
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, AgentDashboard()),
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, ProducerDashboard()),
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, BuyerDashboard()),
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

// --- STAGE 3: EXECUTIVE BRIEFING GATE ---
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
            "Access requires acknowledgment of the 90/10 Sovereign Settlement and HVF DNA-Verification protocols.",
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

// --- STAGE 4A: AGENT CONSOLE (RECRUITMENT) ---
class AgentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AGENT VELOCITY"), backgroundColor: pureWhite),
      body: ListView(children: [
        _buildSectionHeader("SEED CAPITAL REVENUE"),
        const ListTile(title: Text("CURRENT CAPTURE", style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text("\$58,000.00 / \$500,000.00", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900, fontSize: 20))),
        _buildSectionHeader("CITY RECRUITMENT"),
        const ListTile(title: Text("JOHNSTON COUNTY"), subtitle: Text("145 Producers | 300 Buyers"), trailing: Icon(Icons.trending_up, color: Colors.green)),
        const ListTile(title: Text("MARSHALL COUNTY"), subtitle: Text("88 Producers | 150 Buyers"), trailing: Icon(Icons.trending_up, color: Colors.green)),
      ]),
    );
  }
}

// --- STAGE 4B: PRODUCER CONSOLE (INVENTORY) ---
class ProducerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PRODUCER COMMAND"), backgroundColor: pureWhite),
      body: ListView(children: [
        _buildSectionHeader("ASSET MANAGEMENT"),
        _buildNavTile(context, "UPLOAD NEW ASSET", Icons.add_a_photo),
        _buildNavTile(context, "SME GRADING STATUS", Icons.analytics),
        _buildSectionHeader("LICENSE"),
        _buildNavTile(context, "ACTIVATE LICENSE (\$200)", Icons.credit_card),
      ]),
    );
  }
}

// --- STAGE 4C: BUYER VAULT (ACQUISITION) ---
class BuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BUYER VAULT"), backgroundColor: pureWhite),
      body: ListView(children: [
        _buildSectionHeader("SUPERIOR MARKET"),
        _buildNavTile(context, "BROWSE LIVE MARKET", Icons.shopping_cart),
        _buildSectionHeader("SECURE COLLECTION"),
        _buildNavTile(context, "MY ASSETS", Icons.lock),
        _buildNavTile(context, "DNA CERTIFICATES", Icons.verified),
      ]),
    );
  }
}

// --- SHARED UI HELPERS ---
Widget _buildSectionHeader(String title) {
  return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
}

Widget _buildNavTile(BuildContext context, String label, IconData icon) {
  return ListTile(
    leading: Icon(icon, color: goldAccent),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {}, // Placeholder for sub-navigation
  );
}
