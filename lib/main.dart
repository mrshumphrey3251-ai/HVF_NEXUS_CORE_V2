import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V126.4 - THE NATIONAL COMMAND
// 1500 EXECUTION | LOGISTICS & SCALE
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
            Text("LOGISTICS_MODE: NATIONAL", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildWeatherOverlay(),
          const Spacer(),
          const Center(child: Icon(Icons.public_rounded, size: 80, color: Color(0xFFC5A059))),
          const Text("HVF NATIONAL GRID", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("MULTI-NODE SOVEREIGNTY: ACTIVE", style: TextStyle(fontSize: 7, color: Colors.cyan)),
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
        Icon(Icons.local_shipping, color: Colors.cyan, size: 10),
        SizedBox(width: 5),
        Text("FLEET_STATUS: 12 SEMIS ACTIVE | NCCO_OPS: CLEAR", style: TextStyle(fontSize: 7, color: Colors.white70)),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "4PL_LOGISTICS", Icons.local_shipping, const LogisticsCommand()),
      _btn(context, "NATIONAL_NODES", Icons.map_outlined, const NodeMap()),
      _btn(context, "RESTORATION_VAULT", Icons.history_edu, const Placeholder()),
      _btn(context, "RESERVOIR_HUB", Icons.water, const Placeholder()),
      _btn(context, "HELIO_GRID", Icons.solar_power, const Placeholder()),
      _btn(context, "EXCHANGE", Icons.currency_exchange, const Placeholder()),
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

// --- MODULE: LOGISTICS COMMAND ---
class LogisticsCommand extends StatelessWidget {
  const LogisticsCommand({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: 4PL_FLEET_LOGISTICS ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          _manifestItem("ACTIVE_LOADS", "4 UNITS", Colors.cyan),
          const SizedBox(height: 10),
          _manifestItem("SEMI_FLEET_STATUS", "8 ONLINE", Colors.greenAccent),
          const SizedBox(height: 10),
          _manifestItem("CRANE_AVAILABILITY", "2 UNITS", Color(0xFFC5A059)),
        ]),
      ),
    );
  }

  Widget _manifestItem(String l, String v, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      Text(v, style: TextStyle(fontSize: 10, color: c, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- MODULE: NATIONAL NODE MAP ---
class NodeMap extends StatelessWidget {
  const NodeMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: 50-STATE_GRID_PROJECTION ::", style: TextStyle(fontSize: 9))),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _node("NODE_001_OK_WAPANUCKA", "OPERATIONAL / 100%", Colors.greenAccent),
          _node("NODE_002_TX_PANHANDLE", "DEVELOPMENT / 20%", Colors.orangeAccent),
          _node("NODE_003_KS_CENTRAL", "PLANNED", Colors.white24),
          const SizedBox(height: 40),
          const Center(child: Icon(Icons.public, size: 100, color: Colors.white10)),
        ],
      ),
    );
  }

  Widget _node(String l, String v, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(15),
    color: const Color(0xFF0D0D0D),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 8)),
      Text(v, style: TextStyle(fontSize: 7, color: c)),
    ]),
  );
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("UPLINK_STABLE")));
  }
}
