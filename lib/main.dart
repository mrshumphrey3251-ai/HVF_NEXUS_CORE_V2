import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V112.0 - MARKET INTELLIGENCE & YIELD
// FOCUS: LIVE VS HANGING WEIGHTS & REGIONAL PRICING
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
  // Regional Market Standards (Example: Oklahoma Region)
  final double regionalAvgLive = 1.85; // $/lb
  final double hvfPremiumRate = 1.15; // 15% Premium

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() => role = null)),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(":: $role DASHBOARD ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12)),
          Text("REGIONAL AVG: \$$regionalAvgLive/LB | HVF PREM: +15%", style: const TextStyle(color: Colors.cyan, fontSize: 9)),
        ]),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() => role = null))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.analytics, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF COMMODITY EXCHANGE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER (ENTRY)", "PRODUCER"),
        _gateBtn("BUYER (MARKET)", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerMarket();
    return _buildCEOOversight();
  }

  Widget _buildProducerEntry() {
    final b = TextEditingController(); final w = TextEditingController();
    double liveWt = 0;
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUCT CATTLE TO PIPELINE", style: TextStyle(color: Colors.grey)),
      TextField(controller: b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "LIVE WEIGHT (LBS)"), 
        onChanged: (v) => setState(() { liveWt = double.tryParse(v) ?? 0; })),
      const SizedBox(height: 20),
      if (liveWt > 0) ...[
        _calcRow("EST. HANGING WT:", "${(liveWt * 0.62).toStringAsFixed(1)} LBS"),
        _calcRow("HVF TARGET PRICE:", "\$${(liveWt * regionalAvgLive * hvfPremiumRate).toStringAsFixed(2)}"),
      ],
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          await FirebaseFirestore.instance.collection('pipeline').add({
            'breed': b.text,
            'live_weight': liveWt,
            'hanging_weight': liveWt * 0.62,
            'price': liveWt * regionalAvgLive * hvfPremiumRate,
            'status': 'AVAILABLE',
            'timestamp': FieldValue.serverTimestamp(),
          });
          b.clear(); w.clear();
        },
        child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  Widget _calcRow(String l, String v) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 12, color: Colors.cyan)),
      Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
    ]));
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, index) {
          final data = docs[index].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(8), child: ListTile(
            title: Text("${data['breed']} - ${data['live_weight']} LBS", style: const TextStyle(color: Color(0xFFC5A059))),
            subtitle: Text("EST. HANGING: ${data['hanging_weight'].toStringAsFixed(1)} LBS"),
            trailing: Text("\$${data['price'].toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            onLongPress: () => docs[index].reference.update({'status': 'CLAIMED'}),
          ));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, index) {
          final data = docs[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text("${data['breed']} | \$${data['price'].toStringAsFixed(2)}"),
            subtitle: Text("STATUS: ${data['status']} | WT: ${data['live_weight']}"),
            trailing: IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: () => docs[index].reference.delete()),
          );
        });
      },
    );
  }
}
