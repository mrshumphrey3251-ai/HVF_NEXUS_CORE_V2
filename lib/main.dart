import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.0 - THE SOVEREIGN SHELL
// FOCUS: SPRINT A - VISUAL AUTHORITY & THE HUMPHREY CREST ANCHOR
// AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
      authDomain: "hvf-nexus.firebaseapp.com",
      projectId: "hvf-nexus",
      storageBucket: "hvf-nexus.firebasestorage.app",
      messagingSenderId: "892263251736",
      appId: "1:892263251736:web:899cc6ab03f6f5e9d82899",
    ),
  );
  runApp(const HVFNexus());
}

class HVFNexus extends StatelessWidget {
  const HVFNexus({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC5A059), // THE GOLD STANDARD
          secondary: Colors.cyan,
        ),
      ),
      home: const SovereignGate(),
    );
  }
}

class SovereignGate extends StatefulWidget {
  const SovereignGate({super.key});
  @override
  State<SovereignGate> createState() => _SovereignGateState();
}

class _SovereignGateState extends State<SovereignGate> {
  bool isAuthorized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
            center: Alignment.center,
            radius: 1.2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // THE HUMPHREY CREST ANCHOR
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFC5A059), width: 2),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFC5A059).withOpacity(0.2), blurRadius: 40)
                  ],
                ),
                child: const Icon(Icons.shield_rounded, size: 80, color: Color(0xFFC5A059)),
              ),
              const SizedBox(height: 20),
              const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(letterSpacing: 8, fontSize: 14, fontWeight: FontWeight.bold)),
              const Text("N  E  X  U  S", style: TextStyle(letterSpacing: 12, fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 60),
              
              _gateButton("CEO COMMAND", () => _nav(context, "CEO")),
              _gateButton("PARTNER UPLINK", () => _nav(context, "PRODUCER")),
              
              const SizedBox(height: 40),
              const Text("EST. 1840 | SOVEREIGN GRID", style: TextStyle(fontSize: 7, color: Colors.white24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gateButton(String label, VoidCallback tap) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFC5A059), width: 0.5),
        minimumSize: const Size(280, 55),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: tap,
      child: Text(label, style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2, fontSize: 10)),
    ),
  );

  void _nav(BuildContext context, String role) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CommandConsole(role: role)));
  }
}

class CommandConsole extends StatelessWidget {
  final String role;
  const CommandConsole({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(":: $role PORTAL ::", style: const TextStyle(fontSize: 9, letterSpacing: 4, color: Color(0xFFC5A059))),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 14), onPressed: () => Navigator.pop(context)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(role == "CEO" ? Icons.analytics : Icons.upload_file, color: Colors.white10, size: 120),
            const SizedBox(height: 20),
            Text("$role ENGINE INITIALIZING...", style: const TextStyle(fontSize: 8, color: Colors.white30)),
          ],
        ),
      ),
    );
  }
}
