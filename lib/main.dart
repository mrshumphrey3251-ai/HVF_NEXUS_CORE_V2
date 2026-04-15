import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V133.0 - THE COMMAND INTERLOCK
// AUTOMATED MANIFEST & SME ASSIGNMENT
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
        scaffoldBackgroundColor: const Color(0xFF020202),
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
        backgroundColor: Colors.black,
        title: const Text("COMMAND_INTERLOCK_V133", style: TextStyle(fontSize: 8, color: Colors.cyan, letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _logisticsTicker(),
          const Spacer(),
          const Center(child: Icon(Icons.settings_input_component_rounded, size: 85, color: Color(0xFFC5A059))),
          const Text("HVF COMMAND INTERLOCK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Text("FULL-SPECTRUM ASSET ORCHESTRATION", style: TextStyle(fontSize: 8, color: Colors.white24)),
          const Spacer(),
          _interlockGrid(context),
          const Spacer(),
          const Text("CAGE: 1AHA8 | FEDERAL LOGISTICS ACTIVE", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _logisticsTicker() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("FLEET_READY: 12", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
        Text("PENDING_MANIFESTS: 3", style: TextStyle(fontSize: 7, color: Colors.orangeAccent)),
        Text("SME_DRIVERS_ON_DECK: 5", style: TextStyle(fontSize: 7, color: Colors.cyan)),
      ],
    ),
  );

  Widget _interlockGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "EXCHANGE_GATEWAY", Icons.currency_exchange, const Placeholder()),
      _btn(context, "MANIFEST_GENERATOR", Icons.description_rounded, const ManifestEngine()),
      _btn(context, "FLEET_DEPLOYMENT", Icons.local_shipping, const Placeholder()),
      _btn(context, "SME_ASSIGNMENT", Icons.person_search, const Placeholder()),
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

class ManifestEngine extends StatelessWidget {
  const ManifestEngine({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: AUTO_MANIFEST_ORCHESTRATOR ::", style: TextStyle(fontSize: 9))),
      body: const Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text("AUTOMATED SHIPPING ASSIGNMENT", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
            Divider(color: Colors.white10),
            ListTile(title: Text("LOAD_ID: HVF-772", style: TextStyle(fontSize: 8)), subtitle: Text("STATUS: MATCHING_FLEET", style: TextStyle(color: Colors.cyan, fontSize: 8))),
            ListTile(title: Text("DRIVER_ID: PENDING", style: TextStyle(fontSize: 8)), subtitle: Text("RESTORATION_STATUS: CDL_VERIFIED", style: TextStyle(color: Colors.greenAccent, fontSize: 8))),
          ],
        ),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(":: INTERLOCK_STABLE ::")));
  }
}
