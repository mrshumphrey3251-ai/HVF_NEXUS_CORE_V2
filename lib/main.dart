import 'package:flutter/material.dart';

// HVF NEXUS CORE V39.0 - THE VELOCITY BUILD
// FEATURE: CITY SATURATION TRACKER (500 PRODUCER GOAL)
// PURPOSE: ACCELERATE $500K SEED VIA MULTI-CITY OFFENSIVE
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

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), backgroundColor: pureWhite, elevation: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _buildRoleButton(context, "PRODUCER", Icons.agriculture, const PlaceholderScreen("PRODUCER PORTAL")),
          _buildRoleButton(context, "BUYER", Icons.person, const PlaceholderScreen("BUYER PORTAL")),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, AgentVelocityDashboard()),
        ]),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
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

class AgentVelocityDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("AGENT VELOCITY"), backgroundColor: pureWhite, elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("CITY SATURATION (GOAL: 500)", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const SizedBox(height: 20),
        _buildCityProgress("MADILL, OK", 125), // 25% of goal
        _buildCityProgress("TISHOMINGO, OK", 45), 
        _buildCityProgress("DURANT, OK", 10),
        const SizedBox(height: 40),
        const Text("ESTIMATED MONTHLY REVENUE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        const Text("\$45,000.00", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
        const Text("Current combined Producer/Buyer trajectory.", style: TextStyle(fontSize: 12, color: Colors.black38)),
      ]),
    );
  }

  Widget _buildCityProgress(String city, int count) {
    double progress = count / 500;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(city, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("$count / 500", style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress, minHeight: 10, color: goldAccent, backgroundColor: lightGray),
      ]),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
