import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.3 - THE INSTITUTIONAL BUILD
// FOCUS: BULK UPLINK SIMULATION & MASS STEWARDSHIP PROJECTION
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
  bool bulkMode = false;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS: INSTITUTIONAL CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: [
          IconButton(icon: Icon(Icons.logout, color: Colors.red, size: 16), onPressed: () => setState(() => role = null))
        ],
      ),
      body: _buildRouter(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.business_center, color: Color(0xFFC5A059), size: 80),
        SizedBox(height: 20),
        Text("HVF NEXUS CORE V116", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4)),
        SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("INSTITUTIONAL PARTNER", "PRODUCER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: Color(0xFFC5A059)), minimumSize: Size(280, 60)),
      onPressed: () => setState(() => role = r), child: Text(l)),
  );

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("PARTNER AUTHENTICATION"),
        TextField(controller: c, decoration: InputDecoration(labelText: "CORPORATE ENTITY ID")),
        SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: Text("INITIALIZE SYSTEM")),
      ])),
    );
  }

  Widget _buildRouter() {
    if (role == "PRODUCER") return _buildProducerHub();
    return _buildCEOOversight();
  }

  Widget _buildProducerHub() {
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(bulkMode ? "BULK CSV MODE" : "SINGLE ASSET MODE"),
        Switch(value: bulkMode, onChanged: (v) => setState(() => bulkMode = v), activeColor: Color(0xFFC5A059)),
      ]),
      SizedBox(height: 40),
      if (bulkMode) 
        Column(children: [
          Icon(Icons.upload_file, size: 100, color: Colors.cyan),
          SizedBox(height: 20),
          Text("UPLINK PARTNER LEDGER (.CSV / .XLSX)", textAlign: TextAlign.center),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, minimumSize: Size(double.infinity, 60)),
            onPressed: () => _simulateBulkUpload(),
            child: Text("IMPORT INSTITUTIONAL VOLUME", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ])
      else
        Text("SINGLE ENTRY TOOLS ACTIVE", style: TextStyle(color: Colors.grey)),
    ]));
  }

  void _simulateBulkUpload() async {
    // Simulation logic for the tour
    for (int i = 0; i < 5; i++) {
      await FirebaseFirestore.instance.collection('enterprise_ledger').add({
        'name': 'INSTITUTIONAL_LOT_${i+1}', 'value': 1200.0, 'species': 'CATTLE', 'status': 'AVAILABLE', 'source': userID, 'category': 'LIVESTOCK'
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("BATCH TOKENIZATION COMPLETE: 5 ASSETS LIVE")));
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        double projectedDividend = snapshot.data!.docs.length * 50.0;
        return Column(children: [
          Container(
            padding: EdgeInsets.all(20), width: double.infinity, color: Color(0xFF111111),
            child: Column(children: [
              Text("NATIONAL MANAGED VOLUME", style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text("${snapshot.data!.docs.length} HEAD", style: TextStyle(fontSize: 28, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("PROJECTED PARTNER DIVIDEND: \$${projectedDividend.toStringAsFixed(2)}/MO", style: TextStyle(fontSize: 10, color: Colors.cyan)),
            ]),
          ),
          Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: Icon(Icons.lan, color: Colors.cyan, size: 18),
                title: Text(d['name'] ?? "ASSET"),
                subtitle: Text("ENTITY: ${d['source']}"),
              );
            },
          )),
        ]);
      },
    );
  }
}
