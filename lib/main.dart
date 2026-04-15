import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.5 - THE FLUID CORE
// FOCUS: REMOVING STATIC DEAD ENDS & DECENTRALIZING GLOBAL GROWTH
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
        title: Text(":: HVF GLOBAL NEXUS ::", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
        actions: [IconButton(icon: Icon(Icons.refresh, color: Colors.cyan, size: 18), onPressed: () => setState(() {}))],
      ),
      body: _buildRouter(),
      bottomNavigationBar: _buildActionRail(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.all_inclusive, color: Color(0xFFC5A059), size: 80),
        SizedBox(height: 20),
        Text("HVF NEXUS: THE FLUID CORE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("PARTNER PROVIDER", "PRODUCER"),
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
        Text("VERIFY GLOBAL ENTITY"),
        TextField(controller: c, decoration: InputDecoration(labelText: "ID / NAME")),
        SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: Text("INITIALIZE PATH")),
      ])),
    );
  }

  Widget _buildRouter() {
    if (role == "PRODUCER") return _buildProducerFlow();
    if (role == "BUYER") return _buildBuyerFlow();
    return _buildCEOFlow();
  }

  // ACTION RAIL: ENSURES NO DEAD ENDS
  Widget _buildActionRail() {
    return Container(
      height: 60,
      color: Color(0xFF111111),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _railBtn(Icons.add_box, "UPLINK"),
        _railBtn(Icons.swap_horiz, "EXCHANGE"),
        _railBtn(Icons.account_balance_wallet, "DIVIDENDS"),
      ]),
    );
  }
