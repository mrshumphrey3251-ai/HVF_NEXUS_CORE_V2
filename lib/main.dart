import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - FULL INTERIOR ASSEMBLY V1.1.0
// THE COMPLETED MARKETABLE VEHICLE
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
  runApp(const HVFFullBuild());
}

class HVFFullBuild extends StatelessWidget {
  const HVFFullBuild({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Courier',
        primaryColor: const Color(0xFFC5A059),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC5A059), brightness: Brightness.dark),
      ),
      home: const IgnitionScreen(),
    );
  }
}

// --- THE "IGNITION" (LOGIN/START SCREEN) ---
class IgnitionScreen extends StatelessWidget {
  const IgnitionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [Color(0xFF1A1A1A), Colors.black], radius: 1.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield, size: 80, color: Color(0xFFC5A059)),
              const SizedBox(height: 20),
              const Text("HVF_NEXUS_v1.1", style: TextStyle(letterSpacing: 8, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("SOVEREIGN ASSET COMMAND", style: TextStyle(color: Colors.white24, fontSize: 10)),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5A059),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainDashboard())),
                child: const Text("INITIALIZE SYSTEMS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
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

  // --- THE SEATBELT ALARM (VALIDATION CHECK) ---
  Future<void> _processVerification(String docId, Map<String, dynamic> data) async {
    // If valuation is missing, trigger the "Alarm"
    if (data['value'] == null || data['value'] == 0) {
      _triggerAlarm("SAFETY_FAIL: ASSET_VALUATION_REQUIRED");
      return;
    }

    await _db.collection('enterprise_ledger').doc(docId).update({
      'status': 'SOLD',
      'audit_by': 'CEO_HUMPHREY',
      'audit_timestamp': FieldValue.serverTimestamp(),
    });
    Navigator.pop(context);
  }

  void _triggerAlarm(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    ));
  }

  void _openDetailSheet(String docId, Map<String, dynamic> data) {
    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111111),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "UNIT_INSPECTION", 
                style: const TextStyle(fontSize: 20, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10, height: 40),
            _infoRow("CAGE", "1AHA8"),
            _infoRow("UEI", "S1M4ENLHTDH5"),
            _infoRow("ADA_ACCESS", "VERIFIED"),
            _infoRow("VALUATION", "\$${data['value']}"),
            const SizedBox(height: 40),
            if (!isSold)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                  onPressed: () => _processVerification(docId, data),
                  child: const Text("EXECUTE VERIFICATION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              )
            else
              const Center(child: Text("ENTRY_LOCKED_IN_LEDGER", style: TextStyle(color: Colors.greenAccent, fontSize: 10))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String l, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(color: Colors.white30, fontSize: 10)),
      Text(v, style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 11)),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_SYSTEMS_MONITOR", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          double rev = 0;
          for (var d in docs) {
            if ((d.data() as Map)['status'] == 'SOLD') rev += ((d.data() as Map)['value'] ?? 0) * 0.05;
          }

          return Column(
            children: [
              _buildUpperDash(rev),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'] == 'SOLD';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: isSold ? const Color(0xFF1A0A0A) : const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSold ? Colors.greenAccent.withOpacity(0.3) : Colors.white10),
                      ),
                      child: ListTile(
                        onTap: () => _openDetailSheet(docs[index].id, data),
                        leading: Icon(isSold ? Icons.lock : Icons.radar, color: isSold ? Colors.greenAccent : Colors.cyan, size: 20),
                        title: Text(data['name'] ?? "UNIT", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        subtitle: Text(isSold ? "STATUS: VERIFIED" : "STATUS: SCANNING", 
                                  style: TextStyle(fontSize: 9, color: isSold ? Colors.greenAccent : Colors.white24)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.white10),
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

  Widget _buildUpperDash(double rev) => Container(
    padding: const EdgeInsets.all(30),
    decoration: const BoxDecoration(
      color: Color(0xFF0D0D0D),
      border: Border(bottom: BorderSide(color: Color(0xFFC5A059), width: 0.5)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("TOTAL_REVENUE_FEE", style: TextStyle(fontSize: 8, color: Colors.white30)),
          Text("\$${rev.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        ]),
        const Icon(Icons.analytics_outlined, color: Colors.white10, size: 40),
      ],
    ),
  );
}
