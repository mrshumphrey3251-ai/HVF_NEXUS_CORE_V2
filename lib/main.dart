import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.4 - THE WEALTH PATH
// FOCUS: PROJECTED APPRECIATION & DISCIPLINED GROWTH TRACKING
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

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: HVF WEALTH ENGINE ::", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
        actions: [IconButton(icon: Icon(Icons.trending_up, color: Colors.cyan, size: 18), onPressed: () {})],
      ),
      body: _buildRouter(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.account_balance, color: Color(0xFFC5A059), size: 80),
        SizedBox(height: 20),
        Text("HVF NEXUS: THE WEALTH PATH", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("PARTNER PRODUCER", "PRODUCER"),
        _gateBtn("DISCIPLINED BUYER", "BUYER"),
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
        Text("INITIALIZE PORTFOLIO"),
        TextField(controller: c, decoration: InputDecoration(labelText: "ENTITY / USER ID")),
        SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: Text("OPEN EXCHANGE")),
      ])),
    );
  }

  Widget _buildRouter() {
    if (role == "BUYER") return _buildWealthTracker();
    return Center(child: Text("$role INTERFACE ACTIVE"));
  }

  Widget _buildWealthTracker() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('buyer', isEqualTo: userID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Column(children: [
          Container(
            padding: EdgeInsets.all(25), width: double.infinity, color: Color(0xFF111111),
            child: Column(children: [
              Text("PROJECTED ASSET VALUE AT MATURITY", style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text("\$${(snapshot.data!.docs.length * 2800.0).toStringAsFixed(2)}", style: TextStyle(fontSize: 28, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
              Text("BASED ON DISCIPLINED STEWARDSHIP", style: TextStyle(fontSize: 8, color: Colors.grey)),
            ]),
          ),
          Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
              return Card(
                color: Color(0xFF1A1A1A),
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(Icons.circle, color: Colors.greenAccent, size: 12),
                  title: Text(d['name'] ?? "ASSET"),
                  subtitle: Text("CURRENT FMV: \$${d['value']}\nEST. MATURITY: \$2,800.00"),
                  trailing: Icon(Icons.auto_graph, color: Colors.cyan),
                ),
              );
            },
          )),
        ]);
      },
    );
  }
}
