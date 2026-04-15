import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - BULLETPROOF INTERLOCK V158.5
// SME COMMAND: ZERO-FAILURE STATUS RECOGNITION
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

  Future<void> _executeTrade(String docId, String name, dynamic val) async {
    try {
      int value = (val is int) ? val : int.tryParse(val.toString()) ?? 0;
      
      // FORCING THE UPDATE TO THE DATABASE
      await _db.collection('enterprise_ledger').doc(docId).set({
        'status': 'SOLD',
      }, SetOptions(merge: true));

      _notify("EXECUTION_SUCCESS: $name | DATABASE_UPDATED");
    } catch (e) {
      _notify("CMD_ERROR: SYSTEM_HALTED");
    }
  }

  void _notify(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(m, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HVF_NEXUS_COMMAND_V158.5", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        backgroundColor: Colors.black,
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
              String docId = docs[index].id;
              
              // AGGRESSIVE DATA NORMALIZATION
              String rawStatus = (data['status'] ?? "AVAILABLE").toString().trim().toUpperCase();
              bool isSold = rawStatus == "SOLD";
              
              return Card(
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                child: ListTile(
                  title: Text(data['name'] ?? "UNNAMED", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                  subtitle: Text("VALUE: \$${data['value']} | STATUS: $rawStatus", 
                    style: TextStyle(fontSize: 8, color: isSold ? Colors.redAccent : Colors.cyan)),
                  trailing: isSold 
                    ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 24)
                    : ElevatedButton(
                        onPressed: () => _executeTrade(docId, data['name'] ?? "UNNAMED", data['value']),
                        child: const Text("EXECUTE", style: TextStyle(fontSize: 7)),
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
