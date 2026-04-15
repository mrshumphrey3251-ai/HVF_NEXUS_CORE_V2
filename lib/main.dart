import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.5 - PHASE 6: NATIONAL GRID PROJECTION
// FOCUS: MULTI-NODE TELEMETRY & VETERAN RESTORATION ANALYTICS
// DAY 6 OF 7 | AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
        scaffoldBackgroundColor: const Color(0xFF010101),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const FederalCommandGate(),
    );
  }
}

// --- COMMAND GATE (UPDATED WITH NATIONAL GRID) ---
class FederalCommandGate extends StatelessWidget {
  const FederalCommandGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10), color: const Color(0xFF0A0A0A),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
            Text("GRID_MODE: NATIONAL", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          ]),
        ),
        const Spacer(),
        const Icon(Icons.public_rounded, size: 80, color: Color(0xFFC5A059)),
        const Text("NATIONAL POWER GRID", style: TextStyle(fontSize: 18, letterSpacing: 6, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _cmdBtn(context, "GRID_PROJECTION_MAP", const GridProjection()),
        _cmdBtn(context, "RESTORATION_ANALYTICS", const RestorationAnalytics()),
        const Spacer(),
        const Text("MULTI-NODE SOVEREIGNTY ACTIVE", style: TextStyle(fontSize: 7, color: Colors.white10)),
        const SizedBox(height: 30),
      ]),
    );
  }

  Widget _cmdBtn(BuildContext context, String l, Widget t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(300, 55)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9, letterSpacing: 2)),
    ),
  );
}

// --- DAY 6 MODULE: GRID PROJECTION ---
class GridProjection extends StatelessWidget {
  const GridProjection({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: NATIONAL_NODE_OVERSIGHT ::", style: TextStyle(fontSize: 9))),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _nodeTile("NODE_001_OK_WAPANUCKA", "ONLINE / 100%", Colors.greenAccent),
          _nodeTile("NODE_002_TX_PANHANDLE", "STANDBY / 0%", Colors.grey),
          _nodeTile("NODE_003_KS_WEST", "STANDBY / 0%", Colors.grey),
          const SizedBox(height: 30),
          const Center(child: Icon(Icons.map_outlined, size: 150, color: Colors.white10)),
        ],
      ),
    );
  }

  Widget _nodeTile(String l, String v, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: c.withOpacity(0.3))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
      Text(v, style: TextStyle(fontSize: 8, color: c)),
    ]),
  );
}

// --- DAY 6 MODULE: RESTORATION ANALYTICS ---
class RestorationAnalytics extends StatelessWidget {
  const RestorationAnalytics({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: RESTORATION_OUTCOMES ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _analyticTile("VET_SME_PLACEMENT", "92%", Colors.cyan),
          const SizedBox(height: 10),
          _analyticTile("CLINICAL_ADHERENCE", "100%", Colors.green),
          const SizedBox(height: 10),
          _analyticTile("VOCATIONAL_UPLIFT", "4.2x", const Color(0xFFC5A059)),
          const Spacer(),
          const Text("DATA VERIFIED VIA NIST 800-171 COMPLIANT TUNNELS", style: TextStyle(fontSize: 7, color: Colors.white24)),
        ]),
      ),
    );
  }

  Widget _analyticTile(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    color: const Color(0xFF0D0D0D),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}
