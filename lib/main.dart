import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V126.2 - UTILITY SOVEREIGNTY BIND
// 1100 EXECUTION | LIVE DATA INTEGRATION
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("CAGE: 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
            Text("GRID_TELEMETRY: LIVE", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildWeatherOverlay(),
          const Spacer(),
          const Icon(Icons.shield_rounded, size: 80, color: Color(0xFFC5A059)),
          const Text("HVF NEXUS SUPREMACY", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("SME AUTHORITY: JEFFERY D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWeatherOverlay() => Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.radar, color: Colors.greenAccent, size: 10),
        SizedBox(width: 5),
        Text("WAPANUCKA NODE: 74°F | WIND 9MPH | SEVERE_ALERT: NONE", style: TextStyle(fontSize: 7, color: Colors.white70)),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const Placeholder()),
      _btn(context, "RESERVOIR_HUB", Icons.water, const ReservoirHub()),
      _btn(context, "HELIO_GRID", Icons.solar_power, const HelioGridCommand()),
      _btn(context, "VA_ADVOCACY", Icons.history_edu, const Placeholder()),
      _btn(context, "SOVEREIGN_EXCHANGE", Icons.currency_exchange, const Placeholder()),
      _btn(context, "4PL_LOGISTICS", Icons.local_shipping, const Placeholder()),
    ],
  );

  Widget _btn(BuildContext context, String l, IconData i, Widget t) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 150, height: 90,
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 24),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

// --- MODULE: RESERVOIR HUB ---
class ReservoirHub extends StatelessWidget {
  const ReservoirHub({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: 25-ACRE_RESERVOIR_CONTROL ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          _metric("CURRENT_DEPTH", "22.4 FT", Colors.blueAccent),
          const SizedBox(height: 10),
          _metric("PUMP_VOLUME", "1,250 GPM", Colors.cyan),
          const Spacer(),
          const Text("WATER SOVEREIGNTY: ESTABLISHED", style: TextStyle(fontSize: 7, color: Colors.white24)),
        ]),
      ),
    );
  }

  Widget _metric(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- MODULE: HELIOGRID COMMAND ---
class HelioGridCommand extends StatelessWidget {
  const HelioGridCommand({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: HELIOGRID_SOLAR_OS ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          _metric("SOLAR_OUTPUT", "482.5 kW", Colors.orangeAccent),
          const SizedBox(height: 10),
          _metric("BATT_STORAGE", "94.2%", Colors.greenAccent),
          const Spacer(),
          const Text("ENERGY SOVEREIGNTY: ACTIVE", style: TextStyle(fontSize: 7, color: Colors.white24)),
        ]),
      ),
    );
  }

  Widget _metric(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("SYNCING_1100_PILLAR...")));
  }
}
