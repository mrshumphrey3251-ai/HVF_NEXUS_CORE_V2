import 'package:flutter/material.dart';

void main() => runApp(HVFNexusApp());

class HVFNexusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("HVF NEXUS - BUILD #35")),
        body: Center(
          child: Column(
            children: [
              Text("SITE STATUS: OPERATIONAL", style: TextStyle(color: Colors.green)),
              Text("BASIN: 25 ACRES | UNITS: 200"),
              // Map Rendering Viewport Here
            ],
          ),
        ),
      ),
    );
  }
}
