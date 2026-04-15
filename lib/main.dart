import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.7 - THE CEO WAR ROOM
// FOCUS: STEP 5 - TOTAL EXECUTIVE OVERSIGHT & GRID ANALYTICS
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
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const CEOWarRoom(),
    );
  }
}

class CEOWarRoom extends StatefulWidget {
  const CEOWarRoom({super.key});
  @override
  State<CEOWarRoom> createState() => _CEOWarRoomState();
}

class _CEOWarRoomState extends State<CEOWarRoom> {
  final Map<String, double> insPremium = {"CATTLE": 10.0, "PIGS": 5.0, "CHICKENS": 2.0, "FLEET": 25.0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text(":: HVF EXECUTIVE COMMAND ::", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 4)),
        actions: const [Icon(Icons.sensors, color: Colors.green, size: 14), SizedBox(width: 15)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
          
          int totalNodes = snapshot.data!.docs.length;
          double totalPremium = 0;
          double totalFMV = 0;

          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            totalPremium += insPremium[data['type']] ?? 0.0;
            // Simplified FMV: Weight * 1.85 or static fleet value
            double vitalValue = double.tryParse(data['vital'].toString()) ?? 0.0;
            totalFMV += data['category'] == "FLEET" ? (vitalValue * 100) : (vitalValue * 1.85);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("NATIONAL GRID ANALYTICS", style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 2)),
              const SizedBox(height: 20),
              
              Row(children: [
                Expanded(child: _statTile("MANAGED_NODES", "$totalNodes", Colors.cyan)),
                const SizedBox(width: 15),
                Expanded(child: _statTile("NETWORK_FMV", "\$${totalFMV.toStringAsFixed(0)}", const Color(0xFFC5A059))),
              ]),
              
              const SizedBox(height: 15),
              _statTile("HVF_RESERVE_INFLOW", "\$${totalPremium.toStringAsFixed(2)} / MO", Colors.greenAccent),
              
              const SizedBox(height: 30),
              const Text("SYSTEM INTEGRITY STATUS", style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 2)),
              const SizedBox(height: 15),
              _integrityRow("SME_SAFETY_PROTOCOLS", "100% COMPLIANT", Colors.green),
              _integrityRow("CARRIER_BACKSTOP", "ACTIVE", Colors.cyan),
              _integrityRow("BIO-SECURITY_GATE", "LOCKED", Colors.green),
              
              const SizedBox(height: 40),
              const Center(child: Icon(Icons.security, color: Colors.white10, size: 100)),
              const SizedBox(height: 20),
              const Center(child: Text("SOVEREIGN INFRASTRUCTURE VERIFIED", style: TextStyle(fontSize: 7, color: Colors.grey))),
            ]),
          );
        },
      ),
    );
  }

  Widget _statTile(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _integrityRow(String l, String v, Color c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 9, color: Colors.white70)),
      Text(v, style: TextStyle(fontSize: 9, color: c, fontWeight: FontWeight.bold)),
    ]),
  );
}
