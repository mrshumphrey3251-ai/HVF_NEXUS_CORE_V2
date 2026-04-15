import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V131.0 - BONA FIDE SOVEREIGNTY
// COMMUNITY, LIVESTOCK, & ADA HOUSING LOCK
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
        scaffoldBackgroundColor: const Color(0xFF050505),
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
        title: const Text("HVF_NEXUS_BONA_FIDE_CORE", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSovereignStatusHeader(),
          const Spacer(),
          const Center(child: Icon(Icons.agriculture_rounded, size: 80, color: Color(0xFFC5A059))),
          const Text("WAPANUCKA NODE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Text("1840s MINING TOWN INDUSTRIAL OS", style: TextStyle(fontSize: 8, color: Colors.white24, letterSpacing: 2)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("SME REGISTERED | CAGE: 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSovereignStatusHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    decoration: const BoxDecoration(color: Color(0xFF111111), border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5))),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("ADA_HOUSING: 200 UNITS", style: TextStyle(fontSize: 7, color: Colors.cyan)),
        Text("SOCIAL_CLUB: ONLINE", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "BONA_FIDE_FARM", Icons.grass, const FarmModule()),
      _childBtn(context, "SOCIAL_CLUB", Icons.groups),
      _childBtn(context, "ADA_RESIDENTIAL", Icons.home_work),
      _childBtn(context, "RESTORATION_VAULT", Icons.history_edu),
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

  Widget _childBtn(BuildContext context, String l, IconData i) => Container(
    width: 155, height: 95,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: Colors.white10, width: 0.5)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(i, color: Colors.white24, size: 24),
      const SizedBox(height: 8),
      Text(l, style: const TextStyle(fontSize: 7, color: Colors.white24)),
    ]),
  );
}

// --- MODULE: BONA FIDE FARM (LIVESTOCK & VITICULTURE) ---
class FarmModule extends StatelessWidget {
  const FarmModule({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: BONA_FIDE_AGRICULTURE ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _farmStat("CATTLE_INVENTORY", "HEAD_COUNT: 450", Colors.brown),
          const SizedBox(height: 10),
          _farmStat("VINEYARD_YIELD", "EST_HARVEST: 12.4 TONS", Colors.deepPurple),
          const SizedBox(height: 10),
          _farmStat("RESERVOIR_DRAW", "4500 GAL / DAY", Colors.blueAccent),
          const Spacer(),
          const Text("SME GOVERNED LAND ASSETS", style: TextStyle(fontSize: 7, color: Colors.white24)),
        ]),
      ),
    );
  }

  Widget _farmStat(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      Text(v, style: TextStyle(fontSize: 10, color: c, fontWeight: FontWeight.bold)),
    ]),
  );
}
