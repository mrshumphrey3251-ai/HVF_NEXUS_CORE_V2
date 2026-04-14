import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY", // Ensure these match your Firebase Console
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "hvf-nexus",
    ),
  );
  runApp(const HVFNexus());
}

class HVFNexus extends StatelessWidget {
  const HVFNexus({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      home: const NexusCore(),
    );
  }
}

class NexusCore extends StatefulWidget {
  const NexusCore({super.key});
  @override
  State<NexusCore> createState() => _NexusCoreState();
}

class _NexusCoreState extends State<NexusCore> {
  bool isAuthorized = false;
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This is the "Force-Render" switch
    if (!isAuthorized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: Main_AxisAlignment.center,
            children: [
              const Text("SOVEREIGN GATE", style: TextStyle(color: Color(0xFFFFD700), fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _codeController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter CEO Code',
                    labelStyle: TextStyle(color: Colors.white54),
                  ),
                  onSubmitted: (value) {
                    if (value == "CEO1880") {
                      setState(() {
                        isAuthorized = true;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text("Live cloud stream active", style: TextStyle(color: Colors.green, fontSize: 12)),
            ],
          ),
        ),
      );
    } else {
      // THE COMMAND CENTER (This is what wasn't showing)
      return Scaffold(
        appBar: AppBar(
          title: const Text(":: HVF OVERWATCH ::", style: TextStyle(color: Color(0xFFFFD700))),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text("COMMAND CENTER LIVE\nSystem Synchronized", 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      );
    }
  }
}
