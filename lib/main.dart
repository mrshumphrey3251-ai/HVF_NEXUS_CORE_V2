import 'package:flutter/material.dart';
import 'great_hall_ui.dart'; 

void main() => runApp(HVFNexusApp());

class HVFNexusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(title: Text("HVF NEXUS CORE V2")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, color: Colors.green, size: 80),
              Text("SYSTEM OPERATIONAL", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, 
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => GreatHallScreen())
                  );
                },
                child: Text("ENTER SOCIAL CLUB INTERIOR", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
