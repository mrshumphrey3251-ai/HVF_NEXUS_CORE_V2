import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - UNIFIED COMMAND V158.14
// RESTORED EXECUTE + SLIDE-UP DEBRIEF
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
  runApp(const HVFNexusUnified());
}

class HVFNexusUnified extends StatelessWidget {
  const HVFNexusUnified({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const UnifiedHub(),
    );
  }
}

class UnifiedHub extends StatefulWidget {
  const UnifiedHub({super.key});
  @override
  State<UnifiedHub> createState() => _UnifiedHubState();
}

class _UnifiedHubState extends State<UnifiedHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _verifyAsset(String docId, String name) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("CMD_ERROR: $e");
    }
  }

  void _showAssetDetails(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "ASSET_DEBRIEF", style: const TextStyle(fontSize: 16, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 30),
            _detailRow("CAGE_CODE", "1AHA8"),
            _detailRow("VALUE", "\$${data['value']}"),
            _detailRow("SME_FEE", "\$${(data['value'] * 0.05).toStringAsFixed(2)}"),
            _detailRow("ADA_STATUS", "100%_COMPLIANT"),
            _detailRow("GEO_LOCK", "JOHNSTON_COUNTY_OK"),
            const Spacer(),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text("CLOSE", style: TextStyle(color: Colors.white24))))
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 9, color: Colors.white38)), Text(v, style: const TextStyle(fontSize: 9, color: Colors.cyan))]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("HVF_UNIFIED_NEXUS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10))),
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
                  onTap: () => _showAssetDetails(data),
                  leading: Icon(isSold ? Icons.fact_check : Icons.inventory, color: isSold ? Colors.greenAccent : Colors.white10),
                  title: Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  subtitle: Text("VALUE: \$${data['value']}", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
                  trailing: isSold 
                    ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 24)
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
