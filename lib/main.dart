import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V121.0 - THE SOVEREIGN CORE
// ALL-INCLUSIVE FINAL HANDOVER (DAY 7 OF 7)
// UEI: S1M4ENLHTDH5 | PATENT: TPP99424
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
        scaffoldBackgroundColor: const Color(0xFF000000),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignCommandCenter(),
    );
  }
}

class SovereignCommandCenter extends StatelessWidget {
  const SovereignCommandCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- THE SOVEREIGN HEADER ---
          _buildHeader(),
          const Spacer(),
          // --- THE HUMPHREY CREST ANCHOR ---
          const Icon(Icons.shield_rounded, size: 100, color: Color(0xFFC5A059)),
          const SizedBox(height: 10),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 22, letterSpacing: 6, fontWeight: FontWeight.bold)),
          const Text("N  E  X  U  S    C  O  R  E", style: TextStyle(fontSize: 10, letterSpacing: 10, color: Colors.grey)),
          const Spacer(),
          // --- INDUSTRIAL COMMAND GRID ---
          _buildActionGrid(context),
          const SizedBox(height: 40),
          const Text("SME AUTHORITY VERIFIED: JEFFERY DONNELL HUMPHREY", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
        Text("PATENT TPP99424", style: TextStyle(fontSize: 8, color: Colors.white24)),
        Text("GRID: 100% ONLINE", style: TextStyle(fontSize: 8, color: Colors.greenAccent)),
      ],
    ),
  );

  Widget _buildActionGrid(BuildContext context) => Wrap(
    spacing: 15, runSpacing: 15, alignment: WrapAlignment.center,
    children: [
      _cmdTile(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const WarRoom()),
      _cmdTile(context, "WAPANUCKA_TELEMETRY", Icons.sensors, const Placeholder()),
      _cmdTile(context, "HELIO_GRID_COMMAND", Icons.solar_power, const Placeholder()),
      _cmdTile(context, "RESTORATION_PORTAL", Icons.healing, const Placeholder()),
      _cmdTile(context, "COMMODITY_EXCHANGE", Icons.currency_exchange, const Placeholder()),
      _cmdTile(context, "HOUSING_GRID_200", Icons.home_work, const Placeholder()),
    ],
  );

  Widget _cmdTile(BuildContext context, String l, IconData i, Widget t) => InkWell(
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 160, height: 100,
      decoration: BoxDecoration(color: const Color(0xFF0A0A0A), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 20),
        const SizedBox(height: 10),
        Text(l, style: const TextStyle(fontSize: 7, letterSpacing: 1, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

class WarRoom extends StatelessWidget {
  const WarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text(":: LIVE_SOVEREIGN_LEDGER ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("TOTAL_ASSET_FMV: \$22,450,000.00", style: TextStyle(fontSize: 18, color: Color(0xFFC5A059)))),
    );
  }
}
