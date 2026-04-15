import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - HARDENED INTERLOCK V158.4
// CASE-INSENSITIVE STATUS CHECK | FORCE REFRESH
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
      double smeFee = value * 0.05;

      // 1. UPDATE STATUS (FORCING UPPERCASE FOR UNIFORMITY)
      await _db.collection('enterprise_ledger').doc(docId).update({
        'status': 'SOLD',
      });

      // 2. AUDIT LOG
      await _db.collection('audit_trail').add({
        'cage_code': '1AHA8',
        'asset_name': name,
        'gross_value': value,
        'fee': smeFee,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _notify("EXECUTION_SUCCESS: $name | FEE: \$$smeFee");
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
        title: const Text("HVF_NEXUS_COMMAND_CORE", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = snapshot.data!.docs;

          return Column(
            children: [
              _summary(docs.length),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    String docId = docs[index].id;
                    
                    // HARDENED STATUS CHECK (Handling any case format)
                    String status = (data['status'] ?? "AVAILABLE").toString().toUpperCase();
                    bool isSold = status == "SOLD";
                    
                    return _assetTile(docId, data['name'] ?? "UNNAMED", data['value'] ?? 0, isSold);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summary(int count) => Container(
    padding: const EdgeInsets.all(20),
    color: const Color(0xFF0D0D0D),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("CAGE_1AHA8_ASSETS", style: TextStyle(fontSize: 8, color: Colors.white24)),
        Text("$count ACTIVE", style: const TextStyle(fontSize: 10, color: Colors.greenAccent)),
      ],
    ),
  );

  Widget _assetTile(String id, String name, dynamic val, bool isSold) {
    return Card(
      color: const Color(0xFF111111),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        subtitle: Text("VALUE: \$$val", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
        trailing: isSold 
          ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 24)
          : ElevatedButton(
              onPressed: () => _executeTrade(id, name, val),
              child: const Text("EXECUTE", style: TextStyle(fontSize: 7)),
            ),
      ),
    );
  }
}
