import 'package:flutter/material.dart';

class GreatHallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF211007),
      appBar: AppBar(
        title: Text("GREAT HALL INTERIOR"),
        backgroundColor: Color(0xFF3E2723),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.house, color: Colors.amber, size: 100),
            SizedBox(height: 20),
            Text("INTERIOR ASSETS ACTIVE", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("• 20ft Fieldstone Fireplace\n• 12x12 Cedar Columns\n• Sovereign Seating Area", 
              style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("BACK TO COMMAND"),
            )
          ],
        ),
      ),
    );
  }
}
