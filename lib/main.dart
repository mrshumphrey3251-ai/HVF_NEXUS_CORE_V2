import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// =========================================================
// HVF NEXUS OS - FINAL PRODUCTION BUILD V135.0
// SOVEREIGN ENTITY: HUMPHREY VIRTUAL FARMS LLC
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
// JURISDICTION: WAPANUCKA NODE, JOHNSTON COUNTY, OK
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)
// =========================================================

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
  runApp(const HVFNexusFinal());
}

class HVFNexusFinal extends StatelessWidget {
  const HVFNexusFinal({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("HVF_NEXUS_SUPREMACY_CORE", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 3)),
        actions: const [
          Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan, fontWeight: FontWeight.bold))),
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundTexture(),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield_rounded, size: 120, color: Color(0xFFC5A059)),
                SizedBox(height: 20),
                Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 6)),
                Text("WAPANUCKA NODE - INDUSTRIAL SOVEREIGNTY", style: TextStyle(fontSize: 9, color: Colors.white24, letterSpacing: 2)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildSovereignFooter(),
    );
  }

  Widget _buildBackgroundTexture() => Opacity(
    opacity: 0.05,
    child: Container(decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://www.transparenttextures.com/patterns/carbon-fibre.png'), repeat: ImageRepeat.repeat))),
  );

  Widget _buildSovereignFooter() => Container(
    height: 60,
    color: const Color(0xFF0A0A0A),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Colors.white38)),
        Text("SYSTEM_STATUS: BATTLE_READY", style: TextStyle(fontSize: 8, color: Colors.greenAccent)),
        Text("SME: J.D. HUMPHREY", style: TextStyle(fontSize: 8, color: Colors.cyan)),
      ],
    ),
  );
}
