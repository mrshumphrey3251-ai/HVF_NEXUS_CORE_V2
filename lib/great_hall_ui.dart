import 'package:flutter/material.dart';

// HVF Nexus - Social Club: Great Hall Module V2.1
// Authorized by Jeffery Donnell Humphrey

class GreatHallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOCIAL CLUB: THE GREAT HALL"),
        backgroundColor: Color(0xFF3E2723), 
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(color: Color(0xFF211007)), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EXECUTIVE INTERIOR: ACTIVE", 
                   style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              Divider(color: Colors.amber),
              SizedBox(height: 10),
              Text("SOVEREIGN SEATING:", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Text("• 2 Executive Leather Wingbacks", style: TextStyle(color: Colors.white)),
              Text("• 4 Veteran Club Chairs (ADA)", style: TextStyle(color: Colors.white)),
              Text("• 12ft Cedar Legacy Bench", style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Text("STRUCTURAL:", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Text("• 20ft Fieldstone Fireplace", style: TextStyle(color: Colors.white)),
              Text("• Exposed King Post Trusses", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
