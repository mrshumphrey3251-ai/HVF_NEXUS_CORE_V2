import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - COMMAND CHASSIS V158.6
// STATUS: OPERATIONAL | REVENUE TRACKING ACTIVE
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
  runApp(const HVFNexusFinal());
}

class HVFNexusFinal extends StatelessWidget {
  const HVFNexusFinal({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SovereignHub(),
    );
  }
}

class SovereignHub extends StatefulWidget {
  const SovereignHub({super.key});
  @override
  State<SovereignHub> createState() => _SovereignHubState();
}

class _SovereignCommandCenterState extends State<SovereignHub> {} // Place holder for logic

class _SovereignHubState extends State<SovereignHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _executeTrade(String docId, String name, dynamic val) async {
    try {
      await _db.collection('enterprise_ledger').doc(docId).update({'status': 'SOLD'});
      _notify("TRANSACTION_AUTHORIZED: $name");
    } catch (e) {
      _notify("HARDWARE_ERROR: CHECK_CONNECTION");
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
        title: const Text("HVF_NEXUS_CORE", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = snapshot.data!.docs;
          double totalFees = 0;

          // CALCULATE REAL-TIME REVENUE
          for (var doc in docs) {
            var d = doc.data() as Map<String, dynamic>;
            if (d['status'].toString().toUpperCase().trim() == "SOLD") {
              totalFees += (d['value'] ?? 0) * 0.05;
            }
          }

          return Column(
            children: [
              _revenueHeader(totalFees),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    bool isSold = data['status'].toString().toUpperCase().trim() == "SOLD";
                    
                    return Card(
                      color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                      child: ListTile(
                        leading: isSold 
                          ? const Icon(Icons.verified, color: Colors.greenAccent, size: 24)
                          : const Icon(Icons.radio_button_unchecked, color: Colors.white10),
                        title: Text(data['name'] ?? "UNNAMED", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                        subtitle: Text("VALUE: \$${data['value']}", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
                        trailing: isSold 
                          ? const Text("SOLD", style: TextStyle(color: Colors.redAccent, fontSize: 8, fontWeight: FontWeight.bold))
                          : ElevatedButton(
                              onPressed: () => _executeTrade(docs[index].id, data['name'] ?? "", data['value']),
                              child: const Text("EXECUTE", style: TextStyle(fontSize: 7)),
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

  Widget _revenueHeader(double fees) => Container(
    padding: const EdgeInsets.all(20),
    color: const Color(0xFF0D0D0D),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("SME_UNDERWRITING_REVENUE", style: TextStyle(fontSize: 8, color: Colors.white24)),
        Text("\$${fees.toStringAsFixed(2)}", style: const TextStyle(fontSize: 12, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - BULLETPROOF INTERLOCK V158.5
// SME COMMAND: ZERO-FAILURE STATUS RECOGNITION
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
  runApp(const HVFNexusSovereign());
}

class HVFNexusSovereign extends StatelessWidget {
  const HVFNexusSovereign({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SovereignCommandCenter(),
    );
  }
}

class SovereignCommandCenter extends StatefulWidget {
  const SovereignCommandCenter({super.key});
  @override
  State<SovereignCommandCenter> createState() => _SovereignCommandCenterState();
}

class _SovereignCommandCenterState extends State<SovereignCommandCenter> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _executeTrade(String docId, String name, dynamic val) async {
    try {
      int value = (val is int) ? val : int.tryParse(val.toString()) ?? 0;
      
      // FORCING THE UPDATE TO THE DATABASE
      await _db.collection('enterprise_ledger').doc(docId).set({
        'status': 'SOLD',
      }, SetOptions(merge: true));

      _notify("EXECUTION_SUCCESS: $name | DATABASE_UPDATED");
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
      appBar: AppBar(
        title: const Text("HVF_NEXUS_COMMAND_V158.5", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        backgroundColor: Colors.black,
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
              String docId = docs[index].id;
              
              // AGGRESSIVE DATA NORMALIZATION
              String rawStatus = (data['status'] ?? "AVAILABLE").toString().trim().toUpperCase();
              bool isSold = rawStatus == "SOLD";
              
              return Card(
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                child: ListTile(
                  title: Text(data['name'] ?? "UNNAMED", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                  subtitle: Text("VALUE: \$${data['value']} | STATUS: $rawStatus", 
                    style: TextStyle(fontSize: 8, color: isSold ? Colors.redAccent : Colors.cyan)),
                  trailing: isSold 
                    ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 24)
                    : ElevatedButton(
                        onPressed: () => _executeTrade(docId, data['name'] ?? "UNNAMED", data['value']),
                        child: const Text("EXECUTE", style: TextStyle(fontSize: 7)),
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
