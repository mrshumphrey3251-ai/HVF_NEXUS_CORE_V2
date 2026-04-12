import 'package:flutter/material.dart';

// HVF Nexus - Social Club: Great Hall Module V2.2
// Top-Down Executive Build: Lighting & Environment
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
              // LEVEL 1: TOP-DOWN STATUS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CEILING & LIGHTING", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  Icon(Icons.wb_sunny, color: Colors.amber, size: 20),
                ],
              ),
              Text("Status: HELIOGRID POWERED", style: TextStyle(color: Colors.green, fontSize: 12)),
              Divider(color: Colors.amber.withOpacity(0.5)),
              
              SizedBox(height: 15),
              Text("CATHEDRAL ARCHITECTURE:", style: TextStyle(color: Colors.amber, fontSize: 14)),
              Text("• Exposed King Post Cedar Trusses", style: TextStyle(color: Colors.white)),
              Text("• Wrought Iron Smart Chandeliers", style: TextStyle(color: Colors.white)),
              Text("• Adaptive Warm-Spectrum Lighting: ACTIVE", style: TextStyle(color: Colors.white70, fontSize: 12)),

              SizedBox(height: 30),
              
              // LEVEL 2: THE FLOOR (ESTABLISHED)
              Text("SOVEREIGN SEATING & ANCHORS:", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Divider(color: Colors.amber.withOpacity(0.5)),
              Text("• 20ft Oklahoma Fieldstone Fireplace", style: TextStyle(color: Colors.white)),
              Text("• Executive Leather Wingbacks (CEO/Co-Founder)", style: TextStyle(color: Colors.white)),
              Text("• 4 Veteran Club Chairs (ADA Clearance)", style: TextStyle(color: Colors.white)),
              Text("• 12ft Cedar Legacy Bench", style: TextStyle(color: Colors.white)),
              
              SizedBox(height: 40),
              
              // SME SAFETY FOOTER
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.black45,
                child: Center(
                  child: Text("NCCER SAFETY RATING: COMPLIANT", 
                             style: TextStyle(color: Colors.green, fontSize: 10, letterSpacing: 1.2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
