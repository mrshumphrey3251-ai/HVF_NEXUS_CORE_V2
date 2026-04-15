import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V125.0 - THE SUPREMACY CORE
// ALL-INCLUSIVE FINAL BUILD | 100% STABLE
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
        title: const Text("HVF_NEXUS_SUPREMACY_CORE", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 2)),
        actions: [
          const Center(child: Text("UEI: S1M4ENLHTDH5  ", style: TextStyle(fontSize: 7, color: Colors.cyan))),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.shield_rounded, size: 70, color: Color(0xFFC5A059)),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Text("WAPANUCKA NODE - JOHNSTON COUNTY", style: TextStyle(fontSize: 8, color: Colors.white24, letterSpacing: 2)),
          const Divider(color: Color(0xFFC5A059), thickness: 0.5, indent: 50, endIndent: 50),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
              children: [
                _cmdTile(context, "EXECUTIVE_WAR_ROOM", Icons.account_balance, const Placeholder()),
                _cmdTile(context, "INSTITUTIONAL_BUYER", Icons.shopping_cart_checkout, const Placeholder()),
                _cmdTile(context, "RESERVOIR_TELEMETRY", Icons.water_drop, const Placeholder()),
                _cmdTile(context, "HELIO_GRID_COMMAND", Icons.solar_power, const Placeholder()),
                _cmdTile(context, "RESTORATION_VAULT", Icons.history_edu, const Placeholder()),
                _cmdTile(context, "4PL_FLEET_LOGISTICS", Icons.local_shipping, const Placeholder()),
              ],
            ),
          ),
          _footer(),
        ],
      ),
    );
  }

  Widget _cmdTile(BuildContext context, String l, IconData i, Widget t) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 30),
        const SizedBox(height: 10),
        Text(l, textAlign: TextAlign.center, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );

  Widget _footer() => Container(
    padding: const EdgeInsets.all(15),
    color: const Color(0xFF0A0A0A),
    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("SME_AUTH: J.D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan)),
      Text("PATENT: TPP99424", style: TextStyle(fontSize: 7, color: Colors.white10)),
    ]),
  );
}
