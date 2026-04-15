import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - HARDENED PRODUCTION V158.7
// ALIGNED TO SDK 3.0.0 | FIREBASE 3.1.1 | FIRESTORE 5.0.2
// CAGE: 1AHA8 | AUTHORIZED: JEFFERY DONNELL HUMPHREY
// =========================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Standard Web Initialization
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
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SovereignDashboard(),
    );
  }
}

class SovereignDashboard extends StatefulWidget {
  const SovereignDashboard({super.key});
  @override
  State<SovereignDashboard> createState() => _SovereignDashboardState();
}

class _SovereignDashboardState extends State<SovereignDashboard> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _executeUnderwriting(String id, String name, int val) async {
    try {
      await _db.collection('enterprise_ledger').doc(id).update({
        'status': 'SOLD',
      });
      _notify("AUTHORIZED: $name | FEE_LOCKED");
    } catch (e) {
      _notify("SYSTEM_ERROR: CHECK_DATABASE_RULES");
    }
  }

  void _notify(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF1A1A1A),
      content: Text(m, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 12)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.cyan, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("DATABASE_CONNECTION_ERROR"));
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
              _revenueDisplay(totalSmeRevenue),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'].toString().toUpperCase() == "SOLD";
                    int val = data['value'] ?? 0;

                    return Card(
                      color: isSold ? const Color(0xFF1A0000) : const Color(0xFF0D0D0D),
                      child: ListTile(
                        leading: Icon(isSold ? Icons.verified : Icons.radio_button_off, 
                                     color: isSold ? Colors.greenAccent : Colors.white10),
                        title: Text(data['name'] ?? "UNNAMED_ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        subtitle: Text("VALUE: \$$val", style: const TextStyle(color: Colors.cyan, fontSize: 9)),
                        trailing: isSold 
                          ? const Text("SOLD", style: TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF222222)),
                              onPressed: () => _executeUnderwriting(docs[index].id, data['name'] ?? "ASSET", val),
                              child: const Text("EXECUTE", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
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

  Widget _revenueDisplay(double rev) => Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("SME_FEE_ACCUMULATION", style: TextStyle(fontSize: 8, color: Colors.white38)),
        Text("\$${rev.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
