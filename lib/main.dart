import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - PRODUCTION RELEASE V1.0.0 (V158.17)
// SOVEREIGN COMMAND | SME UNDERWRITING | CAGE: 1AHA8
// AUTHORIZED: JEFFERY DONNELL HUMPHREY, CEO
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
  runApp(const HVFProductionApp());
}

class HVFProductionApp extends StatelessWidget {
  const HVFProductionApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Courier',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ProductionCommandCenter(),
    );
  }
}

class ProductionCommandCenter extends StatefulWidget {
  const ProductionCommandCenter({super.key});
  @override
  State<ProductionCommandCenter> createState() => _ProductionCommandCenterState();
}

class _ProductionCommandCenterState extends State<ProductionCommandCenter> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _executeUnderwrite(String docId) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    } catch (e) {
      debugPrint("SYSTEM_ERROR: $e");
    }
  }

  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    bool isVerified = data['status'].toString().toUpperCase() == "SOLD";
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "PROJECT_ACTIVATION", style: const TextStyle(fontSize: 18, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 40),
            _dataField("ENTITY_ID", "S1M4ENLHTDH5"),
            _dataField("CAGE_CODE", "1AHA8"),
            _dataField("LOT_VALUATION", "\$${data['value']}"),
            _dataField("SME_UNDERWRITING", "5.00%"),
            _dataField("ADA_STATUS", "CERTIFIED"),
            const Spacer(),
            if (!isVerified)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                  onPressed: () => _executeUnderwrite(docId),
                  child: const Text("EXECUTE VERIFICATION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              )
            else
              const Center(child: Text("LEDGER_LOCKED", style: TextStyle(color: Colors.redAccent, fontSize: 10))),
            const SizedBox(height: 15),
            Center(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("CLOSE_DEBRIEF", style: TextStyle(color: Colors.white24, fontSize: 8)))),
          ],
        ),
      ),
    );
  }

  Widget _dataField(String l, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 9, color: Colors.white30)),
      Text(v, style: const TextStyle(fontSize: 9, color: Colors.cyan)),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("v1.0.0  ", style: TextStyle(color: Colors.white10, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
          final docs = snapshot.data!.docs;
          double totalRevenue = 0;
          for (var doc in docs) {
            var d = doc.data() as Map<String, dynamic>;
            if (d['status'].toString().toUpperCase() == "SOLD") {
              totalRevenue += (d['value'] ?? 0) * 0.05;
            }
          }
          return Column(
            children: [
              _revenuePanel(totalRevenue),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
                    return Card(
                      color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                      child: ListTile(
                        onTap: () => _openAuditDesk(docs[index].id, data),
                        leading: Icon(isSold ? Icons.lock : Icons.manage_search, color: isSold ? Colors.greenAccent : Colors.white24),
                        title: Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        subtitle: Text(isSold ? "STATUS: VERIFIED" : "STATUS: PENDING", style: TextStyle(fontSize: 8, color: isSold ? Colors.greenAccent : Colors.white12)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white10),
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

  Widget _revenuePanel(double rev) => Container(
    padding: const EdgeInsets.all(25),
    width: double.infinity,
    decoration: const BoxDecoration(color: Color(0xFF0D0D0D), border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("SME_UNDERWRITING_REVENUE", style: TextStyle(fontSize: 8, color: Colors.white30)),
        Text("\$${rev.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
