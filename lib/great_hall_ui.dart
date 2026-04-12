import 'package:flutter/material.dart';

// HVF Nexus - Social Club: Great Hall Module V2.5
// Fix: Added missing Material Import
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
              Text("STRUCTURAL ASSETS: VERTICAL", 
                   style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Text("Status: MASONRY & TIMBER ERECTED", style: TextStyle(color: Colors.green, fontSize: 12)),
              Divider(color: Colors.amber),
              
              SizedBox(height: 15),
              Text("VERTICAL SPECIFICATIONS:", style: TextStyle(color: Colors.amber, fontSize: 14)),
              Text("• 20ft Fieldstone Spine (Thermal Anchor)", style: TextStyle(color: Colors.white)),
              Text("• 12x12 Load-Bearing Cedar Columns", style: TextStyle(color: Colors.white)),
              Text("• Hand-Hewn Reclaimed Cedar Mantle", style: TextStyle(color: Colors.white)),

              SizedBox(height: 30),
              Text("FOUNDATION (BASE LAYER):", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
              Text("• Monolithic Slab: VERIFIED", style: TextStyle(color: Colors.green, fontSize: 11)),
              Text("• Aged Walnut Concrete: CURED", style: TextStyle(color: Colors.green, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
