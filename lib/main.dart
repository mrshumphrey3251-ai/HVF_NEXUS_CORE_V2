import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V109.0 - MULTI-ASSET INTEGRATION
// STATUS: HELIOGRID ONLINE
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

const Color hvfGold = Color(0xFFC5A059); 
const Color hvfBlack = Color(0xFF0D0D0D);

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: hvfBlack, fontFamily: 'Courier'),
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
  String activeCategory = "LIVESTOCK";

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: CEO COMMAND ::" : ":: FIELD UPLINK ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 12)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: hvfGold), onPressed: () => setState(() => role = null))],
      ),
      body: role == "CEO" ? _buildOverwatch() : _buildInduction(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.security, color: hvfGold, size: 60),
        const SizedBox(height: 20),
        const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4)),
        const SizedBox(height: 50),
        _gateBtn("CEO EXECUTIVE ACCESS", "CEO1880", "CEO"),
        const SizedBox(height: 15),
        _gateBtn("AGENT FIELD ACCESS", "FARMER2026", "AGENT"),
      ])),
    );
  }

  Widget _gateBtn(String l, String k, String r) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: hvfGold), minimumSize: const Size(250, 55)),
      onPressed: () => _verify(k, r), child: Text(l, style: const TextStyle(color: hvfGold)),
    );
  }

  void _verify(String k, String r) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text("VERIFY_ID", style: TextStyle(color: hvfGold)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
      actions: [TextButton(onPressed: () { if(val == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _buildOverwatch() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ledger').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: hvfGold));
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            bool isEnergy = data['category'] == "ENERGY";
            return ListTile(
              leading: Icon(isEnergy ? Icons.bolt : Icons.pets, color: hvfGold),
              title: Text(data['name'] ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("${data['detail'] ?? '---'}", style: TextStyle(color: isEnergy ? Colors.cyan : hvfGold)),
              trailing: Text(data['category'] ?? "MISC", style: const TextStyle(fontSize: 10, color: Colors.grey)),
            );
          },
        );
      },
    );
  }

  Widget _buildInduction() {
    final n = TextEditingController(); final d = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _catBtn("LIVESTOCK"), _catBtn("ENERGY"),
      ]),
      const SizedBox(height: 30),
      TextField(controller: n, decoration: InputDecoration(labelText: activeCategory == "ENERGY" ? "ARRAY_NAME" : "BREED_NAME")),
      TextField(controller: d, decoration: InputDecoration(labelText: activeCategory == "ENERGY" ? "VOLTAGE_OR_STATUS" : "ASSET_ID")),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 50)),
        onPressed: () async {
          if (n.text.isNotEmpty) {
            await FirebaseFirestore.instance.collection('ledger').add({
              'name': n.text,
              'detail': d.text,
              'category': activeCategory,
              'timestamp': FieldValue.serverTimestamp(),
            });
            n.clear(); d.clear();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SUCCESSFUL")));
          }
        },
        child: const Text("UPLINK TO CLOUD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  Widget _catBtn(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(
      label: Text(c), selected: active, 
      onSelected: (s) => setState(() => activeCategory = c),
      selectedColor: hvfGold, labelStyle: TextStyle(color: active ? Colors.black : hvfGold),
    );
  }
}
