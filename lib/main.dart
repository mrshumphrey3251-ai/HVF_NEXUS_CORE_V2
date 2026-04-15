import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.1 - PHASE 2: WAPANUCKA TELEMETRY
// FOCUS: HELIOGRID SOLAR & RESERVOIR INFRASTRUCTURE
// DAY 2 OF 7 | AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
      home: const FederalCommandGate(),
    );
  }
}

// --- UPDATED COMMAND GATE ---
class FederalCommandGate extends StatelessWidget {
  const FederalCommandGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF111111),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
            Text("PATENT: TPP99424", style: TextStyle(fontSize: 8, color: Colors.white24)),
          ]),
        ),
        const Spacer(),
        const Icon(Icons.hub_outlined, size: 80, color: Color(0xFFC5A059)),
        const Text("HVF NEXUS OS", style: TextStyle(fontSize: 18, letterSpacing: 8, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _cmdBtn(context, "HELIO_GRID_TELEMETRY", const HelioGridScreen()),
        _cmdBtn(context, "RESERVOIR_INFRA_MONITOR", const ReservoirScreen()),
        _cmdBtn(context, "RESIDENTIAL_GRID_200", const ResidentialGrid()),
        const Spacer(),
        const Text("SME AUTHORITY: JEFFERY D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan)),
        const SizedBox(height: 30),
      ]),
    );
  }

  Widget _cmdBtn(BuildContext context, String l, Widget t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(300, 55)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9, letterSpacing: 2)),
    ),
  );
}

// --- DAY 2 MODULE: HELIOGRID ---
class HelioGridScreen extends StatelessWidget {
  const HelioGridScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: HELIOGRID_SOLAR_V1 ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _telemBox("CURRENT_OUTPUT", "482.5 kW", Colors.greenAccent),
          const SizedBox(height: 10),
          _telemBox("STORAGE_CAPACITY", "94%", Colors.cyan),
          const SizedBox(height: 10),
          _telemBox("GRID_STATUS", "OPTIMAL", Colors.white),
          const Spacer(),
          const Text("PROPRIETARY SOLAR INFRASTRUCTURE TRACKING", style: TextStyle(fontSize: 7, color: Colors.white10)),
        ]),
      ),
    );
  }

  Widget _telemBox(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    color: const Color(0xFF0D0D0D),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- DAY 2 MODULE: RESERVOIR ---
class ReservoirScreen extends StatelessWidget {
  const ReservoirScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: RESERVOIR_INFRA ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          _telemBox("WATER_LEVEL", "22.4 FT", Colors.blueAccent),
          const SizedBox(height: 10),
          _telemBox("PUMP_STATUS", "ACTIVE", Colors.green),
          const Spacer(),
          const Icon(Icons.water, size: 100, color: Colors.white10),
        ]),
      ),
    );
  }

  Widget _telemBox(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    color: const Color(0xFF0D0D0D),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- DAY 2 MODULE: RESIDENTIAL ---
class ResidentialGrid extends StatelessWidget {
  const ResidentialGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: 200_UNIT_RESIDENTIAL ::", style: TextStyle(fontSize: 9))),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 200,
        itemBuilder: (context, i) => Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF0D0D0D),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("UNIT_${i + 1}", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            const Text("ADA_COMPLIANT", style: TextStyle(fontSize: 7, color: Colors.grey)),
            const Icon(Icons.circle, color: Colors.green, size: 8),
          ]),
        ),
      ),
    );
  }
}
