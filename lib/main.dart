import 'package:flutter/material.dart';

// HVF NEXUS CORE V30.0 - THE FULL SOVEREIGNTY BUILD
// INTEGRATED: AUTH GATE, MEDIA UPLOAD, MARKETPLACE, INFRASTRUCTURE, & FINANCIALS
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
      appBar: AppBar(title: const Text("HVF COMMAND HUB", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900)), backgroundColor: pureWhite, elevation: 0, centerTitle: true, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildLargeHeader("SOVEREIGN ASSETS"),
          _buildBigButton(context, "MARKETPLACE (BUY/SELL)", Icons.swap_horizontal_circle, MarketHub()),
          _buildBigButton(context, "UPLOAD MEDIA (PICS/VIDEO)", Icons.add_a_photo, MediaUploadScreen()),
          _buildLargeHeader("PROJECT INFRASTRUCTURE"),
          _buildBigButton(context, "SLAB ROAD SITE PLAN", Icons.architecture, SitePlanScreen()),
          _buildBigButton(context, "HELIOGRID POWER STATS", Icons.solar_power, PowerScreen()),
          _buildLargeHeader("FINANCIAL COMMAND"),
          _buildBigButton(context, "REVENUE & SEED TRACKER", Icons.bar_chart, FinancialScreen()),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 15), color: lightGray, child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: goldAccent))));
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(padding: const EdgeInsets.all(10), child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Container(height: 80, decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 2), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent), const SizedBox(width: 15), Text(label, style: const TextStyle(fontWeight: FontWeight.w900))]),
      ),
    ));
  }
}

// --- ALL ROOMS HARD-WIRED BELOW ---

class MarketHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: const Text("MARKETPLACE"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text("90/10 SOVEREIGN SETTLEMENT ACTIVE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
      const Divider(),
      _tile("ANGUS #044", "\$2,450", "Verified SME Grade"),
      _tile("HEREFORD #102", "\$2,100", "Pending Grading"),
    ]));
  }
  Widget _tile(String t, String p, String s) => ListTile(title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(s), trailing: Text(p, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)));
}

class MediaUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: const Text("ASSET MEDIA"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      Container(height: 250, width: double.infinity, color: lightGray, child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_upload, color: goldAccent, size: 50), Text("UPLOAD PICS/VIDEO FOR SME GRADING")])),
      const SizedBox(height: 20),
      const TextField(decoration: InputDecoration(labelText: "UNIT ID / LINEAGE DATA", border: OutlineInputBorder())),
      const Spacer(),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: goldAccent, minimumSize: const Size(double.infinity, 70)), onPressed: () {}, child: const Text("SUBMIT TO CEO FOR SEAL", style: TextStyle(color: pureWhite, fontWeight: FontWeight.bold))),
    ])));
  }
}

class SitePlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: const Text("SLAB ROAD MAP"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text("200-ACRE MASTER BLUEPRINT", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
      const Text("• 200 Housing Units\n• 25-Acre Reservoir\n• Autonomous Pathways", style: TextStyle(height: 2)),
    ]));
  }
}

class PowerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: const Text("HELIOGRID"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.bolt, color: goldAccent, size: 80),
      Text("94.2 kW", style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900)),
      Text("SYSTEM OUTPUT: OPTIMAL"),
    ])));
  }
}

class FinancialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: const Text("FINANCIALS"), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("SEED CAPITAL PROGRESS", style: TextStyle(fontWeight: FontWeight.bold)),
      const Text("\$50,000 / \$500,000", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: goldAccent)),
      const SizedBox(height: 20),
      const LinearProgressIndicator(value: 0.1, minHeight: 15, color: goldAccent, backgroundColor: lightGray),
      const Spacer(),
      const Text("90/10 Split ensures platform sustainability.", style: TextStyle(fontStyle: FontStyle.italic)),
    ])));
  }
}
