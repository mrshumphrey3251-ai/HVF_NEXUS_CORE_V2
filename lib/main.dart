import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.0 - PHASE 1: FEDERAL FOUNDATION
// SOVEREIGN ENTITY: HUMPHREY VIRTUAL FARMS LLC
// UEI: S1M4ENLHTDH5 | PATENT: TPP99424
// AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO / SME)

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
  runApp(const HVFNexusOS());
}

class HVFNexusOS extends StatelessWidget {
  const HVFNexusOS({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier', // INDUSTRIAL TERMINAL FEEL
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC5A059), // HVF GOLD
          secondary: Colors.cyan,
          surface: Color(0xFF0A0A0A),
        ),
      ),
      home: const FederalCommandGate(),
    );
  }
}

class FederalCommandGate extends StatelessWidget {
  const FederalCommandGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(color: Color(0xFFC5A059), width: 0.5)),
        ),
        child: Column(
          children: [
            // --- SOVEREIGN HEADER BAR ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: const Color(0xFFC5A059).withOpacity(0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
                  Text("PATENT PENDING: TPP99424", style: TextStyle(fontSize: 8, color: Colors.white24)),
                  Text("SAM.GOV REGISTERED", style: TextStyle(fontSize: 8, color: Colors.cyan)),
                ],
              ),
            ),
            const Spacer(),
            // --- CORE IDENTITY ---
            const Icon(Icons.shield_rounded, size: 100, color: Color(0xFFC5A059)),
            const SizedBox(height: 20),
            const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 22, letterSpacing: 6, fontWeight: FontWeight.bold)),
            const Text("N E X U S   O P E R A T I N G   S Y S T E M", style: TextStyle(fontSize: 10, letterSpacing: 4, color: Colors.grey)),
            const SizedBox(height: 10),
            const Text("V2.0.0-PROPRIETARY", style: TextStyle(fontSize: 7, color: Colors.white10)),
            const Spacer(),
            // --- SME CREDENTIALS ---
            _smeBadge("SME AUTHORITY: JEFFERY D. HUMPHREY"),
            _smeBadge("NCCER SAFETY PROFESSIONAL CERTIFIED"),
            _smeBadge("NCCO CRANE OPERATOR CERTIFIED"),
            const SizedBox(height: 40),
            // --- COMMAND INPUTS ---
            _commandBtn(context, "EXECUTIVE_WAR_ROOM", const WarRoom()),
            _commandBtn(context, "WAPANUCKA_NODE_TELEMETY", const Placeholder()), // DAY 2
            _commandBtn(context, "HELIO_GRID_COMMAND", const Placeholder()), // DAY 2
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _smeBadge(String label) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(label, style: const TextStyle(fontSize: 8, color: Colors.cyan, fontWeight: FontWeight.bold)),
  );

  Widget _commandBtn(BuildContext context, String l, Widget t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFC5A059), width: 0.5),
        minimumSize: const Size(320, 50),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2, fontSize: 10)),
    ),
  );
}

class WarRoom extends StatelessWidget {
  const WarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: EXECUTIVE_WAR_ROOM ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("INITIALIZING PHASE 1 DATA TUNNEL...", style: TextStyle(color: Colors.white24))),
    );
  }
}
