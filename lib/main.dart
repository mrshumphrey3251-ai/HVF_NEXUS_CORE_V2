import 'package:flutter/material.dart';

// HVF NEXUS CORE V49.0 - THE AGENT COMMISSION BUILD
// FEATURE: EXECUTIVE AGENT AGREEMENT & COMMISSION TRACKER
// FOCUS: 40-CITY RECRUITMENT INCENTIVES
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

// --- STAGE 2: ROLE SELECTION ---
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
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, const PlaceholderScreen("PRODUCER")),
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, const PlaceholderScreen("BUYER")),
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
            "Access to the Agent Console requires a signed Commission Agreement. All recruitment activity is tracked for $500K Seed Goal verification.",
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

// --- STAGE 4: AGENT DASHBOARD W/ AGREEMENT ---
class AgentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AGENT TOUR CONSOLE"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: ListView(children: [
        _buildSectionHeader("AGENT LEGAL & COMMISSION"),
        _buildNavTile(context, "VIEW EXECUTIVE COMMISSION AGREEMENT", Icons.gavel, AgentAgreementScreen()),
        _buildSectionHeader("40-CITY OFFENSIVE TRACKER"),
        const ListTile(title: Text("MY TOTAL EARNED COMMISSIONS"), subtitle: Text("\$8,250.00", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20))),
        const ListTile(title: Text("RECRUITMENT PROGRESS"), subtitle: Text("Johnston County: 145/500 Producers")),
      ]),
    );
  }
}

class AgentAgreementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EXECUTIVE AGREEMENT")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("HVF LICENSING AGENT COMMISSION PROTOCOL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: goldAccent)),
          const Divider(height: 40, thickness: 2),
          const Text("1. PRODUCER ENROLLMENT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Text("Agent shall receive a one-time \$50.00 'Field Activation' fee for every Producer license activated (\$200.00).", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          const Text("2. BUYER SUBSCRIPTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Text("Agent shall receive \$5.00 for every Buyer subscription activated (\$25.00).", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          const Text("3. PERFORMANCE BONUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Text("Upon city saturation (500 Producers), Agent receives an additional \$10,000.00 Sovereign Milestone Bonus.", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 40),
          const Text("AUTHORIZATION", style: TextStyle(fontWeight: FontWeight.bold)),
          const TextField(decoration: InputDecoration(labelText: "DIGITAL SIGNATURE")),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.pop(context),
            child: const Text("ACCEPT AGREEMENT", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
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
