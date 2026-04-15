import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V126.1 - THE CAPITAL CIRCUIT
// MIL-SPEC STABILITY | 0900 EXECUTION
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
            Text("WAPANUCKA_RADAR: ACTIVE", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
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
        Icon(Icons.warning_amber_rounded, color: Colors.greenAccent, size: 10),
        SizedBox(width: 5),
        Text("WIND: 12MPH | CRANE_OPS: GREEN | RESERVOIR: 22.4FT", style: TextStyle(fontSize: 7, color: Colors.white70)),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const WarRoom()),
      _btn(context, "INST_BUYER_CORE", Icons.shopping_cart, const BuyerTerminal()),
      _btn(context, "RESERVOIR_HUB", Icons.water, const Placeholder()),
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

// --- MODULE: INSTITUTIONAL BUYER TERMINAL ---
class BuyerTerminal extends StatelessWidget {
  const BuyerTerminal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: INSTITUTIONAL_ACQUISITION ::", style: TextStyle(fontSize: 9))),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_person, size: 50, color: Colors.white10),
            SizedBox(height: 20),
            Text("INSTITUTIONAL LIQUIDITY PORTAL", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
            Text("SECURED VIA CAGE 1AHA8", style: TextStyle(fontSize: 8, color: Colors.cyan)),
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
      appBar: AppBar(title: const Text(":: STORM_CHEST_METRICS ::", style: TextStyle(fontSize: 9))),
      body: const Center(child: Text("HVF_RESERVE_RELIANCE: \$0.00", style: TextStyle(color: Colors.white24))),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("DATA_SYNC_PENDING...")));
  }
}
