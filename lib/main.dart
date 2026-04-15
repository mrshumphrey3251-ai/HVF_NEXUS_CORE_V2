import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

// =========================================================
// HVF NEXUS - POWERTRAIN INTEGRATION V1.3.0
// ENGINE INSTALLED | AUTONOMOUS LEDGER CALCULATIONS
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
  runApp(const HVFPowertrainBuild());
}

class HVFPowertrainBuild extends StatelessWidget {
  const HVFPowertrainBuild({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = snapshot.data!.docs;
          int totalAssets = docs.length;
          int verifiedAssets = docs.where((d) => (d.data() as Map)['status'] == 'SOLD').length;
          double totalRevenue = 0;
          
          for (var d in docs) {
            if ((d.data() as Map)['status'] == 'SOLD') {
              totalRevenue += ((d.data() as Map)['value'] ?? 0) * 0.05;
            }
          }

          return CustomScrollView(
            slivers: [
              // --- THE ENGINE BLOCK (DASHBOARD HEAD) ---
              SliverAppBar(
                expandedHeight: 200,
                backgroundColor: Colors.black,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.only(top: 80, left: 25, right: 25),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF1A1A1A), Colors.black], begin: Alignment.topCenter),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("HVF_ENTERPRISE_ENGINE_V1.3", style: TextStyle(color: Colors.white24, fontSize: 8)),
                        const SizedBox(height: 5),
                        Text("\$${totalRevenue.toStringAsFixed(2)}", 
                             style: const TextStyle(color: Colors.greenAccent, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _statChip("ASSETS: $totalAssets"),
                            const SizedBox(width: 10),
                            _statChip("VERIFIED: $verifiedAssets", color: Colors.cyan),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // --- THE DRIVETRAIN (THE LEDGER) ---
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'] == 'SOLD';
                    return _buildAssetRow(docs[index].id, data, isSold);
                  },
                  childCount: docs.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statChip(String text, {Color color = Colors.white10}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.1), border: Border.all(color: color)),
    child: Text(text, style: TextStyle(color: color == Colors.white10 ? Colors.white38 : color, fontSize: 8)),
  );

  Widget _buildAssetRow(String id, Map<String, dynamic> data, bool isSold) => InkWell(
    onTap: () => _openAuditDesk(id, data),
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            Text(isSold ? "LEDGER_LOCKED" : "READY_FOR_AUDIT", style: TextStyle(fontSize: 8, color: isSold ? Colors.greenAccent : Colors.white24)),
          ]),
          Text("\$${data['value']}", style: const TextStyle(color: Colors.cyan, fontSize: 10)),
        ],
      ),
    ),
  );

  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("AUTHORIZE_ASSET_UNDERWRITING", style: TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () async {
                  HapticFeedback.mediumImpact();
                  await _db.collection('enterprise_ledger').doc(docId).update({'status': 'SOLD'});
                  Navigator.pop(context);
                },
                child: const Text("CRANK ENGINE / EXECUTE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
