import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HVF_NEXUS_ACTUAL", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        backgroundColor: Colors.black,
      ),
      // THE FAIL-SAFE STREAM
      body: StreamBuilder<DocumentSnapshot>(
        stream: _db.collection('treasury').doc('storm_chest').snapshots(),
        builder: (context, snapshot) {
          // If connection is waiting or data is missing, show "Zero" instead of Grey
          double currentBalance = 0.0;
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            currentBalance = (data['balance'] ?? 0.0).toDouble();
          }
          
          return Column(
            children: [
              _header(currentBalance),
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
        Text("CHEST: \$${balance.toStringAsFixed(2)}", 
          style: const TextStyle(fontSize: 10, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _marketView() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _tradeCard("LOT_A: 50_HEAD_ANGUS", 75000),
      _tradeCard("LOT_B: 4PL_FLEET_UNIT", 120000),
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text(":: OPERATIONAL_READY ::", 
          textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: Colors.white10)),
      )
    ],
  );

  Widget _tradeCard(String l, double v) => Card(
    color: const Color(0xFF111111),
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      title: Text(l, style: const TextStyle(fontSize: 9)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFC5A059)),
    ),
  );
}
