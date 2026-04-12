import 'package:flutter/material.dart';

// HVF Nexus - Social Club: Great Hall Module V2.3
// Ground-Up Executive Build: Foundation & Infrastructure
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
              // THE FOUNDATION (LEVEL 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("FOUNDATION & SUB-FLOOR", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  Icon(Icons.layers, color: Colors.green, size: 20),
                ],
              ),
              Text("Status: MONOLITHIC SLAB SECURE", style: TextStyle(color: Colors.green, fontSize: 12)),
              Divider(color: Colors.amber.withOpacity(0.5)),
              
              SizedBox(height: 15),
              Text("GROUND-LEVEL SPECS:", style: TextStyle(color: Colors.amber, fontSize: 14)),
              Text("• Polished 'Aged Walnut' Concrete Finish", style: TextStyle(color: Colors.white)),
              Text("• Integrated HelioGrid Radiant Sub-Floor Heating", style: TextStyle(color: Colors.white)),
              Text("• Zero-Threshold ADA Pathways: VERIFIED", style: TextStyle(color: Colors.white70, fontSize: 12)),

              SizedBox(height: 30),
              
              // THE STRUCTURE (LEVEL 1)
              Text("VERTICAL ASSETS & SEATING:", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              Divider(color: Colors.amber.withOpacity(0.5)),
              Text("• 20ft Oklahoma Fieldstone Fireplace", style: TextStyle(color: Colors.white)),
              Text("• Executive Leather Wingbacks (CEO Anchor)", style: TextStyle(color: Colors.white)),
              Text("• 4 Veteran Club Chairs (60\" Clearance)", style: TextStyle(color: Colors.white)),
              
              SizedBox(height: 40),
              
              // SME INFRASTRUCTURE FOOTER
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.withOpacity(0.5)),
                  color: Colors.black45,
                ),
                child: Column(
                  children: [
                    Text("INFRASTRUCTURE INTEGRITY", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                    Text("Sub-surface fiber and power conduits are locked for HVF Nexus Core communication.", 
                         style: TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
