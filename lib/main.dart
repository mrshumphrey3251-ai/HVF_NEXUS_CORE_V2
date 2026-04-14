import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V115.4 - FARMER REVENUE TICKER
// FOCUS: PROJECTED CARE DIVIDEND & USER VISIBILITY
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
        title: Text(":: $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.trending_up, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE V115", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
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
        const Text("IDENTITY VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "NAME / ENTITY ID")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("ACCESS")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerDashboard();
    if (role == "BUYER") return _buildBuyerInterface();
    return _buildCEOOversight();
  }

  // --- PRODUCER: NOW WITH EARNINGS TICKER ---
  Widget _buildProducerDashboard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('source', isEqualTo: userID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        double monthlyEarnings = 0;
        for (var doc in snapshot.data!.docs) {
          final d = doc.data() as Map<String, dynamic>;
          if (d['status'] == 'STEWARDSHIP') {
            monthlyEarnings += (d['stew_fee'] ?? 0);
          }
        }

        return Column(children: [
          Container(
            padding: const EdgeInsets.all(20), width: double.infinity, color: const Color(0xFF111111),
            child: Column(children: [
              const Text("PROJECTED CARE DIVIDEND", style: TextStyle(color: Colors.cyan, fontSize: 10, letterSpacing: 1)),
              Text("\$${monthlyEarnings.toStringAsFixed(2)}/MO", style: const TextStyle(color: Colors.cyan, fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("RECURRING STEWARDSHIP REVENUE", style: TextStyle(color: Colors.grey, fontSize: 8)),
            ]),
          ),
          const Expanded(child: Center(child: Text("UPLINK TOOLS ACTIVE", style: TextStyle(color: Colors.grey)))),
        ]);
      },
    );
  }

  Widget _buildBuyerInterface() { return const Center(child: Text("MARKETPLACE ACTIVE")); }
  
  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        int totalUsers = 1; // You (CEO)
        // Simple logic to count unique sources and buyers as users
        Set users = {userID};
        for(var doc in snapshot.data!.docs) {
          final d = doc.data() as Map<String, dynamic>;
          if(d['source'] != null) users.add(d['source']);
          if(d['buyer'] != null) users.add(d['buyer']);
        }

        return Column(children: [
          Container(
            padding: const EdgeInsets.all(20), width: double.infinity, color: const Color(0xFF1A1A1A),
            child: Column(children: [
              const Text("ACTIVE NEXUS USERS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
              Text("${users.length}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold)),
            ]),
          ),
          const Expanded(child: Center(child: Text("CEO MONITORING ACTIVE"))),
        ]);
      },
