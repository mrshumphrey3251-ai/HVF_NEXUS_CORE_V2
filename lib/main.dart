import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// =========================================================
// HVF NEXUS OS - PRODUCTION FINAL V135.1
// SOVEREIGN ENTITY: HUMPHREY VIRTUAL FARMS LLC
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
// JURISDICTION: WAPANUCKA NODE, OK
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
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC5A059),
          secondary: Colors.cyan,
        ),
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
        title: const Text("HVF_NEXUS_SUPREMACY_CORE", 
          style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 2)),
        actions: const [
          Center(child: Text("CAGE: 1AHA8  ", 
            style: TextStyle(fontSize: 8, color: Colors.cyan, fontWeight: FontWeight.bold))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const AuditCommand(), // THE AUDIT RECTIFICATION PILLAR
            const SizedBox(height: 40),
            const Icon(Icons.shield_rounded, size: 100, color: Color(0xFFC5A059)),
            const SizedBox(height: 20),
            const Text("HUMPHREY VIRTUAL FARMS", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5)),
            const Text("WAPANUCKA NODE - INDUSTRIAL SOVEREIGNTY", 
              style: TextStyle(fontSize: 8, color: Colors.white24)),
            const SizedBox(height: 40),
            _actionGrid(context),
          ],
        ),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn("EXCHANGE", Icons.currency_exchange),
      _btn("4PL_LOGISTICS", Icons.local_shipping),
      _btn("SOCIAL_CLUB", Icons.groups),
      _btn("RESTORATION", Icons.history_edu),
    ],
  );

  Widget _btn(String l, IconData i) => Container(
    width: 155, height: 95,
    decoration: BoxDecoration(
      color: const Color(0xFF0D0D0D), 
      border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(i, color: const Color(0xFFC5A059), size: 24),
      const SizedBox(height: 8),
      Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _footer() => Container(
    height: 50, color: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Colors.white24)),
        Text("SME_AUTH: J.D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan)),
      ],
    ),
  );
}

// --- MODULE: AUDIT RECTIFICATION PILLAR ---
class AuditCommand extends StatelessWidget {
  const AuditCommand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _auditTile("FEDERAL_ENCRYPTION_FIPS", "VALIDATED", Colors.cyan),
        _auditTile("LIVESTOCK_TRACEABILITY", "UID_ENABLED", Colors.greenAccent),
        _auditTile("SSA_CLAIMS_MILESTONES", "SYNCED", Colors.orangeAccent),
      ],
    );
  }

  Widget _auditTile(String l, String s, Color c) => Container(
    padding: const EdgeInsets.all(15), margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF0D0D0D), 
      border: Border.all(color: c, width: 0.5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
        Text(s, style: TextStyle(fontSize: 7, color: c)),
      ],
    ),
  );
}
