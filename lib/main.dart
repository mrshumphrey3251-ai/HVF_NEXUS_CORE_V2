import 'package:flutter/material.dart';

// HVF NEXUS CORE V34.0 - THE ROLE-BASED COMMAND BUILD
// FEATURE: ROLE-BASED ROUTING (PRODUCER VS BUYER PORTALS)
// FOCUS: INDIVIDUALIZED USER EXPERIENCE & PRIVATE ASSET LOCKERS
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

// --- THE SOVEREIGN GATE (WITH ROLE DETECTION) ---
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
      // Default to CEO Dashboard for generic admin access
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
          const Text("SECURE ACCESS GATEWAY", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          TextField(controller: _idController, decoration: const InputDecoration(labelText: "ACCESS ID (Enter 'PRODUCER' or 'BUYER')", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: _handleLogin,
            child: const Text("INITIALIZE COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          const Text("Use Access ID to route to your specific portal.", style: TextStyle(fontSize: 12, color: Colors.black38)),
        ]),
      ),
    );
  }
}

// --- PORTAL A: THE PRODUCER MANAGEMENT SUITE ---
class ProducerPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("PRODUCER CONSOLE"), backgroundColor: pureWhite, elevation: 0, centerTitle: true),
      body: ListView(children: [
        _buildSectionHeader("MY OPERATIONS"),
        _buildNavTile(context, "UPLOAD NEW ASSET", Icons.add_a_photo, const PlaceholderScreen("MEDIA UPLOAD")),
        _buildNavTile(context, "MY INVENTORY", Icons.list_alt, const PlaceholderScreen("INVENTORY")),
        _buildNavTile(context, "SALES & SETTLEMENTS", Icons.monetization_on, const PlaceholderScreen("SALES")),
        _buildSectionHeader("MARKET STATUS"),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("ACTIVE LISTINGS: 12 | PENDING GRADING: 2", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
        )
      ]),
    );
  }
}

// --- PORTAL B: THE BUYER COLLECTION VAULT ---
class BuyerPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER VAULT"), backgroundColor: pureWhite, elevation: 0, centerTitle: true),
      body: ListView(children: [
        _buildSectionHeader("MY COLLECTION"),
        _buildNavTile(context, "VIEW MY ANIMALS", Icons.pets, const PlaceholderScreen("MY ANIMALS")),
        _buildNavTile(context, "DNA CERTIFICATES", Icons.verified_user, const PlaceholderScreen("CERTIFICATES")),
        _buildSectionHeader("THE MARKETPLACE"),
        _buildNavTile(context, "BROWSE LIVE MARKET", Icons.shopping_cart, const PlaceholderScreen("MARKET")),
        _buildNavTile(context, "SUBSCRIPTION STATUS", Icons.star, const PlaceholderScreen("SUBSCRIPTION")),
      ]),
    );
  }
}

// --- SHARED UI COMPONENTS ---
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
