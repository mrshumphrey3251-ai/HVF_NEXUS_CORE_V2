import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V112.1 - INPUT STABILIZATION
// FOCUS: UNLOCKED WEIGHT ENTRY & LIVE CALC
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
  final double regionalAvgLive = 1.85; 
  final double hvfPremiumRate = 1.15; 

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() => role = null)),
        title: const Text("HVF COMMODITY EXCHANGE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 12)),
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
        const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
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
    final b = TextEditingController(); 
    final w = TextEditingController();
    double liveWt = 0;

    return StatefulBuilder(
      builder: (context, setInternalState) {
        return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
          const Text("ASSET INDUCTION", style: TextStyle(color: Colors.grey, letterSpacing: 2)),
          const SizedBox(height: 20),
          TextField(controller: b, decoration: const InputDecoration(labelText: "BREED", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
          const SizedBox(height: 15),
          TextField(
            controller: w, 
            keyboardType: const TextInputType.numberWithOptions(decimal: true), 
            decoration: const InputDecoration(labelText: "LIVE WEIGHT (LBS)", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan))),
            onChanged: (v) => setInternalState(() { liveWt = double.tryParse(v) ?? 0; }),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              _calcRow("REGIONAL MARKET AVG:", "\$$regionalAvgLive/LB"),
              _calcRow("HVF PREMIUM:", "+15%"),
              const Divider(color: Colors.white10),
              _calcRow("EST. HANGING WEIGHT:", "${(liveWt * 0.62).toStringAsFixed(1)} LBS"),
              _calcRow("EST. MARKET VALUE:", "\$${(liveWt * regionalAvgLive * hvfPremiumRate).toStringAsFixed(2)}"),
            ]),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
            onPressed: () async {
              if(b.text.isNotEmpty && liveWt > 0) {
                await FirebaseFirestore.instance.collection('pipeline').add({
                  'breed': b.text,
                  'live_weight': liveWt,
                  'hanging_weight': liveWt * 0.62,
                  'price': liveWt * regionalAvgLive * hvfPremiumRate,
                  'status': 'AVAILABLE',
                  'timestamp': FieldValue.serverTimestamp(),
                });
                b.clear(); w.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET UPLINKED")));
              }
            },
            child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ])));
      }
    );
  }

  Widget _calcRow(String l, String v) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      Text(v, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.cyan)),
    ]));
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, index) {
          final data = docs[index].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: ListTile(
            title: Text("${data['breed']} - ${data['live_weight']} LBS", style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            subtitle: Text("HANGING: ${data['hanging_weight'].toStringAsFixed(1)} LBS"),
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
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, index) {
          final data = docs[index].data() as Map<String, dynamic>;
          bool claimed = data['status'] == 'CLAIMED';
          return ListTile(
            leading: Icon(claimed ? Icons.check_circle : Icons.pending, color: claimed ? Colors.green : Colors.orange),
            title: Text("${data['breed']} | \$${data['price'].toStringAsFixed(2)}"),
            subtitle: Text("STATUS: ${data['status']} | LIVE WT: ${data['live_weight']}"),
            trailing: IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: () => docs[index].reference.delete()),
          );
        });
      },
    );
  }
}
