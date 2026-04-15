import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V122.1 - FINAL STABILITY PROTOCOL
// SOVEREIGN ENTITY: HUMPHREY VIRTUAL FARMS LLC
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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignDashboard(),
    );
  }
}

class SovereignDashboard extends StatelessWidget {
  const SovereignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: const Text("UEI: S1M4ENLHTDH5 | PATENT: TPP99424", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Spacer(),
          const Icon(Icons.shield_rounded, size: 90, color: Color(0xFFC5A059)),
          const SizedBox(height: 15),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Text("NEXUS CORE OPERATING SYSTEM", style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 6)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
              children: [
                _buildTile(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const WarRoom()),
                _buildTile(context, "WAPANUCKA_NODE", Icons.hub, const PlaceholderScreen()),
                _buildTile(context, "HELIO_GRID", Icons.solar_power, const PlaceholderScreen()),
                _buildTile(context, "RESTORATION", Icons.healing, const PlaceholderScreen()),
                _buildTile(context, "COMMODITY_EXCHANGE", Icons.currency_exchange, const PlaceholderScreen()),
                _buildTile(context, "HOUSING_GRID", Icons.home_work, const PlaceholderScreen()),
              ],
            ),
          ),
          const Spacer(),
          const Text("SME AUTHORITY: JEFFERY DONNELL HUMPHREY", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, Widget target) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Container(
        width: 150, height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          border: Border.all(color: const Color(0xFFC5A059), width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFC5A059), size: 20),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class WarRoom extends StatelessWidget {
  const WarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: EXECUTIVE_OVERSIGHT ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("GRID_STATUS: OPERATIONAL", style: TextStyle(color: Colors.green))),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: MODULE_INITIALIZING ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("DATA_TUNNEL_ESTABLISHING...", style: TextStyle(color: Colors.white24))),
    );
  }
}
