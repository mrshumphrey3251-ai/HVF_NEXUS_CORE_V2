import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - AUDIT INTERLOCK V158.15
// INSPECT FIRST | AUTHORIZE SECOND
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
  runApp(const HVFNexusInterlock());
}

class HVFNexusInterlock extends StatelessWidget {
  const HVFNexusInterlock({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const AuditHub(),
    );
  }
}

class AuditHub extends StatefulWidget {
  const AuditHub({super.key});
  @override
  State<AuditHub> createState() => _AuditHubState();
}

class _AuditHubState extends State<AuditHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _authorizeAsset(String docId) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context); // Close the desk after signing
    } catch (e) {
      debugPrint("AUTH_ERROR: $e");
    }
  }

  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
    
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "ASSET_INSPECTION", 
                style: const TextStyle(fontSize: 18, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 40),
            _auditField("CAGE_ID", "1AHA8"),
            _auditField("VALUATION", "\$${data['value']}"),
            _auditField("LOCATION", "JOHNSTON_COUNTY_OK"),
            _auditField("ADA_CODE", "100%_PASS"),
            const Spacer(),
            if (!isSold) 
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                  onPressed: () => _authorizeAsset(docId),
                  child: const Text("AUTHORIZE & UNDERWRITE", style: TextStyle(color: Colors.white, fontSize: 10, letterSpacing: 1)),
                ),
              )
            else
              const Center(child: Text("ASSET_LOCKED_IN_LEDGER", style: TextStyle(color: Colors.redAccent, fontSize: 10))),
            const SizedBox(height: 15),
            Center(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("EXIT_WITHOUT_SIGNING", style: TextStyle(color: Colors.white24, fontSize: 8)))),
          ],
        ),
      ),
    );
  }

  Widget _auditField(String l, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 9, color: Colors.white38)),
      Text(v, style: const TextStyle(fontSize: 9, color: Colors.cyan)),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_AUDIT_INTERFACE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
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
                child: ListTile(
                  onTap: () => _openAuditDesk(docs[index].id, data),
                  leading: Icon(isSold ? Icons.verified : Icons.manage_search, 
                               color: isSold ? Colors.greenAccent : Colors.white24),
                  title: Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  subtitle: Text(isSold ? "STATUS: VERIFIED" : "STATUS: PENDING_INSPECTION", 
                            style: TextStyle(fontSize: 8, color: isSold ? Colors.greenAccent : Colors.white10)),
                  trailing: isSold ? const Icon(Icons.lock, color: Colors.greenAccent, size: 16) : const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white10),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
