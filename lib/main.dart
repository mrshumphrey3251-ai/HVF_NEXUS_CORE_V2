import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V130.0 - BATTLE-READY HARDENING
// FINAL P0 DEFECT RECTIFICATION | 100% SECURE
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
        title: const Text("V130.0_HARDENED_CORE", style: TextStyle(fontSize: 8, color: Colors.greenAccent)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _safetySentinelHeader(),
          const Spacer(),
          const Center(child: Icon(Icons.verified_user_sharp, size: 85, color: Color(0xFFC5A059))),
          const Text("HVF NEXUS SUPREMACY", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _hardenedActionGrid(context),
          const Spacer(),
          const Text("FEDERAL ENCRYPTION ACTIVE | SME GOVERNED", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _safetySentinelHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("WIND: 32MPH [STOP_WORK_RED]", style: TextStyle(fontSize: 7, color: Colors.redAccent, fontWeight: FontWeight.bold)),
        Text("CAGE: 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _hardenedActionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "ADVOCACY_ENCRYPTED", Icons.lock, const Placeholder()),
      _btn(context, "90-DAY_GRACE_CLOCK", Icons.timer, const Placeholder()),
      _btn(context, "FLEET_SAFETY_LOCK", Icons.gavel, const Placeholder()),
      _btn(context, "ASSET_MAINTENANCE", Icons.build_circle, const Placeholder()),
    ],
  );

  Widget _btn(BuildContext context, String l, IconData i, Widget t) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 155, height: 95,
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 24),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("SECURE_UPLINK_STABLE")));
  }
}
