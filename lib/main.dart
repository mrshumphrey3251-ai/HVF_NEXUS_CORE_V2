import 'package:flutter/material.dart';

// HVF NEXUS CORE V35.0 - THE SOVEREIGN INTEGRATION BUILD
// INTEGRATED: AUTH GATE, ROLE-BASED FORKING, & EXECUTIVE SUMMARIES
// FOCUS: SECURITY, DISCLOSURE, AND INDIVIDUALIZED PORTALS
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

// --- THE SOVEREIGN GATE (ROLE DETECTION) ---
class HVFAuthGate extends StatefulWidget {
  @override
  _HVFAuthGateState createState() => _HVFAuthGateState();
}

class _HVFAuthGateState extends State<HVFAuthGate> {
  final TextEditingController _idController = TextEditingController();

  void _handleLogin() {
    String id = _idController.text.toUpperCase();
    if (id.contains("PRODUCER")) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProducerPortal()));
    } else if (id.contains("BUYER")) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BuyerPortal()));
    } else {
      // Default Admin/CEO View
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProducerPortal()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40, letterSpacing: 8)),
          const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          TextField(controller: _idController, decoration: const InputDecoration(labelText: "ACCESS ID (PRODUCER / BUYER)", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: _handleLogin,
            child: const Text("INITIALIZE COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- PORTAL A: PRODUCER COMMAND ---
class ProducerPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("PRODUCER CONSOLE", style: TextStyle(color: deepBlack, fontWeight: FontWeight.bold)), backgroundColor: pureWhite, elevation: 0),
      body: ListView(children: [
        _buildSectionHeader("MANAGEMENT & MEDIA"),
        _buildSummaryNav(context, "UPLOAD ASSET (MEDIA)", Icons.add_a_photo, 
            "BIO-DATA DISCLOSURE: Media uploaded here is subject to direct SME audit. DNA-verified lineage required.", 
            const PlaceholderScreen("MEDIA UPLOAD")),
        _buildSummaryNav(context, "LICENSE SETTLEMENT", Icons.monetization_on, 
            "ENROLLMENT: \$200.00 Monthly License Activation. Access 90/10 Sovereign Settlement path.", 
            const PlaceholderScreen("LICENSE")),
      ]),
    );
  }
}

// --- PORTAL B: BUYER VAULT ---
class BuyerPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER VAULT", style: TextStyle(color: deepBlack, fontWeight: FontWeight.bold)), backgroundColor: pureWhite, elevation: 0),
      body: ListView(children: [
        _buildSectionHeader("MY PRIVATE COLLECTION"),
        _buildSummaryNav(context, "VIEW MY ANIMALS", Icons.pets, 
            "COLLECTION DISCLOSURE: View your secured, DNA-verified assets. Certificates of ownership stored here.", 
            const PlaceholderScreen("MY ASSETS")),
        _buildSectionHeader("MARKETPLACE"),
        _buildSummaryNav(context, "LIVE MARKET ACCESS", Icons.shopping_cart, 
            "MARKET DISCLOSURE: Browse SME 'Superior' Grade local assets. Direct-to-farm settlement active.", 
            const PlaceholderScreen("MARKET")),
      ]),
    );
  }
}

// --- EXECUTIVE SUMMARY INTERSTITIAL GATE ---
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

// --- SHARED UI TOOLS ---
Widget _buildSectionHeader(String title) {
  return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
}

Widget _buildSummaryNav(BuildContext context, String label, IconData icon, String summary, Widget target) {
  return ListTile(
    leading: Icon(icon, color: goldAccent),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExecutiveSummaryGate(title: label, summary: summary, target: target))),
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
