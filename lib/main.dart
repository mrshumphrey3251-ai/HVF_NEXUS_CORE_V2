import 'package:flutter/material.dart';

// HVF NEXUS CORE V36.0 - THE CONVERSION FUNNEL BUILD
// FLOW: V88 DASHBOARD -> DISCLOSURE -> SIGN-IN -> PAYMENT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFCommandDashboard(), // Starts at the Dashboard to "Hook" the user
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

// --- STAGE 1: THE V88 "HOOK" DASHBOARD ---
class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(
        title: const Text("HVF NEXUS", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 30, letterSpacing: 4)),
        backgroundColor: pureWhite, elevation: 0, centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildLargeHeader("SOVEREIGN COMMAND CENTER"),
          _buildStrategicButton(context, "MARKETPLACE: BUY/SELL", Icons.swap_horizontal_circle),
          _buildStrategicButton(context, "PRODUCER: UPLOAD ASSETS", Icons.add_a_photo),
          _buildStrategicButton(context, "FINANCIAL COMMAND", Icons.account_balance),
          const SizedBox(height: 40),
          const Text("GOAL: \$500,000 SEED CAPITAL", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 20), color: lightGray, child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: goldAccent))));
  }

  Widget _buildStrategicButton(BuildContext context, String label, IconData icon) {
    return Padding(padding: const EdgeInsets.all(12), child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExecutiveDisclosureGate(goal: label))),
      child: Container(height: 85, decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 3), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent, size: 30), const SizedBox(width: 20), Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18))]),
      ),
    ));
  }
}

// --- STAGE 2: THE EXECUTIVE DISCLOSURE ---
class ExecutiveDisclosureGate extends StatelessWidget {
  final String goal;
  ExecutiveDisclosureGate({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield, color: goldAccent, size: 60),
          const Text("EXECUTIVE DISCLOSURE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          Text("Accessing $goal requires SME authorization. By proceeding, you acknowledge the 90/10 Sovereign Settlement and HVF Superior Grading standards.", textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInGate())),
            child: const Text("I AUTHORIZE & PROCEED", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 3: THE SIGN-IN ---
class SignInGate extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("IDENTITY VERIFICATION"), backgroundColor: pureWhite, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const Text("SELECT YOUR ROLE", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
          const SizedBox(height: 30),
          TextField(controller: _controller, decoration: const InputDecoration(labelText: "ACCESS ID (PRODUCER / BUYER)", border: OutlineInputBorder())),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: goldAccent, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(role: _controller.text.toUpperCase()))),
            child: const Text("CONFIRM ROLE", style: TextStyle(color: pureWhite, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 4: THE BUY-IN (PAYMENT) ---
class PaymentScreen extends StatelessWidget {
  final String role;
  PaymentScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    String fee = role.contains("PRODUCER") ? "\$200.00" : "\$25.00";

    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: Text("$role ACTIVATION"), backgroundColor: pureWhite),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Text("LICENSE ACTIVATION FEE: $fee", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 40),
          const TextField(decoration: InputDecoration(labelText: "CARDHOLDER NAME", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(labelText: "CREDIT CARD NUMBER", border: OutlineInputBorder())),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () {
              // Final confirmation logic here
            },
            child: const Text("AUTHORIZE PAYMENT", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          const SizedBox(height: 10),
          const Text("SECURE SOVEREIGN SETTLEMENT", style: TextStyle(fontSize: 10, color: Colors.black38)),
        ]),
      ),
    );
  }
}
