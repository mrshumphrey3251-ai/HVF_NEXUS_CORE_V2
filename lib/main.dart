import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - PRODUCTION CORE V158.0 
// THE "PERFECT" SPRINT | PERMANENT DATA PERSISTENCE
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5
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
  runApp(const HVFNexusSovereign());
}

class HVFNexusSovereign extends StatelessWidget {
  const HVFNexusSovereign({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SovereignCommandCenter(),
    );
  }
}

class SovereignCommandCenter extends StatefulWidget {
  const SovereignCommandCenter({super.key});
  @override
  State<SovereignCommandCenter> createState() => _SovereignCommandCenterState();
}

class _SovereignCommandCenterState extends State<SovereignCommandCenter> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- THE MASTER TRANSACTION ENGINE ---
  Future<void> _executeSovereignTrade(String lotId, double value) async {
    try {
      // 1. Log the Federal Contract
      await _db.collection('contracts').add({
        'cage_code': '1AHA8',
        'lot_id': lotId,
        'value': value,
        'sme_fee': value * 0.05,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'AUTHORIZED',
      });
      
      // 2. Update the Storm Chest Treasury
      await _db.collection('treasury').doc('storm_chest').update({
        'balance': FieldValue.increment(value * 0.05),
      });

      _notify("TRADE_EXECUTED: CONTRACT_STORED_IN_CLOUD");
    } catch (e) {
      _notify("CMD_ERROR: CHECK_DATABASE_PERMISSIONS");
    }
  }

  void _notify(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m, style: const TextStyle(color: Color(0xFFC5A059)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HVF_NEXUS_ACTUAL", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _db.collection('treasury').doc('storm_chest').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          var chestData = snapshot.data!;
          return Column(
            children: [
              _header(chestData['balance'] ?? 0.0),
              Expanded(child: _marketView()),
            ],
          );
        },
      ),
    );
  }

  Widget _header(double balance) => Container(
    padding: const EdgeInsets.all(20),
    color: const Color(0xFF0D0D0D),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("CAGE: 1AHA8", style: TextStyle(fontSize: 8, color: Colors.cyan)),
        Text("CHEST: \$${balance.toStringAsFixed(2)}", style: const TextStyle(fontSize: 10, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _marketView() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _tradeCard("LOT_A: 50_HEAD_ANGUS", 75000),
      _tradeCard("LOT_B: 4PL_FLEET_UNIT", 120000),
    ],
  );

  Widget _tradeCard(String l, double v) => Card(
    color: const Color(0xFF111111),
    child: ListTile(
      title: Text(l, style: const TextStyle(fontSize: 9)),
      trailing: ElevatedButton(
        onPressed: () => _executeSovereignTrade(l, v),
        child: const Text("EXECUTE", style: TextStyle(fontSize: 8)),
      ),
    ),
  );
}
