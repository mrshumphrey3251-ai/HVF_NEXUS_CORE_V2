import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math'; // FOR SATELLITE SIMULATION LOGIC

// =========================================================
// HVF NEXUS - SOVEREIGN COMMAND V158.8
// FEATURE: SATELLITE TELEMETRY & ASSET INTELLIGENCE
// CAGE: 1AHA8 | AUTHORIZED: JEFFERY DONNELL HUMPHREY
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
      home: const SovereignCommand(),
    );
  }
}

class SovereignCommand extends StatefulWidget {
  const SovereignCommand({super.key});
  @override
  State<SovereignCommand> createState() => _SovereignCommandState();
}

class _SovereignCommandState extends State<SovereignCommand> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // SATELLITE SIMULATION LOGIC
  String _getSimulatedLocation() {
    double lat = 34.1726 + (Random().nextDouble() * 0.01);
    double lon = -96.7731 + (Random().nextDouble() * 0.01);
    return "${lat.toStringAsFixed(4)}, ${lon.toStringAsFixed(4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_SATELLITE_COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.cyan, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              bool isSold = data['status'].toString().toUpperCase() == "SOLD";
              
              return Card(
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF0A0A0A),
                shape: RoundedRectangleBorder(side: BorderSide(color: isSold ? Colors.redAccent : Colors.white10)),
                child: ListTile(
                  leading: Icon(isSold ? Icons.verified_user : Icons.satellite_alt, 
                               color: isSold ? Colors.greenAccent : Colors.cyan, size: 28),
                  title: Text(data['name'] ?? "ASSET_PENDING", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SAT_LOC: ${_getSimulatedLocation()}", style: const TextStyle(color: Colors.cyan, fontSize: 8)),
                      Text("STATUS: ${isSold ? 'SECURED' : 'ACTIVE_MARKET'}", style: const TextStyle(fontSize: 8, color: Colors.white38)),
                    ],
                  ),
                  trailing: isSold ? const Icon(Icons.lock, color: Colors.redAccent, size: 16) : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
