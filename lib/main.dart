import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V110.2 - HIGH VISIBILITY PATCH
// STATUS: ICON FONT FORCE-LOADED
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
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: const Color(0xFF0D0D0D), 
        fontFamily: 'Courier',
        useMaterial3: true, // Forces modern rendering
      ),
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
        backgroundColor: Colors.black,
        title: Text(role == "CEO" ? ":: CEO COMMAND ::" : ":: FIELD UPLINK ::", 
          style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 12)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Color(0xFFC5A059)), onPressed: () => setState(() => role = null))],
      ),
      body: role == "CEO" ? _buildOverwatch() : _buildInduction(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.security, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4)),
        const SizedBox(height: 50),
        _gateBtn("CEO EXECUTIVE ACCESS", "CEO1880", "CEO"),
        const SizedBox(height: 15),
        _gateBtn("AGENT FIELD ACCESS", "FARMER2026", "AGENT"),
      ])),
    );
  }

  Widget _gateBtn(String l, String k, String r) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(250, 55)),
      onPressed: () => _verify(k, r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    );
  }

  void _verify(String k, String r) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text("VERIFY_ID", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
      actions: [TextButton(onPressed: () { if(val == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _buildOverwatch() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ledger').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            final cat = data['category']?.toString().toUpperCase() ?? "LIVESTOCK";
            
            IconData displayIcon;
            Color displayColor;

            if (cat == "ENERGY") {
              displayIcon = Icons.bolt;
              displayColor = Colors.cyan;
            } else if (cat == "FLEET") {
              displayIcon = Icons.local_shipping;
              displayColor = Colors.orange;
            } else {
              displayIcon = Icons.pets;
              displayColor = const Color(0xFFC5A059);
            }

            return ListTile(
              leading: Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: displayColor, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Icon(displayIcon, color: displayColor, size: 28),
              ),
              title: Text(data['name'] ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("${data['detail'] ?? '---'}", style: TextStyle(color: displayColor)),
              trailing: Text(cat, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            );
          },
        );
      },
    );
  }

  Widget _buildInduction() {
    final n = TextEditingController(); final d = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          _catBtn("LIVESTOCK"), const SizedBox(width: 8),
          _catBtn("ENERGY"), const SizedBox(width: 8),
          _catBtn("FLEET"),
        ]),
      ),
      const SizedBox(height: 30),
      TextField(controller: n, decoration: InputDecoration(
        labelText: activeCategory == "FLEET" ? "ASSET_NAME" : (activeCategory == "ENERGY" ? "ARRAY_NAME" : "BREED_NAME"),
      )),
      TextField(controller: d, decoration: InputDecoration(
        labelText: activeCategory == "FLEET" ? "OPERATIONAL_STATUS" : (activeCategory == "ENERGY" ? "VOLTAGE/CHARGE" : "ASSET_ID"),
      )),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
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
      selectedColor: const Color(0xFFC5A059), labelStyle: TextStyle(color: active ? Colors.black : const Color(0xFFC5A059)),
    );
  }
}
