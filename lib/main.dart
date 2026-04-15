import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS CORE - FULL OPERATIONAL DEPLOYMENT V1.4.7
// SECTOR: LIVESTOCK | CROPS | FLEET
// SME AUTHORIZED: JEFFERY DONNELL HUMPHREY
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
      appId: "1:892263251736:web:899cc6ab03f6f5e9d8286d",
    ),
  );
  runApp(const MaterialApp(home: HVFMasterControl(), debugShowCheckedModeBanner: false));
}

class HVFMasterControl extends StatefulWidget {
  const HVFMasterControl({super.key});
  @override
  State<HVFMasterControl> createState() => _HVFMasterControlState();
}

class _HVFMasterControlState extends State<HVFMasterControl> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS :: $view", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 13, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      bottomNavigationBar: view == "GATE" ? null : BottomAppBar(
        color: const Color(0xFF111111),
        child: TextButton.icon(
          onPressed: () => setState(() => view = "GATE"),
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text("EXIT TO SOVEREIGN GATE", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    if (view == "GATE") return _buildGate();
    if (view == "PRODUCER") return _buildProducerEntry();
    return _buildCEODashboard();
  }

  Widget _buildGate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.fact_check, color: Color(0xFFC5A059), size: 60),
      const SizedBox(height: 30),
      _gateBtn("CEO OVERSIGHT", "CEO"),
      _gateBtn("PRODUCER DECK", "PRODUCER"),
    ]));
  }

  Widget _gateBtn(String l, String v) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => view = v),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ),
  );

  Widget _buildProducerEntry() {
    final nameCtrl = TextEditingController();
    final dataCtrl = TextEditingController();

    return Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [_tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET")]),
      const SizedBox(height: 30),
      TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "ASSET NAME / LOT #", labelStyle: const TextStyle(color: Colors.white24))),
      TextField(controller: dataCtrl, decoration: InputDecoration(labelText: sector == "LIVESTOCK" ? "WEIGHT (LBS)" : (sector == "CROPS" ? "ACREAGE" : "SERVICE HOURS"), labelStyle: const TextStyle(color: Colors.white24))),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          await _db.collection('enterprise_ledger').add({
            'name': nameCtrl.text, 'vital': dataCtrl.text, 'sector': sector, 'timestamp': FieldValue.serverTimestamp(), 'status': 'ACTIVE'
          });
          nameCtrl.clear(); dataCtrl.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SUCCESSFUL")));
        },
        child: const Text("UPLINK TO LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  Widget _tab(String s) => ChoiceChip(label: Text(s), selected: sector == s, onSelected: (val) => setState(() => sector = s), selectedColor: const Color(0xFFC5A059));

  Widget _buildCEODashboard() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, i) {
            final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
            return ListTile(
              leading: const Icon(Icons.analytics, color: Color(0xFFC5A059)),
              title: Text(doc['name'] ?? "UNKNOWN", style: const TextStyle(color: Colors.white)),
              subtitle: Text("${doc['sector']} | VITAL: ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
            );
          },
        );
      },
    );
  }
}
