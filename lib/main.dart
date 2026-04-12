import 'package:flutter/material.dart';

// HVF NEXUS CORE V32.0 - THE REVENUE RECRUITMENT BUILD
// PIVOT: REMOVED SLAB ROAD / ADDED DUAL SIGNUP PORTALS
// FOCUS: $500K SEED CAPITAL GENERATION
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
          _buildLargeHeader("RECRUITMENT & REVENUE"),
          _buildSummaryButton(context, "PRODUCER ENROLLMENT", Icons.agriculture, 
            "ENROLLMENT DISCLOSURE: \$200/mo License Fee. Direct access to SME Grading and the 90/10 Sovereign Settlement protocol.", 
            SignupScreen(type: "PRODUCER", fee: "\$200/mo")),
          _buildSummaryButton(context, "BUYER SUBSCRIPTION", Icons.person_add, 
            "SUBSCRIPTION DISCLOSURE: \$25/mo Access Fee. Secured priority on SME 'Superior' Grade local assets.", 
            SignupScreen(type: "BUYER", fee: "\$25/mo")),
          _buildLargeHeader("SOVEREIGN OPERATIONS"),
          _buildSummaryButton(context, "MARKETPLACE (BUY/SELL)", Icons.swap_horizontal_circle, 
            "MARKET DISCLOSURE: Live asset transactions with 90/10 split. Projected \$5.8M monthly gross at saturation.", 
            const PlaceholderScreen("MARKETPLACE")),
          _buildSummaryButton(context, "UPLOAD MEDIA", Icons.add_a_photo, 
            "BIO-DATA DISCLOSURE: Mandatory media for SME grading. Lineage and health verification required.", 
            const PlaceholderScreen("MEDIA UPLOAD")),
          _buildLargeHeader("CAPITAL TRACKER"),
          _buildSummaryButton(context, "SEED FUNDING PROGRESS", Icons.bar_chart, 
            "CAPITAL DISCLOSURE: Tracking progress toward the \$500,000 Seed Capital goal via enrollment fees.", 
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
          const Icon(Icons.description, color: goldAccent, size: 60),
          const SizedBox(height: 20),
          const Text("EXECUTIVE SUMMARY", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          Text(summary, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, height: 1.5)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => target)),
            child: const Text("PROCEED TO COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
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
      appBar: AppBar(title: Text("$type SIGNUP")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          Text("$type LICENSE: $fee", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: goldAccent)),
          const SizedBox(height: 30),
          const TextField(decoration: InputDecoration(labelText: "LEGAL NAME / ENTITY", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(labelText: "CONTACT NUMBER", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(labelText: "CITY / COUNTY", border: OutlineInputBorder())),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () {}, 
            child: const Text("SUBMIT ENROLLMENT", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
