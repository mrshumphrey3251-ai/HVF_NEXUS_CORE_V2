import 'package:flutter/material.dart';

// HVF NEXUS CORE V31.2 - THE SYSTEM RE-LINK BUILD
// FIXED: MATERIAL LIBRARY IMPORT / COMPILER ERROR PURGE
// FEATURE: EXECUTIVE SUMMARY GATES / INDUSTRIAL WHITE THEME
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFAuthGate(),
  ));
}

// --- SOVEREIGN COLOR PALETTE ---
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
          _buildLargeHeader("SOVEREIGN ASSETS"),
          _buildSummaryButton(context, "MARKETPLACE (BUY/SELL)", Icons.swap_horizontal_circle, 
            "MARKET DISCLOSURE: Facilitating the 90/10 Sovereign Settlement. Projected monthly gross: \$5.8M.", 
            MarketHub()),
          _buildSummaryButton(context, "UPLOAD MEDIA", Icons.add_a_photo, 
            "BIO-DATA DISCLOSURE: Subject to direct SME audit. DNA-verified lineage required for 'Superior' grade.", 
            MediaUploadScreen()),
          _buildLargeHeader("PROJECT INFRASTRUCTURE"),
          _buildSummaryButton(context, "SITE PLAN & MAPS", Icons.architecture, 
            "INFRASTRUCTURE DISCLOSURE: Slab Road Flagship specifications including reservoir and transit grid.", 
            SitePlanScreen()),
          _buildLargeHeader("FINANCIAL COMMAND"),
          _buildSummaryButton(context, "REVENUE & SEED TRACKER", Icons.bar_chart, 
            "CAPITAL DISCLOSURE: Monitoring the \$500,000 Seed Round. Targeted for 40-city activation.", 
            FinancialScreen()),
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

// --- SUB-SECTORS (ALL DATA RETAINED) ---
class MarketHub extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("MARKETPLACE")), body: const Center(child: Text("90/10 SETTLEMENT ACTIVE")));
}
class MediaUploadScreen extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("ASSET MEDIA")), body: const Center(child: Text("MEDIA PORTAL READY")));
}
class SitePlanScreen extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("SITE MAP")), body: const Center(child: Text("SITE MAP LOADED")));
}
class FinancialScreen extends StatelessWidget {
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("FINANCIALS")), body: const Center(child: Text("\$500,000 TARGET")));
}
