import 'package:flutter/material.dart';

// HVF NEXUS CORE V69.0 - THE SOVEREIGN NAVIGATOR
// FEATURE: PERMANENT NAVIGATION & GLOBAL ROLE ACCESS
// STATUS: DOMINANT UNIFIED BUILD | ZERO-LOSS NAVIGATION
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color fieldGreen = Color(0xFF152215);

// --- 1. THE SOVEREIGN ENTRANCE ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
              const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: 4)),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FlagshipIntegratedMap())),
                child: const Text("INITIALIZE COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. THE INTEGRATED FLAGSHIP MAP ---
class FlagshipIntegratedMap extends StatelessWidget {
  const FlagshipIntegratedMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(
        backgroundColor: deepBlack, 
        title: const Text("HVF FLAGSHIP MAP", style: TextStyle(color: goldAccent)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings, color: goldAccent),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CEODashboard())),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 360, height: 550,
              decoration: BoxDecoration(border: Border.all(color: goldAccent), color: fieldGreen),
              child: Stack(
                children: [
                  _mapZone(top: 380, left: 60, label: "PRODUCER PASTURE", icon: Icons.agriculture, 
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProducerDashboard()))),
                  _mapZone(top: 120, left: 160, label: "BUYER SOCIAL CLUB", icon: Icons.fort, 
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerDashboard()))),
                  _mapZone(top: 30, left: 30, label: "HELIOGRID", icon: Icons.solar_power, onTap: () {}),
                ],
              ),
            ),
          ),
          const Positioned(bottom: 20, left: 0, right: 0, child: Center(child: Text("SELECT ZONE TO OPERATE", style: TextStyle(color: goldAccent, fontSize: 10)))),
        ],
      ),
    );
  }

  Widget _mapZone({required double top, required double left, required String label, required IconData icon, required VoidCallback onTap}) {
    return Positioned(
      top: top, left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Column(children: [
          CircleAvatar(backgroundColor: deepBlack, child: Icon(icon, color: goldAccent)),
          Container(padding: const EdgeInsets.all(4), color: Colors.black87, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9))),
        ]),
      ),
    );
  }
}

// --- 3. CEO COMMAND DESK ---
class CEODashboard extends StatelessWidget {
  const CEODashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND", style: TextStyle(color: goldAccent))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("EXECUTIVE QUEUE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          Card(color: Color(0xFF1E1E1E), child: ListTile(title: Text("Pending SME Certifications", style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }
}

// --- 4. PRODUCER PORTAL (RESTORED) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER CONSOLE")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("ASSET INDUCTION", style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(leading: const Icon(Icons.add_a_photo, color: goldAccent), title: const Text("UPLOAD NEW ASSET"))),
        ],
      ),
    );
  }
}

// --- 5. BUYER PORTAL (RESTORED) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("SME MARKETPLACE", style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: const Text("ANGUS #044"), subtitle: const Text("CEO CERTIFIED"), trailing: const Text("\$2,695.00"))),
        ],
      ),
    );
  }
}
