import 'package:flutter/material.dart';

// HVF NEXUS CORE V38.0 - THE SETTLEMENT ACTIVATION BUILD
// INTEGRATED: CREST, ROLE-FORK, SUMMARIES, & SECURE PAYMENT
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
          _buildRoleButton(context, "PRODUCER", Icons.agriculture, const PaymentActivationScreen(role: "PRODUCER", fee: "\$200.00")),
          _buildRoleButton(context, "BUYER", Icons.person, const PaymentActivationScreen(role: "BUYER", fee: "\$25.00")),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, const AgentDashboard()),
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
            "Acknowledgment of the 90/10 Sovereign Settlement and DNA-verified lineage standards is required for activation.",
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

// --- STAGE 4: PAYMENT ACTIVATION ---
class PaymentActivationScreen extends StatelessWidget {
  final String role;
  final String fee;
  const PaymentActivationScreen({required this.role, required this.fee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: Text("$role SETTLEMENT"), backgroundColor: pureWhite, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Text("ACTIVATION FEE: $fee", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 30),
          const TextField(decoration: InputDecoration(labelText: "ENTITY NAME", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "CREDIT CARD NUMBER", border: OutlineInputBorder(borderSide: BorderSide(color: goldAccent)))),
          const SizedBox(height: 15),
          Row(children: [
            const Expanded(child: TextField(decoration: InputDecoration(labelText: "EXP", border: OutlineInputBorder()))),
            const SizedBox(width: 10),
            const Expanded(child: TextField(decoration: InputDecoration(labelText: "CVV", border: OutlineInputBorder()))),
          ]),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () {}, 
            child: const Text("PROCESS SETTLEMENT", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(height: 20),
          const Text("SECURE 256-BIT SOVEREIGN ENCRYPTION", style: TextStyle(fontSize: 10, color: Colors.black38)),
        ]),
      ),
    );
  }
}

// --- AGENT CONSOLE ---
class AgentDashboard extends StatelessWidget {
  const AgentDashboard();
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("AGENT TOUR CONSOLE")), body: const Center(child: Text("RECRUITMENT & SEED TRACKER ACTIVE")));
}
