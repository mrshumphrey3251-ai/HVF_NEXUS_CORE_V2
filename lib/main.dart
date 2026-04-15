import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - TACTICAL DRILL DOWN V158.12
// SME ASSET INTELLIGENCE | DETAILED AUDIT VIEW
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
  runApp(const HVFNexusTactical());
}

class HVFNexusTactical extends StatelessWidget {
  const HVFNexusTactical({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const TacticalHub(),
    );
  }
}

class TacticalHub extends StatefulWidget {
  const TacticalHub({super.key});
  @override
  State<TacticalHub> createState() => _TacticalHubState();
}

class _TacticalHubState extends State<TacticalHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void _showAssetDetails(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFC5A059), width: 2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['name']?.toUpperCase() ?? "ASSET_DETAIL", 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC5A059))),
            const Divider(color: Colors.white10),
            const SizedBox(height: 20),
            _detailRow("CAGE_CODE", "1AHA8"),
            _detailRow("ASSET_VALUE", "\$${data['value']}"),
            _detailRow("SME_FEE (5%)", "\$${(data['value'] * 0.05).toStringAsFixed(2)}"),
            _detailRow("STATUS", data['status'] ?? "PENDING"),
            _detailRow("LOCATION", "JOHNSTON_COUNTY_OK"),
            _detailRow("ADA_COMPLIANT", "YES"),
            _detailRow("VETERAN_READY", "YES"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CLOSE_DEBRIEF", style: TextStyle(color: Colors.white24)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.white38)),
        Text(value, style: const TextStyle(fontSize: 10, color: Colors.cyan, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_TACTICAL_NEXUS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(color: Colors.cyan, fontSize: 8)))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = snapshot.data!.docs;
          double totalFees = 0;
          for (var doc in docs) {
            var d = doc.data() as Map<String, dynamic>;
            if (d['status'].toString().toUpperCase() == "SOLD") {
              totalFees += (d['value'] ?? 0) * 0.05;
            }
          }

          return Column(
            children: [
              _revenuePanel(totalFees),
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
                        onTap: () => _showAssetDetails(data),
                        leading: Icon(isSold ? Icons.fact_check : Icons.inventory, color: isSold ? Colors.greenAccent : Colors.white10),
                        title: Text(data['name'] ?? "UNNAMED", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        subtitle: Text("VALUE: \$${data['value']}", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white24),
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
    color: const Color(0xFF0D0D0D),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("SME_FEE_ACCUMULATION", style: TextStyle(fontSize: 8, color: Colors.white38)),
        Text("\$${fees.toStringAsFixed(2)}", style: const TextStyle(fontSize: 22, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
