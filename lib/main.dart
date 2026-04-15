import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.4 - PHASE 5: THE SOVEREIGN EXCHANGE
// FOCUS: DE-RISKED ASSET MARKETPLACE & FMV LOGIC
// DAY 5 OF 7 | AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
      authDomain: "hvf-nexus.firebaseapp.com",
      projectId: "hvf-nexus",
      storageBucket: "hvf-nexus.firebasestorage.app",
      messagingSenderId: "892263251736",
      appId: "1:892263251736:web:899cc6ab03f6f5e9d82899",
    ),
  );
  runApp(const HVFNexusOS());
}

class HVFNexusOS extends StatelessWidget {
  const HVFNexusOS({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const FederalCommandGate(),
    );
  }
}

// --- COMMAND GATE (UPDATED WITH EXCHANGE MODULE) ---
class FederalCommandGate extends StatelessWidget {
  const FederalCommandGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10), color: const Color(0xFF111111),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
            Text("EXCHANGE_STATUS: OPEN", style: TextStyle(fontSize: 8, color: Colors.greenAccent)),
          ]),
        ),
        const Spacer(),
        const Icon(Icons.currency_exchange_rounded, size: 80, color: Color(0xFFC5A059)),
        const Text("SOVEREIGN EXCHANGE", style: TextStyle(fontSize: 18, letterSpacing: 6, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _cmdBtn(context, "MARKETPLACE_TERMINAL", const ExchangeTerminal()),
        _cmdBtn(context, "EXECUTIVE_WAR_ROOM", const Placeholder()), // Links to Day 3
        const Spacer(),
        const Text("DE-RISKED COMMODITY FLOW", style: TextStyle(fontSize: 7, color: Colors.white24)),
        const SizedBox(height: 30),
      ]),
    );
  }

  Widget _cmdBtn(BuildContext context, String l, Widget t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(300, 55)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9, letterSpacing: 2)),
    ),
  );
}

// --- DAY 5 MODULE: THE EXCHANGE TERMINAL ---
class ExchangeTerminal extends StatelessWidget {
  const ExchangeTerminal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: GLOBAL_COMMODITY_GRID ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          return Column(children: [
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: const Color(0xFF0D0D0D),
              child: const Text("AVAILABLE DE-RISKED INVENTORY", textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 2)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.2)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Icon(Icons.verified_user, color: Colors.cyan, size: 12),
                        Text("SHIELD_ACTIVE", style: TextStyle(fontSize: 6, color: Colors.cyan)),
                      ]),
                      const Spacer(),
                      Text(d['name'] ?? "ASSET_ID", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("${d['type']} | CERTIFIED", style: const TextStyle(fontSize: 7, color: Colors.grey)),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: const Color(0xFFC5A059),
                        child: const Text("SECURE ASSET", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
