import 'package:flutter/material.dart';

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
            const Divider(color: Colors.amber, indent: 50, endIndent: 50),
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
