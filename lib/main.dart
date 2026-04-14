import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V115.9.2 - HIGH VELOCITY RECOVERY
// FOCUS: BYPASSING COMPILER TIMEOUT & FIXING BLANK SCREEN
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
    // GATEKEEPERS: REDUCE UI LOAD
    if (role == null) return _buildGate();
    if (userID == null) return _buildID();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12)),
        leading: IconButton(icon: const Icon(Icons.logout, color: Colors.red), onPressed: () => setState(() => role = null)),
      ),
      body: _buildRouter(),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.engineering, color: Color(0xFFC5A059), size: 80),
        const SizedBox(height: 40),
        _gateBtn("PARTNER FARMER", "PARTNER"),
        _gateBtn("FLEET BUYER", "BUYER"),
        _gateBtn("CEO OVERSIGHT", "CEO"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildID() {
    final c = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("PARTNER AUTHENTICATION", style: TextStyle(color: Color(0xFFC5A059))),
        TextField(controller: c, decoration: const InputDecoration(labelText: "ENTITY NAME")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("ENTER")),
      ])),
    );
  }

  Widget _buildRouter() {
    if (role == "PARTNER") return _buildListing();
    if (role == "BUYER") return _buildMarket();
    return const Center(child: Text("CEO MONITORING..."));
  }

  Widget _buildListing() {
    final m = TextEditingController(); final h = TextEditingController(); final p = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      TextField(controller: m, decoration: const InputDecoration(labelText: "MACHINERY MODEL")),
      TextField(controller: h, decoration: const InputDecoration(labelText: "SERVICE HOURS")),
      TextField(controller: p, decoration: const InputDecoration(labelText: "PRICE")),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': m.text, 'hours': h.text, 'value': p.text, 'category': 'FLEET', 'status': 'FOR SALE', 'source': userID
          });
          m.clear(); h.clear(); p.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("FLEET ASSET UPLINKED")));
        },
        child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black)),
      )
    ]));
  }

  Widget _buildMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('category', isEqualTo: 'FLEET').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return ListTile(
            leading: const Icon(Icons.settings, color: Colors.orange),
            title: Text(data['name'] ?? "EQUIPMENT"),
            subtitle: Text("HOURS: ${data['hours']} | PRICE: \$${data['value']}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 12),
          );
        }).toList());
      },
    );
  }
}
