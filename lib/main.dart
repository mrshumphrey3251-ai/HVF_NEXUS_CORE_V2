import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html; // Authorized for link launching

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
        title: Text("HVF NEXUS :: $view", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
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
    switch (view) {
      case "PRODUCER": return _buildProducerEntry();
      case "BUYER": return _buildBuyerMarket();
      case "CEO": return _buildCEODashboard();
      default: return _buildGate();
    }
  }

  Widget _buildGate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.fact_check, color: Color(0xFFC5A059), size: 80),
      const SizedBox(height: 50),
      _gateBtn("CEO OVERSIGHT", "CEO"),
      _gateBtn("PRODUCER DECK", "PRODUCER"),
      _gateBtn("BUYER MARKET", "BUYER"),
    ]));
  }

  Widget _gateBtn(String l, String v) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 3), minimumSize: const Size(300, 70)),
      onPressed: () => setState(() => view = v),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _buildProducerEntry() {
    final nameCtrl = TextEditingController();
    final dataCtrl = TextEditingController();
    final mediaCtrl = TextEditingController();

    return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [_tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET")]),
      const SizedBox(height: 20),
      TextField(controller: nameCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME / LOT #", labelStyle: TextStyle(color: Color(0xFFC5A059)))),
      TextField(controller: dataCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITAL DATA (WEIGHT/HRS)", labelStyle: TextStyle(color: Color(0xFFC5A059)))),
      TextField(controller: mediaCtrl, style: const TextStyle(color: Colors.cyanAccent), decoration: const InputDecoration(labelText: "EVIDENCE LINK (URL)", labelStyle: TextStyle(color: Colors.cyanAccent))),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 70)),
        onPressed: () async {
          await _db.collection('enterprise_ledger').add({
            'name': nameCtrl.text, 'vital': dataCtrl.text, 'media': mediaCtrl.text, 'sector': sector, 'timestamp': FieldValue.serverTimestamp(), 'status': 'AVAILABLE'
          });
          nameCtrl.clear(); dataCtrl.clear(); mediaCtrl.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SUCCESSFUL")));
        },
        child: const Text("UPLINK WITH EVIDENCE", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      )
    ])));
  }

  Widget _tab(String s) => ChoiceChip(label: Text(s), selected: sector == s, onSelected: (val) => setState(() => sector = s), selectedColor: const Color(0xFFC5A059));

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, i) {
            final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF1A1A1A),
              margin: const EdgeInsets.all(12),
              child: ListTile(
                title: Text(doc['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("${doc['sector']} | ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
                  if (doc['media'] != null && doc['media'] != "")
                    TextButton.icon(
                      icon: const Icon(Icons.play_circle_fill, color: Colors.cyanAccent),
                      label: const Text("VIEW PROOF", style: TextStyle(color: Colors.cyanAccent)),
                      onPressed: () => html.window.open(doc['media'], 'new_tab'),
                    ),
                ]),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => snap.data!.docs[i].reference.update({'status': 'CLAIMED'}),
                  child: const Text("SECURE"),
                ),
              ),
            );
          },
        );
      },
    );
  }

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
              title: Text(doc['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontSize: 18)),
              subtitle: Text("STATUS: ${doc['status']}", style: TextStyle(color: doc['status'] == 'CLAIMED' ? Colors.green : Colors.orange)),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
            );
          },
        );
      },
    );
  }
}
