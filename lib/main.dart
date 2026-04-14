import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V116.1 - GLOBAL MIDDLEMAN (SAAS)
// FOCUS: PARTNER-MANAGED FULFILLMENT & GLOBAL LEDGER
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
        title: Text(":: HVF GLOBAL MIDDLEWARE ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
        actions: [IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: () => setState(() => role = null))],
      ),
      body: _buildCore(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.language, color: Color(0xFFC5A059), size: 80),
        const SizedBox(height: 20),
        const Text("HVF NEXUS: GLOBAL RAILS", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3)),
        const SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("PARTNER PROVIDER", "PRODUCER"),
        _gateBtn("GLOBAL BUYER", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => role = r), child: Text(l)),
  );

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("GLOBAL ENTITY VERIFICATION"),
        TextField(controller: c, decoration: const InputDecoration(labelText: "LEGAL ENTITY NAME")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ACTIVATE RAILS")),
      ])),
    );
  }

  Widget _buildCore() {
    if (role == "CEO") return _buildCEODeck();
    return const Center(child: Text("GLOBAL EXCHANGE ACTIVE\nWAITING FOR PARTNER UPLINK", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)));
  }

  Widget _buildCEODeck() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Column(children: [
          Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF111111), border: Border(bottom: BorderSide(color: Color(0xFFC5A059)))),
            child: Column(children: [
              const Text("GLOBAL PARTNER NODES", style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text("${snapshot.data!.docs.length}", style: const TextStyle(fontSize: 28, color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            ]),
          ),
          Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.cloud_circle, color: Colors.cyan),
                title: Text(d['name'] ?? "GLOBAL ASSET"),
                subtitle: Text("PROVIDER: ${d['source']} | STATUS: ${d['status']}"),
              );
            },
          )),
        ]);
      },
    );
  }
}
