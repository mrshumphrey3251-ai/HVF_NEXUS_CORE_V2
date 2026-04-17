// V14.1.0: THE TRANSPARENCY PATCH
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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
  runApp(const MaterialApp(home: HVFTransparencyCore(), debugShowCheckedModeBanner: false));
}

class HVFTransparencyCore extends StatefulWidget {
  const HVFTransparencyCore({super.key});
  @override
  State<HVFTransparencyCore> createState() => _HVFTransparencyCoreState();
}

class _HVFTransparencyCoreState extends State<HVFTransparencyCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield_outlined, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "CEO": return _ceoDeck();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 8)),
      const SizedBox(height: 60),
      _cmdBtn("EXECUTIVE COMMAND (CEO)", () => _ceoAuth()),
    ]));
  }

  // --- REBUILT CEO DECK WITH NULL-SAFE LEDGER ---
  Widget _ceoDeck() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSET SORTER"), Tab(text: "VETTED LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetSorter(),
        _ceoLedgerSafe(),
      ])),
    ]));
  }

  Widget _ceoAssetSorter() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'UNKNOWN ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("Valuation: \$${d['price'] ?? '0'}", style: const TextStyle(color: Colors.white24)),
          trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLedgerSafe() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        if (snap.data!.docs.isEmpty) return const Center(child: Text("NO VETTED PARTICIPANTS", style: TextStyle(color: Colors.white24)));
        
        return ListView(children: snap.data!.docs.map((d) {
          // DEFENSIVE MAPPING: If data is missing, the app won't crash
          String name = d.data().toString().contains('name') ? d['name'] : "UNNAMED";
          String role = d.data().toString().contains('role') ? d['role'] : "GUEST";
          String uid = d.data().toString().contains('uid') ? d['uid'] : "NO-UID";

          return ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFC5A059)),
            title: Text(name, style: const TextStyle(color: Colors.white)),
            subtitle: Text("ROLE: $role | UID: $uid", style: const TextStyle(color: Colors.white38, fontSize: 10)),
            trailing: const Icon(Icons.verified_user, color: Colors.green, size: 14),
          );
        }).toList());
      },
    );
  }

  void _ceoAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A), title: const Text("EXECUTIVE ACCESS", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _cmdBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(400, 70)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))));
}
