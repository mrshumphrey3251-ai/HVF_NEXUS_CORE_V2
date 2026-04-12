import 'package:flutter/material.dart';
import 'great_hall_ui.dart';

// HVF NEXUS CORE V2 - COMMANDER IGNITION
void main() {
  runApp(const HVFNexusApp());
}

class HVFNexusApp extends StatelessWidget {
  const HVFNexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HVF NEXUS CORE V2',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF3E2723), // CEO Cedar
      ),
      home: const HVFCommandDashboard(),
    );
  }
}

class HVFCommandDashboard extends StatelessWidget {
  const HVFCommandDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211007), // Aged Walnut
      appBar: AppBar(
        title: const Text("HVF NEXUS COMMAND"),
        backgroundColor: const Color(0xFF3E2723),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, color: Colors.green, size: 80),
            const Text("SYSTEM OPERATIONAL", 
                 style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
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
                child: const Text("ENTER SOCIAL CLUB INTERIOR", 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
