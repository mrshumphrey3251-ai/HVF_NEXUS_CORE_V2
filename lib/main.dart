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
      appId: "1:892263251736:web:899cc6ab03f6f5e9d8286d",
    ),
  );
  
  // FORCE-INJECTION: Bypassing the UI to test the database connection
  FirebaseFirestore.instance.collection('enterprise_ledger').add({
    'name': 'SYSTEM RECOVERY TEST',
    'vital': 'CONNECTION VERIFIED',
    'price': 0.0,
    'status': 'AVAILABLE',
    'timestamp': FieldValue.serverTimestamp()
  });

  runApp(const MaterialApp(home: HVFNexusV2(), debugShowCheckedModeBanner: false));
}

class HVFNexusV2 extends StatefulWidget {
  const HVFNexusV2({super.key});
  @override
  State<HVFNexusV2> createState() => _HVFNexusV2State();
}

class _HVFNexusV2State extends State<HVFNexusV2> {
  String view = "GATE";
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("HVF NEXUS RECOVERY", style: TextStyle(color: Color(0xFFC5A059)))),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          if (snap.data!.docs.isEmpty) return const Center(child: Text("DATABASE STILL DISCONNECTED", style: TextStyle(color: Colors.red)));
          return ListView(
            children: snap.data!.docs.map((d) => ListTile(
              title: Text(d['name'] ?? "UNKNOWN", style: const TextStyle(color: Colors.white)),
              subtitle: Text("STATUS: ${d['status']}", style: const TextStyle(color: Colors.white38)),
            )).toList(),
          );
        },
      ),
    );
  }
}
