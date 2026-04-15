import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - HARDENED COMMAND V158.9
// BULLETPROOF SATELLITE INTERFACE
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
  runApp(const HVFNexusFinal());
}

class HVFNexusFinal extends StatelessWidget {
  const HVFNexusFinal({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SovereignHub(),
    );
  }
}

class SovereignHub extends StatefulWidget {
  const SovereignHub({super.key});
  @override
  State<SovereignHub> createState() => _SovereignHubState();
}

class _SovereignHubState extends State<SovereignHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_SATELLITE_CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.cyan, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              bool isSold = data['status'].toString().toUpperCase() == "SOLD";
              
              return Card(
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF0D0D0D),
                child: ListTile(
                  leading: Icon(isSold ? Icons.verified : Icons.satellite_alt, 
                               color: isSold ? Colors.greenAccent : Colors.cyan),
                  title: Text(data['name'] ?? "ASSET_LOADED", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  subtitle: Text("SAT_LINK_ACTIVE | CAGE: 1AHA8", style: const TextStyle(color: Colors.white24, fontSize: 8)),
                  trailing: isSold 
                    ? const Icon(Icons.lock, color: Colors.redAccent, size: 16)
                    : const Text("READY", style: TextStyle(color: Colors.cyan, fontSize: 8)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
