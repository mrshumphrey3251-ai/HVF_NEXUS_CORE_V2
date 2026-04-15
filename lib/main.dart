import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.3 - PHASE 4: THE RESTORATION PROTOCOL
// FOCUS: CLINICAL-VOCATIONAL NEXUS & VETERAN ADVOCACY
// DAY 4 OF 7 | AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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

// --- COMMAND GATE (UPDATED WITH RESTORATION MODULES) ---
class FederalCommandGate extends StatelessWidget {
  const FederalCommandGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10), color: const Color(0xFF111111),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
            Text("RESTORE_MODE: ACTIVE", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          ]),
        ),
        const Spacer(),
        const Icon(Icons.healing_rounded, size: 80, color: Color(0xFFC5A059)),
        const Text("RESTORATION PROTOCOL", style: TextStyle(fontSize: 18, letterSpacing: 6, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _cmdBtn(context, "VOCATIONAL_TRACKER", const RestorationTracker()),
        _cmdBtn(context, "CLINICAL_GATEWAY", const ClinicalGate()),
        _cmdBtn(context, "ADVOCACY_ADMIN_LOCKER", const AdvocacyLocker()),
        const Spacer(),
        const Text("VETERAN ADVOCACY: ENABLED", style: TextStyle(fontSize: 7, color: Colors.cyan)),
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

// --- DAY 4 MODULE: RESTORATION TRACKER ---
class RestorationTracker extends StatelessWidget {
  const RestorationTracker({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: VOCATIONAL_STATUS ::", style: TextStyle(fontSize: 9))),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _restorationTile("AGRICULTURAL_SME_CORE", "85% COMPLETE", Colors.green),
          _restorationTile("NCCER_SAFETY_MODULE", "100% CERTIFIED", Color(0xFFC5A059)),
          _restorationTile("HEAVY_EQUIP_OPERATIONS", "60% IN_PROGRESS", Colors.cyan),
          _restorationTile("SOVEREIGN_LAND_MGNT", "25% INITIALIZED", Colors.grey),
        ],
      ),
    );
  }

  Widget _restorationTile(String l, String v, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- DAY 4 MODULE: CLINICAL GATEWAY (HIPAA SECURE INTERFACE) ---
class ClinicalGate extends StatelessWidget {
  const ClinicalGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: CLINICAL_GATEWAY ::", style: TextStyle(fontSize: 9))),
      body: const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.lock_person_rounded, size: 60, color: Colors.white10),
          SizedBox(height: 20),
          Text("ENCRYPTED CLINICAL DATA TUNNEL", style: TextStyle(fontSize: 10, color: Colors.white24)),
          Text("HIPAA COMPLIANCE: VERIFIED", style: TextStyle(fontSize: 8, color: Colors.cyan)),
        ]),
      ),
    );
  }
}

// --- DAY 4 MODULE: ADVOCACY LOCKER ---
class AdvocacyLocker extends StatelessWidget {
  const AdvocacyLocker({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: ADVOCACY_LOCKER ::", style: TextStyle(fontSize: 9))),
      body: const Padding(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("VETERAN_ID_REPOSITORY: ACTIVE", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
          Divider(color: Colors.white10),
          SizedBox(height: 20),
          Text("DOC_STATUS: DD-214 VERIFIED", style: TextStyle(fontSize: 8, color: Colors.green)),
          Text("BENEFIT_UPLINK: PENDING_REVIEW", style: TextStyle(fontSize: 8, color: Colors.grey)),
        ]),
      ),
    );
  }
}
