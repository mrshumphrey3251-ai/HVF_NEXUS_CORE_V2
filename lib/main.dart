import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V126.0 - THE SUPREMACY CORE (WEATHER OVERLAY)
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
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
            Text("WAPANUCKA_WX: 72°F | CLEAR", style: TextStyle(fontSize: 7, color: Colors.greenAccent)), // WEATHER SENTINEL
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _weatherTicker(),
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

  Widget _weatherTicker() => Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wind_power, color: Colors.cyan, size: 10),
        SizedBox(width: 5),
        Text("WIND: 8 MPH NW | CRANE_OPS: SAFE", style: TextStyle(fontSize: 7, color: Colors.white70)),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "WAR_ROOM", Icons.analytics),
      _btn(context, "INST_BUYER", Icons.shopping_cart),
      _btn(context, "RESERVOIR", Icons.water),
      _btn(context, "VA_VAULT", Icons.history_edu),
      _btn(context, "EXCHANGE", Icons.currency_exchange),
      _btn(context, "LOGISTICS", Icons.local_shipping),
    ],
  );

  Widget _btn(BuildContext context, String l, IconData i) => Container(
    width: 150, height: 90,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(i, color: const Color(0xFFC5A059), size: 24),
      const SizedBox(height: 8),
      Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
    ]),
  );
}
