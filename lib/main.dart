import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V121.1 - THE SOVEREIGN CORE (CORRECTED)
// ALL-INCLUSIVE FINAL HANDOVER | STABILIZED FOR WEB
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
          _buildHeader(),
          const Spacer(),
          const Icon(Icons.shield_rounded, size: 80, color: Color(0xFFC5A059)),
          const SizedBox(height: 10),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 20, letterSpacing: 4, fontWeight: FontWeight.bold)),
          const Text("N E X U S   C O R E   O S", style: TextStyle(fontSize: 10, letterSpacing: 8, color: Colors.grey)),
          const Spacer(),
          _buildActionGrid(context),
          const SizedBox(height: 40),
          const Text("SME AUTHORITY: JEFFERY D. HUMPHREY", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    color: const Color(0xFF0A0A0A),
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
    spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
    children: [
      _cmdTile(context, "WAR_ROOM", Icons.analytics, const CEOWarRoom()),
      _cmdTile(context, "HELIO_GRID", Icons.solar_power, const HelioGridScreen()),
      _cmdTile(context, "RESERVOIR", Icons.water, const ReservoirScreen()),
      _cmdTile(context, "RESTORATION", Icons.healing, const RestorationTracker()),
      _cmdTile(context, "EXCHANGE", Icons.currency_exchange, const ExchangeTerminal()),
      _cmdTile(context, "HOUSING", Icons.home_work, const ResidentialGrid()),
    ],
  );

  Widget _cmdTile(BuildContext context, String l, IconData i, Widget t) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 150, height: 90,
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 18),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

// --- MODULES INTEGRATED ---

class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: EXECUTIVE_OVERSIGHT ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("TOTAL_ASSET_FMV: \$22.4M", style: TextStyle(fontSize: 18, color: Color(0xFFC5A059)))),
    );
  }
}

class HelioGridScreen extends StatelessWidget {
  const HelioGridScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: HELIO_GRID_DATA ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("OUTPUT: 482.5 kW", style: TextStyle(fontSize: 16, color: Colors.cyan))),
    );
  }
}

class ReservoirScreen extends StatelessWidget {
  const ReservoirScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: RESERVOIR_LEVELS ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("CAPACITY: 22.4 FT", style: TextStyle(fontSize: 16, color: Colors.blueAccent))),
    );
  }
}

class RestorationTracker extends StatelessWidget {
  const RestorationTracker({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: RESTORATION_DATA ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("VET_PLACEMENT: 92%", style: TextStyle(fontSize: 16, color: Colors.green))),
    );
  }
}

class ExchangeTerminal extends StatelessWidget {
  const ExchangeTerminal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: ASSET_EXCHANGE ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("TRADING_FLOOR: ACTIVE", style: TextStyle(fontSize: 16, color: Color(0xFFC5A059)))),
    );
  }
}

class ResidentialGrid extends StatelessWidget {
  const ResidentialGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: HOUSING_NODES ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("UNITS: 200 ACTIVE", style: TextStyle(fontSize: 16, color: Colors.white))),
    );
  }
}
