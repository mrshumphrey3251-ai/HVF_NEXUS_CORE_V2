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
  runApp(const MaterialApp(home: HVFRecovery(), debugShowCheckedModeBanner: false));
}

class HVFRecovery extends StatelessWidget {
  const HVFRecovery({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        title: const Text("HVF SYSTEM RECOVERY", style: TextStyle(color: Color(0xFFC5A059))),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.green),
            onPressed: () {
              // DIRECT INJECTION TEST
              db.collection('enterprise_ledger').add({
                'name': 'MANUAL_SIGNAL_TEST',
                'status': 'LIVE',
                'timestamp': FieldValue.serverTimestamp()
              });
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('enterprise_ledger').snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "SIGNAL LOST: HIT REFRESH ICON TO TEST INJECTION",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView(
            children: snap.data!.docs.map((d) => ListTile(
              leading: const Icon(Icons.router, color: Colors.green),
              title: Text(d['name'] ?? "EMPTY_NODE", style: const TextStyle(color: Colors.white)),
              subtitle: Text("ID: ${d.id}", style: const TextStyle(color: Colors.white24, fontSize: 10)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => d.reference.delete(),
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}
