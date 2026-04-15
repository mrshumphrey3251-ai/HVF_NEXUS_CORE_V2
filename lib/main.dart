import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V126.5 - THE ADVOCACY SUPREMACY BUILD
// 1700 FINAL SEAL | INTEGRATED SSI & MILITARY BENEFITS
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
        title: const Text("HVF_NEXUS_CORE_V2.5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSovereignHeader(),
          const Spacer(),
          const Icon(Icons.shield_rounded, size: 85, color: Color(0xFFC5A059)),
          const Text("RESTORATION & SUPREMACY", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("GOVERNMENT REGISTERED: CAGE 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSovereignHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("WAPANUCKA_WX: 74°F", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
        Text("SSI_MIL_ADV: ACTIVE", style: TextStyle(fontSize: 7, color: Colors.cyan, fontWeight: FontWeight.bold)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "BENEFITS_ADVOCACY", Icons.gavel, const BenefitsVault()),
      _btn(context, "RESTORATION_VAULT", Icons.history_edu, const Placeholder()),
      _btn(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const Placeholder()),
      _btn(context, "SOVEREIGN_EXCHANGE", Icons.currency_exchange, const Placeholder()),
      _btn(context, "RESERVOIR_HUB", Icons.water, const Placeholder()),
      _btn(context, "4PL_LOGISTICS", Icons.local_shipping, const Placeholder()),
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

// --- MODULE: BENEFITS ADVOCACY VAULT ---
class BenefitsVault extends StatelessWidget {
  const BenefitsVault({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: SSI & MILITARY BENEFITS ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _benefitCat("SSI/SSDI_CLAIMS", "42 ACTIVE / 12 PENDING", Colors.orangeAccent),
          const SizedBox(height: 15),
          _benefitCat("VA_DISABILITY_RATINGS", "100% SUCCESS_TARGET", Colors.cyan),
          const SizedBox(height: 15),
          _benefitCat("VOCATIONAL_REHAB", "CH-31 ENROLLMENT: 28", Colors.greenAccent),
          const Spacer(),
          const Text("FEDERAL ADVOCACY ARCHITECTURE: HUMPHREY STANDARD", style: TextStyle(fontSize: 7, color: Colors.white10)),
        ]),
      ),
    );
  }

  Widget _benefitCat(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
