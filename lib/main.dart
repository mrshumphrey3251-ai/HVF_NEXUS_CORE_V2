import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V132.0 - THE HUMPHREY STANDARD FINAL
// SOVEREIGN MICRO-ECONOMY & SOCIAL CLUB LEDGER
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
        scaffoldBackgroundColor: const Color(0xFF030303),
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
        backgroundColor: const Color(0xFF000000),
        title: const Text("HVF_NEXUS_V132_FINAL", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildEconomicHeader(),
          const Spacer(),
          const Center(child: Icon(Icons.token_outlined, size: 85, color: Color(0xFFC5A059))),
          const Text("HUMPHREY SOCIAL CLUB", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Text("COMMUNITY_LEDGER_SYSTEM", style: TextStyle(fontSize: 8, color: Colors.white24)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("FORCE TO BE RECKONED WITH | CAGE: 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEconomicHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    decoration: const BoxDecoration(color: Color(0xFF0D0D0D), border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5))),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("WAPANUCKA_CREDITS: ACTIVE", style: TextStyle(fontSize: 7, color: Colors.cyan)),
        Text("COMMUNITY_STABILITY: 100%", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "CREDIT_LEDGER", Icons.account_balance_wallet, const SocialLedger()),
      _btn(context, "VOCATIONAL_MINING", Icons.construction, const Placeholder()),
      _btn(context, "ADA_RESIDENTIAL", Icons.home_work, const Placeholder()),
      _btn(context, "BONA_FIDE_FARM", Icons.agriculture, const Placeholder()),
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

// --- MODULE: SOCIAL CLUB LEDGER ---
class SocialLedger extends StatelessWidget {
  const SocialLedger({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: COMMUNITY_ECONOMIC_CORE ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _ledgerRow("TOTAL_VILLAGE_CREDITS", "HVF 482,900", Colors.cyan),
          const SizedBox(height: 10),
          _ledgerRow("VOCATIONAL_HOURS_LOGGED", "1,240 HRS", Colors.greenAccent),
          const SizedBox(height: 10),
          _ledgerRow("RESTORATION_TRANSFERS", "HVF 12,000", Colors.orangeAccent),
          const Spacer(),
          const Text("INTERNAL SOVEREIGN CURRENCY GOVERNED BY CEO", style: TextStyle(fontSize: 7, color: Colors.white10)),
        ]),
      ),
    );
  }

  Widget _ledgerRow(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      Text(v, style: TextStyle(fontSize: 12, color: c, fontWeight: FontWeight.bold)),
    ]),
  );
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(":: HVF_STANDARDS_VERIFIED ::")));
  }
}
