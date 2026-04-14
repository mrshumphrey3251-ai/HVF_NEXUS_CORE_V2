import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V112.3 - ACCOUNTABILITY PATCH
// FOCUS: RESTORING AGENT/PRODUCER DATA TRAILS
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
  // Temporary session ID to simulate which Agent is logged in
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

  // --- PRODUCER: INDUCTION WITH AGENT STAMP ---
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
                'agent': agentID, // CRITICAL: RE-ESTABLISHING THE LINK
                'timestamp': FieldValue.serverTimestamp(),
              });
              b.clear(); w.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET LINKED TO AGENT")));
            }
          },
          child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])));
    });
  }

  // --- BUYER MARKETPLACE ---
  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF1A1A1A),
              child: ListTile(
                title: Text(data['breed'].toUpperCase(), style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
                subtitle: Text("LIVE WT: ${data['live_weight']} | AGENT: ${data['agent'] ?? 'UNKNOWN'}"),
                trailing: Text("\$${data['price'].toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
                onLongPress: () => docs[index].reference.update({'status': 'CLAIMED', 'buyer_id': 'B-001'}),
              ),
            );
          },
        );
      },
    );
  }

  // --- CEO OVERSIGHT: FULL VISIBILITY ---
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
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(4)),
              child: ListTile(
                leading: const Icon(Icons.person_search, color: Colors.cyan),
                title: Text("${data['breed']} [\$${data['price'].toStringAsFixed(2)}]"),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("AGENT: ${data['agent'] ?? 'NOT STAMPED'}", style: const TextStyle(color: Colors.cyan, fontSize: 11)),
                  Text("STATUS: ${data['status']}", style: const TextStyle(fontSize: 10)),
                ]),
                trailing: IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: () => docs[index].reference.delete()),
              ),
            );
          },
        );
      },
    );
  }
}
