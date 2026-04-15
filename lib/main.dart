import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

// =========================================================
// HVF NEXUS - ROLLING CHASSIS V1.2.0
// FULL DEPLOYMENT READY | MOBILE OPTIMIZED
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
  runApp(const HVFRollingBuild());
}

class HVFRollingBuild extends StatelessWidget {
  const HVFRollingBuild({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Courier',
        primaryColor: const Color(0xFFC5A059),
      ),
      home: const IgnitionScreen(),
    );
  }
}

// --- THE IGNITION (NOW WITH SYSTEM HAPTICS) ---
class IgnitionScreen extends StatelessWidget {
  const IgnitionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D0D0D), Colors.black]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield_outlined, size: 100, color: Color(0xFFC5A059)),
            const SizedBox(height: 30),
            const Text("HVF_NEXUS_v1.2", style: TextStyle(letterSpacing: 10, fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("S1M4ENLHTDH5 | 1AHA8", style: TextStyle(color: Colors.white10, fontSize: 9)),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC5A059),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // Industrial look
              ),
              onPressed: () {
                HapticFeedback.heavyImpact(); // The "Crank" of the engine
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainDashboard()));
              },
              child: const Text("ENGAGE SYSTEMS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- THE WHEELS: MOBILE RESPONSIVE LIST ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("ASSET_COMMAND_CENTER", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Icon(Icons.wifi, color: Colors.greenAccent, size: 14), Text(" LIVE  ", style: TextStyle(fontSize: 8))],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return StreamBuilder<QuerySnapshot>(
            stream: _db.collection('enterprise_ledger').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
              final docs = snapshot.data!.docs;
              
              double totalFees = 0;
              for (var d in docs) {
                if ((d.data() as Map)['status'] == 'SOLD') {
                  totalFees += ((d.data() as Map)['value'] ?? 0) * 0.05;
                }
              }

              return Column(
                children: [
                  _buildStatusHeader(totalFees),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var data = docs[index].data() as Map<String, dynamic>;
                        bool isSold = data['status'] == 'SOLD';
                        return _buildAssetCard(docs[index].id, data, isSold);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }

  Widget _buildStatusHeader(double fees) => Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: const Color(0xFF0A0A0A),
      border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("TOTAL_SME_YIELD", style: TextStyle(color: Colors.white30, fontSize: 8)),
          Text("\$${fees.toStringAsFixed(2)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 26, fontWeight: FontWeight.bold)),
        ]),
        const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFFC5A059), size: 30),
      ],
    ),
  );

  Widget _buildAssetCard(String id, Map<String, dynamic> data, bool isSold) => GestureDetector(
    onTap: () => _openAuditDesk(id, data),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSold ? const Color(0xFF1A0505) : const Color(0xFF111111),
        border: Border.all(color: isSold ? Colors.greenAccent.withOpacity(0.2) : Colors.white10),
      ),
      child: Row(
        children: [
          Icon(isSold ? Icons.verified_user : Icons.radio_button_checked, color: isSold ? Colors.greenAccent : Colors.cyan, size: 18),
          const SizedBox(width: 20),
          Expanded(child: Text(data['name'] ?? "UNKNOWN_ASSET", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          Text("\$${data['value']}", style: const TextStyle(color: Colors.white24, fontSize: 10)),
        ],
      ),
    ),
  );

  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    bool isSold = data['status'] == 'SOLD';
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "INSPECTION", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 40),
            _row("CAGE_CODE", "1AHA8"),
            _row("ADA_READY", "YES"),
            _row("SME_COMMISSION", "5%"),
            const Spacer(),
            if (!isSold)
              SizedBox(width: double.infinity, height: 60, child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () async {
                  HapticFeedback.vibrate();
                  await _db.collection('enterprise_ledger').doc(docId).update({'status': 'SOLD'});
                  Navigator.pop(context);
                },
                child: const Text("AUTHORIZE ASSET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ))
            else
              const Center(child: Text("TRANSACTION_FINALIZED", style: TextStyle(color: Colors.greenAccent, fontSize: 10))),
          ],
        ),
      ),
    );
  }

  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(color: Colors.white24, fontSize: 10)), Text(v, style: const TextStyle(color: Colors.cyan, fontSize: 10))]));
}
