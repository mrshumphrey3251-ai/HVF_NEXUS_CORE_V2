import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V111.0 - THE PERFECT PATH
// PRIMARY FOCUS: PRODUCER -> BUYER -> CEO OVERSIGHT
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

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
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const HVFShell(),
    );
  }
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: $role DASHBOARD ::", style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2)),
        actions: [IconButton(icon: const Icon(Icons.logout, color: Color(0xFFC5A059)), onPressed: () => setState(() => role = null))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.agriculture, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF TRANSACTION ENGINE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO1880", "CEO"),
        _gateBtn("PRODUCER (ENTRY)", "FARMER2026", "PRODUCER"),
        _gateBtn("BUYER (MARKET)", "BUYER2026", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String k, String r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 50)),
        onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
      ),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerMarket();
    return _buildCEOOversight();
  }

  // --- PRODUCER: INDUCTION OF ASSETS ---
  Widget _buildProducerEntry() {
    final b = TextEditingController(); final i = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("ADD ASSET TO PIPELINE", style: TextStyle(color: Colors.grey)),
      TextField(controller: b, decoration: const InputDecoration(labelText: "ANIMAL BREED")),
      TextField(controller: i, decoration: const InputDecoration(labelText: "ANIMAL ID / TAG")),
      const SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
        onPressed: () async {
          await FirebaseFirestore.instance.collection('pipeline').add({
            'breed': b.text, 'id': i.text, 'status': 'AVAILABLE', 'producer': 'PRODUCER_01', 'timestamp': FieldValue.serverTimestamp(),
          });
          b.clear(); i.clear();
        },
        child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  // --- BUYER: CLAIMING ASSETS ---
  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['breed'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("TAG: ${data['id']}"),
              trailing: ElevatedButton(
                onPressed: () => docs[index].reference.update({'status': 'CLAIMED', 'buyer': 'BUYER_01'}),
                child: const Text("BUY NOW"),
              ),
            );
          },
        );
      },
    );
  }

  // --- CEO: OVERSIGHT OF ALL ---
  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            Color sColor = data['status'] == 'AVAILABLE' ? Colors.green : Colors.orange;
            return ListTile(
              leading: Icon(Icons.analytics, color: sColor),
              title: Text("${data['breed']} (${data['id']})"),
              subtitle: Text("STATUS: ${data['status']}"),
              trailing: IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => docs[index].reference.delete()),
            );
          },
        );
      },
    );
  }
}
