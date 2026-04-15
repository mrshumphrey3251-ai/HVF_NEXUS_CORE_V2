import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - BOOTS ON THE GROUND V158.10
// MANUAL SME AUDIT | ZERO-LATENCY COMMAND
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
  runApp(const HVFNexusManual());
}

class HVFNexusManual extends StatelessWidget {
  const HVFNexusManual({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SMEAuditHub(),
    );
  }
}

class SMEAuditHub extends StatefulWidget {
  const SMEAuditHub({super.key});
  @override
  State<SMEAuditHub> createState() => _SMEAuditHubState();
}

class _SMEAuditHubState extends State<SMEAuditHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _verifyAsset(String docId, String name) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
      _notify("SME_VERIFICATION_COMPLETE: $name");
    } catch (e) {
      _notify("AUDIT_FAILED: CHECK_PERMISSIONS");
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_MANUAL_AUDIT_CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
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
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: isSold ? Colors.greenAccent : Colors.white10),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListTile(
                  leading: Icon(isSold ? Icons.fact_check : Icons.pending_actions, 
                               color: isSold ? Colors.greenAccent : Colors.white30),
                  title: Text(data['name'] ?? "UNNAMED_ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  subtitle: Text(isSold ? "SME_VERIFIED: CEO" : "AWAITING_MANUAL_AUDIT", 
                            style: TextStyle(fontSize: 8, color: isSold ? Colors.greenAccent : Colors.white24)),
                  trailing: isSold 
                    ? const Icon(Icons.verified, color: Colors.greenAccent, size: 20)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF222222)),
                        onPressed: () => _verifyAsset(docs[index].id, data['name'] ?? "ASSET"),
                        child: const Text("AUDIT", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
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
