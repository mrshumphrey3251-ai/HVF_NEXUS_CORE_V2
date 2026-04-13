import 'package:flutter/material.dart';

// HVF NEXUS CORE V68.0 - THE INTEGRATED FLAGSHIP ENVIRONMENT
// FEATURE: GEOSPATIAL NAVIGATION & ROLE-BASED MAP TRIGGERS
// STATUS: DOMINANT UNIFIED BUILD | SILOS ELIMINATED
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
              const Text("INTEGRATED COMMAND", style: TextStyle(color: goldAccent, letterSpacing: 2)),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FlagshipIntegratedMap())),
                child: const Text("INITIALIZE CAMPUS MAP", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. THE INTEGRATED FLAGSHIP MAP (THE NEW HUB) ---
class FlagshipIntegratedMap extends StatelessWidget {
  const FlagshipIntegratedMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(
        backgroundColor: deepBlack, 
        title: const Text("HVF FLAGSHIP: JOHNSTON CO.", style: TextStyle(color: goldAccent, fontSize: 14)),
        iconTheme: const IconThemeData(color: goldAccent),
      ),
      body: Stack(
        children: [
          // THE 200-ACRE PLOT
          Center(
            child: Container(
              width: 360, height: 550,
              decoration: BoxDecoration(border: Border.all(color: goldAccent), color: fieldGreen),
              child: Stack(
                children: [
                  // PRODUCER TRIGGER
                  _mapInteractiveZone(
                    top: 350, left: 40, 
                    label: "NORTH PASTURE", 
                    icon: Icons.agriculture,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProducerDashboard())),
                  ),
                  // BUYER/CEO TRIGGER
                  _mapInteractiveZone(
                    top: 100, left: 160, 
                    label: "1880 SOCIAL CLUB", 
                    icon: Icons.fort,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerDashboard())),
                  ),
                  // ENERGY ANCHOR
                  _mapInteractiveZone(top: 20, left: 20, label: "HELIOGRID ALPHA", icon: Icons.solar_power, onTap: () {}),
                  // TRANSIT LOOP VISUAL
                  Center(child: Container(
                    width: 200, height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  )),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 30, left: 0, right: 0,
            child: Center(child: Text("CLICK A ZONE TO ENTER PORTAL", style: TextStyle(color: goldAccent, fontSize: 10, letterSpacing: 2))),
          )
        ],
      ),
    );
  }

  Widget _mapInteractiveZone({required double top, required double left, required String label, required IconData icon, required VoidCallback onTap}) {
    return Positioned(
      top: top, left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(backgroundColor: deepBlack, child: Icon(icon, color: goldAccent, size: 20)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: Colors.black87,
              child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. PRODUCER PORTAL (LINKED) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER COMMAND")),
      body: const Center(child: Text("INDUCTION ENGINE: READY FOR UPLOAD")),
    );
  }
}

// --- 4. BUYER PORTAL (LINKED) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: const Center(child: Text("CERTIFIED ASSET MARKETPLACE")),
    );
  }
}
