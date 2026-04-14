import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V108.0 - THE FINAL CHANNEL LOCK
// STATUS: DEPLOYMENT STAGE 8
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
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
    print("HVF_NEXUS: Firebase Connected Successfully");
  } catch (e) {
    print("HVF_NEXUS: Connection Failed: $e");
  }
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

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: CEO COMMAND ::" : ":: FIELD UPLINK ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 13)),
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
        if (docs.isEmpty) return const Center(child: Text("WAITING FOR FIELD ASSETS...", style: TextStyle(color: Colors.grey)));
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['breed'] ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text("ID: ${data['id'] ?? '---'}", style: const TextStyle(color: hvfGold)),
              trailing: const Icon(Icons.cloud_done, color: Colors.green, size: 15),
            );
          },
        );
      },
    );
  }

  Widget _buildInduction() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      TextField(controller: b, decoration: const InputDecoration(labelText: "ASSET_BREED", labelStyle: TextStyle(color: Colors.grey))),
      TextField(controller: t, decoration: const InputDecoration(labelText: "ASSET_ID", labelStyle: TextStyle(color: Colors.grey))),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 50)),
        onPressed: () async {
          if (b.text.isNotEmpty) {
            try {
              await FirebaseFirestore.instance.collection('ledger').add({
                'breed': b.text,
                'id': t.text,
                'timestamp': FieldValue.serverTimestamp(),
              });
              b.clear(); t.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SUCCESSFUL")));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("UPLINK FAILED: $e")));
            }
          }
        },
        child: const Text("UPLINK TO CLOUD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }
}
