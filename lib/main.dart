import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V112.5 - TRANSACTION HARDENING
// FOCUS: RESPONSIVE BUYER CLICKS & STATUS LOCKING
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
  String agentID = "AGENT_JDH_01"; 

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() => role = null)),
        title: Text("HVF $role PORTAL", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, letterSpacing: 2)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() => role = null))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.hub, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER INDUCTION", "PRODUCER"),
        _gateBtn("BUYER MARKETPLACE", "BUYER"),
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
    return StatefulBuilder(builder: (context, setInternalState) {
      return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
        Text("LOGGED IN AS: $agentID", style: const TextStyle(color: Colors.cyan, fontSize: 10)),
        const SizedBox(height: 20),
        TextField(controller: b, decoration: const InputDecoration(labelText: "BREED")),
        TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "LIVE WT (LBS)"),
          onChanged: (v) => setInternalState(() => liveWt = double.tryParse(v) ?? 0)),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () async {
            if(b.text.isNotEmpty && liveWt > 0) {
              await FirebaseFirestore.instance.collection('pipeline').add({
                'breed': b.text, 
                'live_weight': liveWt, 
                'hanging_weight': liveWt * 0.62,
                'price': liveWt * 1.85 * 1.15, 
                'status': 'AVAILABLE', 
                'agent': agentID, 
                'timestamp': FieldValue.serverTimestamp(),
              });
              b.clear(); w.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET UPLINKED")));
            }
          },
          child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])));
    });
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text("MARKETPLACE EMPTY", style: TextStyle(color: Colors.grey)));
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF1A1A1A),
              margin: const EdgeInsets.only(bottom: 15),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(data['breed'].toUpperCase(), style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("LIVE: ${data['live_weight']} LBS | HANGING: ${data['hanging_weight'].toStringAsFixed(1)} LBS"),
                  const Divider(color: Colors.white10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text("\$${data['price'].toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
                      onPressed: () async {
                        // Immediate Atomic Update
                        await docs[index].reference.update({'status': 'CLAIMED', 'buyer_id': 'BUYER_ALPHA'});
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET SECURED")));
                      },
                      child: const Text("SECURE ASSET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    )
                  ])
                ]),
              ),
            );
          },
        );
      },
    );
  }

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
            bool claimed = data['status'] == 'CLAIMED';
            return ListTile(
              leading: Icon(claimed ? Icons.check_circle : Icons.pending, color: claimed ? Colors.green : Colors.orange),
              title: Text("${data['breed']} | \$${data['price'].toStringAsFixed(2)}"),
              subtitle: Text("AGENT: ${data['agent'] ?? 'NONE'} | STATUS: ${data['status']}"),
              trailing: IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: () => docs[index].reference.delete()),
            );
          },
        );
      },
    );
  }
}
