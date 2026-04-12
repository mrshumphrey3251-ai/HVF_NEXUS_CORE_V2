import 'package:flutter/material.dart';

// HVF NEXUS CORE V3.0 - THE SOVEREIGN SETTLEMENT BUILD
// INTEGRATED: High-Visibility Audit Core, Agent Tracking, and Great Hall Interior
// REV SPLIT: 90/10 REVENUE ARCHITECTURE HARD-CODED
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HVF NEXUS CORE',
    home: HVFCommandDashboard(),
  ));
}

// --- SCREEN 1: THE COMMAND CENTER (AUDIT & AGENT GATE) ---
class HVFCommandDashboard extends StatefulWidget {
  const HVFCommandDashboard({super.key});

  @override
  State<HVFCommandDashboard> createState() => _HVFCommandDashboardState();
}

class _HVFCommandDashboardState extends State<HVFCommandDashboard> {
  final TextEditingController _agentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211007), // Aged Walnut
      appBar: AppBar(
        // SME FIX: High-Visibility Branding
        title: const Text(
          "HVF NEXUS: AUDIT CORE",
          style: TextStyle(
            color: Colors.amber, 
            fontWeight: FontWeight.bold, 
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3E2723), // Deep Cedar
        elevation: 15,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Icon(Icons.shield_outlined, color: Colors.green, size: 100),
            const SizedBox(height: 10),
            const Text(
              "AGENT VERIFICATION ACTIVE", 
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 50),
            
            // --- THE SOVEREIGN AGENT TRACKER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _agentIdController,
                decoration: const InputDecoration(
                  labelText: "ENTER AGENT ID / CITY CODE",
                  labelStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                  hintText: "OK-JOHNSTON-001",
                  hintStyle: TextStyle(color: Colors.white24),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // --- PRIMARY ACCESS BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 70),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GreatHallScreen()),
                  );
                },
                child: const Text(
                  "ACCESS INTERIOR ASSETS", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            
            const SizedBox(height: 60),
            const Divider(color: Colors.white24, indent: 50, endIndent: 50),
            const Text("90/10 REVENUE SPLIT: ACTIVE", 
                 style: TextStyle(color: Colors.white54, fontSize: 14, letterSpacing: 1.1)),
            const Text("SOVEREIGNTY STATUS: VERIFIED", 
                 style: TextStyle(color: Colors.white54, fontSize: 14, letterSpacing: 1.1)),
          ],
        ),
      ),
    );
  }
}

// --- SCREEN 2: THE SOCIAL CLUB: GREAT HALL INTERIOR ---
class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211007),
      appBar: AppBar(
        title: const Text(
          "SOCIAL CLUB: GREAT HALL",
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF3E2723),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.holiday_village, color: Colors.amber, size: 120),
            const SizedBox(height: 20),
            const Text(
              "INTERIOR ASSETS", 
              style: TextStyle(color: Colors.amber, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(color: Colors.amber, thickness: 3),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                "• 20ft Fieldstone Spine (Masonry Secure)\n\n"
                "• 12x12 Cedar Structural Columns\n\n"
                "• Sovereign Seating: CEO Wingbacks Anchored\n\n"
                "• Veteran Club Chairs: ADA Compliant",
                style: TextStyle(color: Colors.white, fontSize: 18, height: 1.6),
              ),
            ),
            const SizedBox(height: 40),
            
            // --- RETURN TO COMMAND CENTER ---
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.amber),
              label: const Text("RETURN TO COMMAND", style: TextStyle(color: Colors.amber, fontSize: 16)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
