import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V123.0 - PHASE 2: THE REVENUE ENGINE
// CRITICAL UPGRADE: CARRIER SHIELD & PREMIUM ROUTING
// AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignDashboard(),
    );
  }
}

// --- MASTER DASHBOARD ---
class SovereignDashboard extends StatelessWidget {
  const SovereignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("UEI: S1M4ENLHTDH5 | CARRIER_STATUS: PRIMARY", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Spacer(),
          const Icon(Icons.shield_rounded, size: 80, color: Color(0xFFC5A059)),
          const Text("HVF NEXUS CORE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
              children: [
                _tile(context, "WAR_ROOM", Icons.account_balance, const WarRoom()),
                _tile(context, "ASSET_UPLINK", Icons.upload_file, const AssetUplink()),
                _tile(context, "EXCHANGE", Icons.currency_exchange, const ExchangeTerminal()),
              ],
            ),
          ),
          const Spacer(),
          const Text("PATENT: TPP99424 | SME: JEFFERY D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String l, IconData i, Widget t) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 150, height: 90,
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 20),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

// --- MODULE 1: THE WAR ROOM (FINANCIALS) ---
class WarRoom extends StatelessWidget {
  const WarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: STORM_CHEST_RESERVE ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          double total = 0;
          for (var doc in snapshot.data!.docs) {
            total += (doc['premium'] ?? 0.0);
          }
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              _metric("CARRIER_LIQUIDITY", "\$${total.toStringAsFixed(2)}", const Color(0xFFC5A059)),
              const SizedBox(height: 15),
              _metric("UNITS_UNDERWRITTEN", "${snapshot.data!.docs.length}", Colors.cyan),
            ]),
          );
        },
      ),
    );
  }

  Widget _metric(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- MODULE 2: ASSET UPLINK (THE GATEKEEPER) ---
class AssetUplink extends StatefulWidget {
  const AssetUplink({super.key});
  @override
  State<AssetUplink> createState() => _AssetUplinkState();
}

class _AssetUplinkState extends State<AssetUplink> {
  String type = "CATTLE";
  bool smeCheck = false;
  final idCtrl = TextEditingController();
  final rates = {"CATTLE": 10.0, "FLEET": 25.0, "SOLAR_NODE": 50.0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: INITIALIZE_CARRIER_SHIELD ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: type,
            items: rates.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => type = v!),
          ),
          const SizedBox(height: 20),
          TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "ASSET_SERIAL_ID")),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text("SME_SAFETY_ATTESTATION", style: TextStyle(fontSize: 9, color: Colors.cyan)),
            value: smeCheck, onChanged: (v) => setState(() => smeCheck = v!),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: smeCheck ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
            onPressed: smeCheck ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idCtrl.text, 'type': type, 'premium': rates[type], 'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            } : null,
            child: const Text("ACTIVATE SHIELD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- MODULE 3: EXCHANGE (THE MARKETPLACE) ---
class ExchangeTerminal extends StatelessWidget {
  const ExchangeTerminal({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: SOVEREIGN_EXCHANGE ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final d = snapshot.data!.docs[i];
              return ListTile(
                leading: const Icon(Icons.verified, color: Colors.cyan, size: 16),
                title: Text("${d['name']}", style: const TextStyle(fontSize: 10)),
                subtitle: Text("${d['type']} | SHIELD_ACTIVE", style: const TextStyle(fontSize: 7, color: Colors.grey)),
                trailing: Text("\$${d['premium']}", style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              );
            },
          );
        },
      ),
    );
  }
}
