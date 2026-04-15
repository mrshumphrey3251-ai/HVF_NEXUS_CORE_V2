import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - REINFORCED TACTICAL V158.13
// HIGH-SENSITIVITY INTERFACE | FORCED SLIDE-UP
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: 20),
                Text(data['name']?.toUpperCase() ?? "ASSET_DEBRIEF", 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC5A059))),
                const Divider(color: Colors.white10, height: 30),
                _detailRow("CAGE_CODE", "1AHA8"),
                _detailRow("ASSET_VALUE", "\$${data['value']}"),
                _detailRow("SME_UNDERWRITING", "ACTIVE (5%)"),
                _detailRow("VETERAN_READY", "YES"),
                _detailRow("ADA_ACCESSIBLE", "100%"),
                _detailRow("LOCATION", "JOHNSTON_COUNTY_OK"),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("CLOSE_DEBRIEF", style: TextStyle(color: Colors.black, fontSize: 10)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white38)),
        Text(value, style: const TextStyle(fontSize: 9, color: Colors.cyan, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_COMMAND_NEXUS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
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
              bool isSold = data['status'].toString().toUpperCase() == "SOLD";
              return Card(
                color: isSold ? const Color(0xFF1A0000) : const Color(0xFF111111),
                child: InkWell(
                  onTap: () => _showAssetDetails(data),
                  child: ListTile(
                    leading: Icon(isSold ? Icons.fact_check : Icons.inventory, color: isSold ? Colors.greenAccent : Colors.white10),
                    title: Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    subtitle: Text("VALUE: \$${data['value']}", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
                    trailing: const Icon(Icons.info_outline, size: 14, color: Colors.white24),
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
