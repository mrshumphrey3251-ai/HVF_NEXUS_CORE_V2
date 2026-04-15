import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V120.2 - PHASE 3: THE UNDERWRITER SHIELD
// FOCUS: CARRIER REVENUE & STORM CHEST LIQUIDITY
// DAY 3 OF 7 | AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
        scaffoldBackgroundColor: const Color(0xFF010101),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const FederalCommandGate(),
    );
  }
}

// --- COMMAND GATE (UPDATED WITH FINANCIAL MODULE) ---
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
            Text("SAM.GOV: ACTIVE", style: TextStyle(fontSize: 8, color: Colors.cyan)),
          ]),
        ),
        const Spacer(),
        const Icon(Icons.account_balance_rounded, size: 80, color: Color(0xFFC5A059)),
        const Text("HVF REVENUE ENGINE", style: TextStyle(fontSize: 18, letterSpacing: 6, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        _cmdBtn(context, "EXECUTIVE_WAR_ROOM", const CEOWarRoom()),
        _cmdBtn(context, "UNDERWRITER_UPLINK", const AssetUplink()),
        const Spacer(),
        const Text("CARRIER STATUS: PRIMARY", style: TextStyle(fontSize: 7, color: Colors.greenAccent)),
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

// --- DAY 3 MODULE: THE STORM CHEST ---
class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: STORM_CHEST_LIQUIDITY ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          double reserve = 0;
          for (var doc in snapshot.data!.docs) {
            final d = doc.data() as Map<String, dynamic>;
            reserve += (d['premium'] ?? 0.0);
          }

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              _finBox("HVF_CARRIER_RESERVE", "\$${reserve.toStringAsFixed(2)}", const Color(0xFFC5A059)),
              const SizedBox(height: 10),
              _finBox("TOTAL_UNDERWRITTEN", "${snapshot.data!.docs.length} UNITS", Colors.cyan),
              const Spacer(),
              const Text("NON-EXHAUSTIVE ASSET PROTECTION FUND", style: TextStyle(fontSize: 7, color: Colors.white24)),
            ]),
          );
        },
      ),
    );
  }

  Widget _finBox(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(25), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- DAY 3 MODULE: PREMIUM UPLINK ---
class AssetUplink extends StatefulWidget {
  const AssetUplink({super.key});
  @override
  State<AssetUplink> createState() => _AssetUplinkState();
}

class _AssetUplinkState extends State<AssetUplink> {
  String type = "CATTLE";
  final Map<String, double> rates = {"CATTLE": 10.0, "PIGS": 5.0, "FLEET": 25.0};
  final idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: INITIALIZE_CARRIER_FLOW ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: type,
            items: rates.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => type = v!),
            decoration: const InputDecoration(labelText: "ASSET_CLASS"),
          ),
          const SizedBox(height: 20),
          Text("CARRIER_PREMIUM: \$${rates[type]} / MO", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
          const SizedBox(height: 20),
          TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "ASSET_ID")),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
            onPressed: () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idCtrl.text, 'type': type, 'premium': rates[type], 'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            },
            child: const Text("EXECUTE UNDERWRITER SHIELD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}
