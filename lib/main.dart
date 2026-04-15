import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS CORE - SECURE GATE V1.5.1
// AUTHORIZED BY: CEO JEFFERY DONNELL HUMPHREY
// PIN PROTOCOL: CEO(1978), PRODUCER(2026), BUYER(0000)
// =========================================================

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
  runApp(const MaterialApp(home: HVFMasterControl(), debugShowCheckedModeBanner: false));
}

class HVFMasterControl extends StatefulWidget {
  const HVFMasterControl({super.key});
  @override
  State<HVFMasterControl> createState() => _HVFMasterControlState();
}

class _HVFMasterControlState extends State<HVFMasterControl> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  final _db = FirebaseFirestore.instance;

  // TACTICAL PIN CHALLENGE
  void _challengePin(String targetView, String correctPin) {
    TextEditingController pinCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("ENTER $targetView PIN", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(
          controller: pinCtrl,
          obscureText: true,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 10),
          decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059)))),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.red))),
          TextButton(
            onPressed: () {
              if (pinCtrl.text == correctPin) {
                setState(() => view = targetView);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ACCESS DENIED: INVALID CREDENTIALS")));
              }
            },
            child: const Text("AUTHORIZE", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS :: $view", style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      bottomNavigationBar: view == "GATE" ? null : BottomAppBar(
        color: const Color(0xFF111111),
        child: TextButton.icon(
          onPressed: () => setState(() => view = "GATE"),
          icon: const Icon(Icons.lock_reset, color: Colors.red),
          label: const Text("LOCK & EXIT", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _buildProducerEntry();
      case "BUYER": return _buildBuyerMarket();
      case "CEO": return _buildCEODashboard();
      default: return _buildGate();
    }
  }

  Widget _buildGate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _gateBtn("CEO OVERSIGHT", () => _challengePin("CEO", "1978")), 
      _gateBtn("PRODUCER DECK", () => _challengePin("PRODUCER", "2026")),
      _gateBtn("BUYER MARKET", () => setState(() => view = "BUYER")), // Buyer is currently open for public claiming
    ]));
  }

  Widget _gateBtn(String l, VoidCallback act) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 3), minimumSize: const Size(300, 75)),
      onPressed: act,
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  );

  // ... (Producer, Buyer, and CEO methods from V1.5.0 remain the same)
  // Note: Ensure the rest of the methods (_buildProducerEntry, _buildBuyerMarket, _buildCEODashboard) 
  // are included in your final file to maintain functionality.
}
