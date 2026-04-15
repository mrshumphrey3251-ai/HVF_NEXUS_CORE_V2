import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - GAUGE INTEGRATION V1.3.6
// REAL-TIME KPI MONITORING | MECHANICAL COMPLETION
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
  runApp(const HVFFullGauges());
}

class HVFFullGauges extends StatelessWidget {
  const HVFFullGauges({super.key});
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
  int _selectedIndex = 0;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _selectedIndex == 0 ? _buildLiveCommand() : _buildArchive(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.white10,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'COMMAND'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_shared), label: 'ARCHIVE'),
        ],
      ),
    );
  }

  Widget _buildLiveCommand() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        
        // --- CALCULATE GAUGES ---
        int totalUnits = docs.length;
        int verifiedUnits = docs.where((d) => (d.data() as Map)['status'] == 'SOLD').length;
        double revenue = 0;
        for (var d in docs) {
          if ((d.data() as Map)['status'] == 'SOLD') revenue += ((d.data() as Map)['value'] ?? 0) * 0.05;
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("SME_REVENUE_YIELD", style: TextStyle(color: Colors.white24, fontSize: 8)),
                      Text("\$${revenue.toStringAsFixed(2)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _gauge("ACREAGE", "200.0", Colors.cyan),
                          _gauge("ADA_UNITS", "$verifiedUnits / 200", Colors.orangeAccent),
                          _gauge("VET_CAP", "85%", Colors.magentaAccent),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var data = docs[index].data() as Map<String, dynamic>;
                  if (data['status'] == 'SOLD') return const SizedBox.shrink();
                  return _assetTile(docs[index].id, data);
                },
                childCount: docs.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _gauge(String label, String val, Color color) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white24, fontSize: 7)),
      Text(val, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
      Container(width: 40, height: 2, color: color.withOpacity(0.3)),
    ],
  );

  Widget _assetTile(String id, Map<String, dynamic> data) => ListTile(
    onTap: () => _openAudit(id, data),
    contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    title: Text(data['name'] ?? "ASSET", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    subtitle: Text("VALUE: \$${data['value']}", style: const TextStyle(color: Colors.white10, fontSize: 9)),
    trailing: const Icon(Icons.arrow_right_alt, color: Color(0xFFC5A059)),
  );

  Widget _buildArchive() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'SOLD').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var data = docs[index].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF111111),
              child: ListTile(
                leading: const Icon(Icons.verified, color: Colors.greenAccent, size: 16),
                title: Text(data['name'] ?? "VERIFIED", style: const TextStyle(fontSize: 10)),
                trailing: Text("\$${(data['value'] * 0.05).toStringAsFixed(2)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 10)),
              ),
            );
          },
        );
      },
    );
  }

  void _openAudit(String docId, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("HVF_SME_AUTHORIZATION", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () async {
                  await _db.collection('enterprise_ledger').doc(docId).update({'status': 'SOLD'});
                  Navigator.pop(context);
                },
                child: const Text("FINALIZE AUDIT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
