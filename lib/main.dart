import 'package:flutter/material.dart';

void main() => runApp(HVFNexusApp());

class HVFNexusApp extends StatelessWidget {
  // SME Note: Pointing to the V2 Production Server
  final String serverEndpoint = "https://mrshumphrey3251-ai.github.io/HVF_NEXUS_CORE_V2/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: Text("HVF NEXUS CORE V2 - EXECUTIVE")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, color: Colors.green, size: 80),
              Text("SYSTEM STATUS: OPERATIONAL", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              Divider(),
              Text("PROJECT: JOHNSTON COUNTY CAMPUS"),
              Text("ASSETS: 200 UNITS | 25-ACRE BASIN"),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("ENTER SOCIAL CLUB INTERIOR"))
            ],
          ),
        ),
      ),
    );
  }
}
