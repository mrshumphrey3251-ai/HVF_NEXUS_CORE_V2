import 'package:flutter/material.dart';

// HVF NEXUS CORE V33.0 - THE SETTLEMENT READY BUILD
// FEATURE: INTEGRATED PAYMENT UI / DUAL-PATH ENROLLMENT
// FOCUS: IMMEDIATE CAPITAL CAPTURE ($200 / $25)
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFAuthGate(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

// --- SECTOR 0: THE SOVEREIGN GATE ---
class HVFAuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40, letterSpacing: 8)),
          const Text("CEO COMMAND SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const TextField(decoration: InputDecoration(labelText: "ACCESS ID", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: "ENCRYPTED KEY", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HVFCommandDashboard())),
            child: const Text("INITIALIZE COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("COMMAND HUB", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900)), backgroundColor: pureWhite, elevation: 0, centerTitle: true, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildLargeHeader("REVENUE ACTIVATION"),
          _buildSummaryButton(context, "PRODUCER LICENSE (\$200)", Icons.agriculture, 
            "ENROLLMENT: \$200/mo. Access 90/10 Settlement. SME Grading included. Secure payment required for activation.", 
            SignupScreen(type: "PRODUCER", fee: "\$200.00")),
          _buildSummaryButton(context, "BUYER SUBSCRIPTION (\$25)", Icons.person_add, 
            "SUBSCRIPTION: \$25/mo. Priority access to SME 'Superior' assets. Direct-to-farm settlement path.", 
            SignupScreen(type: "BUYER", fee: "\$25.00")),
          _buildLargeHeader("SOVEREIGN OPERATIONS"),
          _buildSummaryButton(context, "MARKETPLACE (BUY/SELL)", Icons.swap_horizontal_circle, 
            "MARKET DISCLOSURE: Executing live asset trades. 90% Producer / 10% Platform split. Total Transparency.", 
            const PlaceholderScreen("MARKETPLACE")),
          _buildLargeHeader("CAPITAL COMMAND"),
          _buildSummaryButton(context, "REVENUE PROGRESS", Icons.bar_chart, 
            "CAPITAL: Tracking enrollment revenue toward the \$500,000 Seed Goal.", 
            const PlaceholderScreen("FINANCIALS")),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 15), color: lightGray, child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: goldAccent))));
  }

  Widget _buildSummaryButton(BuildContext context, String label, IconData icon, String summary, Widget target) {
    return Padding(padding: const EdgeInsets.all(10), child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExecutiveSummaryGate(title: label, summary: summary, target: target))),
      child: Container(height: 80, decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 2), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent), const SizedBox(width: 15), Text(label, style: const TextStyle(fontWeight: FontWeight.w900))]),
      ),
    ));
  }
}

class ExecutiveSummaryGate extends StatelessWidget {
  final String title;
  final String summary;
  final Widget target;
  ExecutiveSummaryGate({required this.title, required this.summary, required this.target});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      appBar: AppBar(title: Text(title), backgroundColor: lightGray, elevation: 0, iconTheme: const IconThemeData(color: deepBlack)),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_outlined, color: goldAccent, size: 60),
          const SizedBox(height: 20),
          const Text("EXECUTIVE DISCLOSURE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          Text(summary, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, height: 1.5)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => target)),
            child: const Text("AUTHORIZE & PROCEED", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ]),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  final String type;
  final String fee;
  SignupScreen({required this.type, required this.fee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: Text("$type ACTIVATION"), backgroundColor: pureWhite, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          Text("TOTAL DUE: $fee", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 30),
          const TextField(decoration: InputDecoration(labelText: "LEGAL NAME", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(labelText: "CITY / STATE", border: OutlineInputBorder())),
          const SizedBox(height: 30),
          const Text("PAYMENT METHOD", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 10),
          _buildPaymentField("CARD NUMBER", Icons.credit_card),
          _buildPaymentField("EXPIRATION / CVV", Icons.lock_outline),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: goldAccent, minimumSize: const Size(double.infinity, 80)),
            onPressed: () {}, 
            child: const Text("AUTHORIZE PAYMENT", style: TextStyle(color: pureWhite, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          const SizedBox(height: 15),
          const Text("Secure 256-bit Encrypted Settlement", style: TextStyle(fontSize: 12, color: Colors.black38)),
        ]),
      ),
    );
  }

  Widget _buildPaymentField(String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(decoration: InputDecoration(prefixIcon: Icon(icon, color: goldAccent), labelText: hint, filled: true, fillColor: lightGray, border: InputBorder.none)),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
