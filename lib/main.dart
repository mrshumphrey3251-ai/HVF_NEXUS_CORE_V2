import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
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
    runApp(const MaterialApp(home: HVFRecoveryCore(), debugShowCheckedModeBanner: false));
  } catch (e) {
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text("FATAL BOOT ERROR: $e")))));
  }
}

class HVFRecoveryCore extends StatelessWidget {
  const HVFRecoveryCore({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS: EMERGENCY RECOVERY", style: TextStyle(color: Color(0xFFC5A059), fontSize: 14)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await db.collection('enterprise_ledger').add({
                'name': 'CEO_SIGNAL_RECOVERY',
                'timestamp': FieldValue.serverTimestamp(),
                'status': 'VERIFIED'
              });
            }, 
            child: const Text("FORCE INJECT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('enterprise_ledger').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text("SIGNAL BLOCKED: ${snap.error}", style: const TextStyle(color: Colors.red)));
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
          
          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const Center(child: Text("NO DATA FOUND IN CLOUD LEDGER", style: TextStyle(color: Colors.white24)));
          }

          return ListView.builder(
            itemCount: snap.data!.docs.length,
            itemBuilder: (context, i) {
              var d = snap.data!.docs[i];
              return Card(
                color: const Color(0xFF111111),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.radar, color: Colors.green),
                  title: Text(d['name'] ?? "UNKNOWN ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("DB_ID: ${d.id}", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  trailing: IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => d.reference.delete()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
