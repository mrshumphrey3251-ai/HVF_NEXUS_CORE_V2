import 'package:flutter/material.dart';
import 'great_hall_ui.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

class HVFCommandDashboard extends StatelessWidget {
  const HVFCommandDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211007),
      appBar: AppBar(
        title: const Text("HVF NEXUS: AUDIT CORE"),
        backgroundColor: const Color(0xFF3E2723),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Icon(Icons.shield_outlined, color: Colors.green, size: 80),
            const Text("AGENT VERIFICATION ACTIVE", 
                 style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            // --- THE SOVEREIGN TRACKING FIELD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "ENTER AGENT ID / CITY CODE",
                  labelStyle: const TextStyle(color: Colors.amber),
                  hintText: "e.g., OK-JOHNSTON-001",
                  hintStyle: const TextStyle(color: Colors.white24),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
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
            const SizedBox(height: 20),
            const Text("90/10 REVENUE SPLIT: ACTIVE", 
                 style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
