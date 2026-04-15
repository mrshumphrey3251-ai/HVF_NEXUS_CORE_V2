import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS - TRANSMISSION & ARCHIVE V1.3.5
// PERMANENT LEDGER LOGIC | THE SAFETY INTERLOCK
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
  runApp(const HVFNexusFinalMechanical());
}

class HVFNexusFinalMechanical extends StatelessWidget {
  const HVFNexusFinalMechanical({super.key});
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
  int _selectedIndex = 0; // 0: Live Assets, 1: Archive Ledger
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _selectedIndex == 0 ? _buildLiveList() : _buildArchiveLedger(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.white24,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings_input_component), label: 'LIVE_COMMAND'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'ARCHIVE_LEDGER'),
        ],
      ),
    );
  }

  // --- THE LIVE COMMAND ENGINE ---
  Widget _buildLiveList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        double revenue = 0;
        for (var d in docs) {
          if ((d.data() as Map)['status'] == 'SOLD') revenue += ((d.data() as Map)['value'] ?? 0) * 0.05;
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("\$${revenue.toStringAsFixed(2)}", style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                background: const Center(child: Text("SME_TOTAL_YIELD", style: TextStyle(color: Colors.white10, fontSize: 8))),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var data = docs[index].data() as Map<String, dynamic>;
                  if (data['status'] == 'SOLD') return const SizedBox.shrink(); // Move sold to Archive
                  return _buildAssetTile(docs[index].id, data);
                },
                childCount: docs.length,
              ),
            ),
          ],
        );
      },
    );
  }

  // --- THE ARCHIVE LEDGER (THE TRANSMISSION) ---
  Widget _buildArchiveLedger() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'SOLD').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return Column(
          children: [
            const SizedBox(height: 60),
            const Text("PERMANENT_TRANSACTION_ARCHIVE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white10),
            Expanded(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var data = docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    leading: const Icon(Icons.lock_outline, color: Colors.greenAccent, size: 16),
                    title: Text(data['name'] ?? "VERIFIED_ASSET", style: const TextStyle(fontSize: 10)),
                    subtitle: const Text("AUDIT_COMPLETE: CAGE_1AHA8", style: TextStyle(fontSize: 8, color: Colors.white24)),
                    trailing: Text("\$${data['value']}", style: const TextStyle(color: Colors.cyan, fontSize: 9)),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAssetTile(String id, Map<String, dynamic> data) {
    return ListTile(
      onTap: () => _openAuditDesk(id, data),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      leading: const Icon(Icons.radio_button_unchecked, color: Colors.cyan, size: 18),
      title: Text(data['name'] ?? "UNIT", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white10),
    );
  }

  void _openAuditDesk(String docId, Map<String, dynamic> data) {
    // --- THE SEATBELT ALARM (Safety Interlock) ---
    if (data['value'] == null || data['value'] <= 0) {
      _showAlarm("SAFETY_HALT: ZERO_VALUE_ASSET");
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      builder: (context) => Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            const Text("SME_AUTHORIZATION_DESK", style: TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                onPressed: () async {
                  await _db.collection('enterprise_ledger').doc(docId).update({'status': 'SOLD'});
                  Navigator.pop(context);
                },
                child: const Text("COMMIT TO ARCHIVE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlarm(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent, content: Text(msg, style: const TextStyle(fontWeight: FontWeight.bold))));
  }
}
