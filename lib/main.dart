import 'package:flutter/material.dart';

// HVF NEXUS CORE V2.9.1 - AUDIT & LOGISTICS SOVEREIGN BUILD
// 90/10 REVENUE ARCHITECTURE: ACTIVE
// Authorized by CEO Jeffery Donnell Humphrey

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

// --- SCREEN 1: THE COMMAND CENTER (WITH AGENT AUDIT) ---
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
        title: const Text("HVF NEXUS: AUDIT CORE"),
        backgroundColor: const Color(0xFF3E2723), // CEO Cedar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.shield_outlined, color: Colors.green, size: 80),
            const Text("AGENT VERIFICATION ACTIVE", 
                 style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            // --- THE SOVEREIGN TRACKING FIELD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _agentIdController,
                decoration: const InputDecoration(
                  labelText: "ENTER AGENT ID / CITY CODE",
                  labelStyle: TextStyle(color: Colors.amber),
                  hintText: "e.g., OK-JOHNSTON-001",
                  hintStyle: TextStyle(color: Colors.white24),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GreatHallScreen()),
                  );
                },
                child: const Text("ACCESS INTERIOR ASSETS", 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 40),
            const Text("90/10 REVENUE SPLIT: ACTIVE", 
                 style: TextStyle(color: Colors.white54, fontSize: 12)),
            const Text("SOVEREIGNTY STATUS: VERIFIED", 
                 style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// --- SCREEN 2: THE GREAT HALL INTERIOR ---
class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211007),
      appBar: AppBar(
        title: const Text("SOCIAL CLUB: GREAT HALL"),
        backgroundColor: const Color(0xFF3E2723),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.holiday_village, color: Colors.amber, size: 100),
            const Text("INTERIOR ASSETS", 
                 style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.amber, indent: 50, endIndent: 50, thickness: 2),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                "• 20ft Fieldstone Spine (Masonry Secure)\n"
                "• 12x12 Cedar Structural Columns\n"
                "• Sovereign Seating: CEO Wingbacks Anchored\n"
                "• Veteran Club Chairs: ADA Compliant",
                style: TextStyle(color: Colors.white, fontSize: 18, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white10),
              onPressed: () => Navigator.pop(context),
              child: const Text("RETURN TO COMMAND"),
            ),
          ],
        ),
      ),
    );
  }
}
