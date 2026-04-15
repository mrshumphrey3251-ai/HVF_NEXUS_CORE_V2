import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - REVENUE ENGINE V158.11
// SME UNDERWRITING CALCULATOR | 5% FEE TRACKING
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
  runApp(const HVFNexusRevenue());
}

class HVFNexusRevenue extends StatelessWidget {
  const HVFNexusRevenue({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const RevenueHub(),
    );
  }
}

class RevenueHub extends StatefulWidget {
  const RevenueHub({super.key});
  @override
  State<RevenueHub> createState() => _RevenueHubState();
}

class _RevenueHubState extends State<RevenueHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _verifyAsset(String docId, String name, dynamic val) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
      _notify("REVENUE_LOCKED: $name");
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_REVENUE_COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.cyan, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = snapshot.data!.docs;
          double totalSmeFees = 0;

          // CALCULATE 5% UNDERWRITING FEE ON ALL SOLD ASSETS
          for (var doc in docs) {
            var d = doc.data() as Map<String, dynamic>;
            if (d['status'].toString().toUpperCase() == "SOLD") {
              int val = d['value'] ?? 0;
              totalSmeFees += (val * 0.05);
            }
          }

          return Column(
            children: [
              _revenuePanel(totalSmeFees),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
                    int val = data['value'] ?? 0;
                    
                    return Card(
                      color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                      child: ListTile(
                        leading: Icon(isSold ? Icons.payments : Icons.inventory_2, 
                                     color: isSold ? Colors.greenAccent : Colors.white10),
                        title: Text(data['name'] ?? "UNNAMED_ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        subtitle: Text("VALUE: \$$val | FEE: \$${(val * 0.05).toStringAsFixed(2)}", 
                                  style: const TextStyle(fontSize: 8, color: Colors.cyan)),
                        trailing: isSold 
                          ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF222222)),
                              onPressed: () => _verifyAsset(docs[index].id, data['name'] ?? "ASSET", val),
                              child: const Text("AUDIT", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _revenuePanel(double fees) => Container(
    padding: const EdgeInsets.all(25),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Color(0xFF0D0D0D),
      border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("SME_UNDERWRITING_TOTAL (5%)", style: TextStyle(fontSize: 8, color: Colors.white38)),
        const SizedBox(height: 5),
        Text("\$${fees.toStringAsFixed(2)}", 
             style: const TextStyle(fontSize: 22, color: Colors.greenAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ],
    ),
  );
}
