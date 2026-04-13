import 'package:flutter/material.dart';

// HVF NEXUS CORE V37.0 - THE CREST & COMMAND BUILD
// FLOW: CREST/SIGN-IN -> ROLE SELECTION -> FORKED PATHS W/ SUMMARIES
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

// --- STAGE 1: THE HUMPHREY CREST & OFFICIAL SIGN-IN ---
class HVFCrestSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // REPRESENTING THE HUMPHREY CREST
          const Icon(Icons.shield_rounded, size: 100, color: goldAccent), 
          const SizedBox(height: 20),
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
          const Text("OFFICIAL COMMAND ACCESS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
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

// --- STAGE 2: THE SOVEREIGN FORK (ROLE SELECTION) ---
class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), backgroundColor: pureWhite, elevation: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _buildRoleButton(context, "PRODUCER", Icons.agriculture, ProducerDashboard()),
          _buildRoleButton(context, "BUYER", Icons.person, BuyerDashboard()),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, AgentDashboard()),
          const Spacer(),
          const Text("Each role requires a mandatory Executive Summary before data access.", style: TextStyle(fontSize: 12, color: Colors.black38)),
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

// --- STAGE 3: THE MANDATORY SUMMARY GATE ---
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
          Text("$title EXECUTIVE SUMMARY", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          const Text(
            "By proceeding, you acknowledge the 90/10 Sovereign Settlement, DNA-verified lineage standards, and the HVF SME certification protocol.",
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

// --- STAGE 4: THE FORKED DASHBOARDS ---

class ProducerDashboard extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("PRODUCER CONSOLE")), body: const Center(child: Text("MANAGEMENT & MEDIA UPLOAD")));
}

class BuyerDashboard extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("BUYER VAULT")), body: const Center(child: Text("COLLECTION & MARKET ACCESS")));
}

class AgentDashboard extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AGENT TOUR CONSOLE")),
      body: ListView(children: [
        const ListTile(title: Text("CITY RECRUITMENT STATUS", style: TextStyle(fontWeight: FontWeight.bold))),
        const ListTile(title: Text("PRODUCER ENROLLMENT PORTAL")),
        const ListTile(title: Text("SEED CAPITAL TRACKER (\$500K)")),
      ]),
    );
  }
}
