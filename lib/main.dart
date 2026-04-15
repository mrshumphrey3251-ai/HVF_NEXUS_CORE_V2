import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - UNIFIED COMMAND CORE V1.0
// THE HUMPHREY STANDARD | PRODUCTION GRADE
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5
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
  runApp(const HVFNexusApp());
}

class HVFNexusApp extends StatelessWidget {
  const HVFNexusApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Courier',
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFC5A059),
      ),
      home: const MainCommandCenter(),
    );
  }
}

class MainCommandCenter extends StatefulWidget {
  const MainCommandCenter({super.key});
  @override
  State<MainCommandCenter> createState() => _MainCommandCenterState();
}

class _MainCommandCenterState extends State<MainCommandCenter> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------------------------------------------------------
  // CORE BUSINESS LOGIC: THE AUDIT AUTHORIZATION
  // ---------------------------------------------------------
  Future<void> _authorizeAsset(String docId) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
        'audit_by': 'CEO_HUMPHREY',
        'audit_timestamp': FieldValue.serverTimestamp(),
      });
      if (mounted) Navigator.pop(context); // Close the desk after signing
    } catch (e) {
      _notify("AUTH_ERROR: SYSTEM_HALTED");
    }
  }

  void _notify(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(m, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
    ));
  }

  // ---------------------------------------------------------
  // UI COMPONENT: THE TACTICAL DEBRIEF (SLIDE-UP)
  // ---------------------------------------------------------
  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    bool isVerified = data['status'].toString().toUpperCase() == "SOLD";
    
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data['name']?.toUpperCase() ?? "ASSET_INSPECTION", 
                    style: const TextStyle(fontSize: 18, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
                if (isVerified) const Icon(Icons.verified, color: Colors.greenAccent),
              ],
            ),
            const Divider(color: Colors.white10, height: 40),
            _dataField("ENTITY_ID", "S1M4ENLHTDH5"),
            _dataField("CAGE_CODE", "1AHA8"),
            _dataField("LOCATION", "JOHNSTON_COUNTY_OK"),
            _dataField("ADA_STATUS", "100%_COMPLIANT"),
            _dataField("VALUATION", "\$${data['value']}"),
            _dataField("SME_UNDERWRITING", "5%_COMMISSION"),
            const Spacer(),
            if (!isVerified)
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                  onPressed: () => _authorizeAsset(docId),
                  child: const Text("EXECUTE VERIFICATION", 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              )
            else
              const Center(child: Text("AUDIT_TRAIL_SECURED", style: TextStyle(color: Colors.redAccent, fontSize: 10, letterSpacing: 1))),
            const SizedBox(height: 20),
            Center(child: TextButton(onPressed: () => Navigator.pop(context), 
                child: const Text("CLOSE_DEBRIEF", style: TextStyle(color: Colors.white24, fontSize: 8)))),
          ],
        ),
      ),
    );
  }

  Widget _dataField(String l, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 9, color: Colors.white30)),
      Text(v, style: const TextStyle(fontSize: 9, color: Colors.cyan, fontWeight: FontWeight.bold)),
    ]),
  );

  // ---------------------------------------------------------
  // MAIN DISPLAY: THE SOVEREIGN LEDGER
  // ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("HVF_NEXUS_COMMAND", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.white24, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
          
          final docs = snapshot.data!.docs;
          double totalSmeRevenue = 0;
          for (var doc in docs) {
            var d = doc.data() as Map<String, dynamic>;
            if (d['status'].toString().toUpperCase() == "SOLD") {
              totalSmeRevenue += (d['value'] ?? 0) * 0.05;
            }
          }

          return Column(
            children: [
              // --- THE REVENUE PANEL ---
              _buildRevenuePanel(totalSmeRevenue),
              // --- THE MASTER ASSET LIST ---
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: isSold ? const Color(0xFF150000) : const Color(0xFF111111),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: isSold ? Colors.greenAccent.withOpacity(0.4) : Colors.white10),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        onTap: () => _openAuditDesk(docs[index].id, data),
                        leading: Icon(isSold ? Icons.lock : Icons.manage_search, 
                                     color: isSold ? Colors.greenAccent : Colors.white24),
                        title: Text(data['name'] ?? "ASSET_PENDING", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        subtitle: Text(isSold ? "STATUS: VERIFIED" : "STATUS: PENDING_AUDIT", 
                                      style: TextStyle(fontSize: 8, color: isSold ? Colors.greenAccent : Colors.white10)),
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

  Widget _buildRevenuePanel(double rev) => Container(
    padding: const EdgeInsets.all(30),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Color(0xFF0D0D0D),
      border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("SME_UNDERWRITING_TOTAL (5%)", style: TextStyle(fontSize: 8, color: Colors.white30)),
        const SizedBox(height: 5),
        Text("\$${rev.toStringAsFixed(2)}", 
             style: const TextStyle(fontSize: 26, color: Colors.greenAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ],
    ),
  );
}
