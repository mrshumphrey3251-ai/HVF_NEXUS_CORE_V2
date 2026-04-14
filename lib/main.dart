import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

// HVF NEXUS CORE V114.2 - VITAL DATA ENRICHMENT
// FOCUS: MULTI-SECTOR FIELD DEPTH & PORTFOLIO VALUATION
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
  String? userID;
  String activeCategory = "LIVESTOCK";

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() { role = null; userID = null; })),
        title: Text(":: $role DASHBOARD ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() { role = null; userID = null; }))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.fact_check, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER/AGENT", "PRODUCER"),
        _gateBtn("BUYER/CLIENT", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildIdentityOnboarding() {
    final idController = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(40), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("ID VERIFICATION REQUIRED", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "NAME / ENTITY")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerMarket();
    return _buildCEOOversight();
  }

  Widget _buildProducerEntry() {
    final n = TextEditingController(); 
    final d1 = TextEditingController(); 
    final d2 = TextEditingController();
    final v = TextEditingController();
    
    return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [_catTab("LIVESTOCK"), const SizedBox(width: 8), _catTab("CROPS"), const SizedBox(width: 8), _catTab("FLEET")]),
      const SizedBox(height: 30),
      TextField(controller: n, decoration: InputDecoration(labelText: activeCategory == "CROPS" ? "CROP VARIETY" : "ASSET NAME")),
      TextField(controller: d1, decoration: InputDecoration(labelText: activeCategory == "LIVESTOCK" ? "WEIGHT (LBS)" : (activeCategory == "CROPS" ? "ACREAGE" : "SERVICE HOURS"))),
      TextField(controller: d2, decoration: InputDecoration(labelText: activeCategory == "LIVESTOCK" ? "VACCINATION STATUS" : (activeCategory == "CROPS" ? "MOISTURE %" : "FUEL LEVEL %"))),
      TextField(controller: v, decoration: const InputDecoration(labelText: "VIDEO EVIDENCE URL", icon: Icon(Icons.videocam, color: Colors.red))),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          double val = activeCategory == "LIVESTOCK" ? (double.tryParse(d1.text) ?? 0) * 1.85 * 1.15 : 0;
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': n.text, 'vital1': d1.text, 'vital2': d2.text, 'category': activeCategory, 'video': v.text,
            'value': val, 'status': 'AVAILABLE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
          });
          n.clear(); d1.clear(); d2.clear(); v.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("VITAL DATA UPLINKED")));
        },
        child: const Text("UPLINK TO SYSTEM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ])));
  }

  Widget _catTab(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(label: Text(c), selected: active, onSelected: (s) => setState(() => activeCategory = c), selectedColor: Color(0xFFC5A059));
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: Column(children: [
            ListTile(
              title: Text(data['name'], style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              subtitle: Text("${data['vital1']} | ${data['vital2']}"),
            ),
            if (data['video'] != null && data['video'].toString().isNotEmpty)
              TextButton.icon(icon: const Icon(Icons.play_circle_fill, color: Colors.red), label: const Text("WATCH VIDEO PROOF"), onPressed: () => html.window.open(data['video'], '_blank')),
            Padding(padding: const EdgeInsets.all(12), child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => snapshot.data!.docs[i].reference.update({'status': 'CLAIMED'}), child: const Text("SECURE ASSET")))
          ]));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return ListTile(
            leading: Icon(Icons.analytics, color: data['video'] != "" ? Colors.green : Colors.grey),
            title: Text(data['name']),
            subtitle: Text("${data['category']} | Vitals: ${data['vital1']} / ${data['vital2']}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snapshot.data!.docs[i].reference.delete()),
          );
        });
      },
    );
  }
}
