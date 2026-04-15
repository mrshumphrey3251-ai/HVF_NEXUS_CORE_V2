import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.2 - THE TACTICAL INTERIOR
// FOCUS: SPRINT A - DUAL-VIEW COMMAND ENGINE
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
  runApp(const HVFNexus());
}

class HVFNexus extends StatelessWidget {
  const HVFNexus({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignGate(),
    );
  }
}

// --- THE FRONT GATE ---
class SovereignGate extends StatelessWidget {
  const SovereignGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_rounded, size: 80, color: Color(0xFFC5A059)),
          const SizedBox(height: 20),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(letterSpacing: 6, fontSize: 12)),
          const SizedBox(height: 60),
          _gateBtn(context, "CEO_COMMAND", const CEOWarRoom()),
          _gateBtn(context, "PARTNER_UPLINK", const ProducerUplink()),
        ]),
      ),
    );
  }

  Widget _gateBtn(BuildContext context, String l, Widget target) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2)),
    ),
  );
}

// --- CEO COMMAND: THE WAR ROOM ---
class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: COMMAND_OVERSIGHT ::", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059)))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          int nodes = snapshot.data!.docs.length;
          double reserve = nodes * 10.0; // Simulated flat-rate insurance inflow

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              _metricTile("NATIONAL_NODES", "$nodes ACTIVE", Colors.cyan),
              const SizedBox(height: 10),
              _metricTile("RESERVE_INFLOW", "\$${reserve.toStringAsFixed(2)}", const Color(0xFFC5A059)),
              const Divider(height: 40, color: Colors.white10),
              const Text("GRID STATUS: 100% SME CERTIFIED", style: TextStyle(fontSize: 8, color: Colors.green)),
              const Spacer(),
              const Icon(Icons.hub_outlined, size: 100, color: Colors.white10),
            ]),
          );
        },
      ),
    );
  }

  Widget _metricTile(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c)),
      Text(v, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- PARTNER: THE UPLINK RAILS ---
class ProducerUplink extends StatefulWidget {
  const ProducerUplink({super.key});
  @override
  State<ProducerUplink> createState() => _ProducerUplinkState();
}

class _ProducerUplinkState extends State<ProducerUplink> {
  String type = "CATTLE";
  bool sse = false;
  final idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: ASSET_INITIALIZATION ::", style: TextStyle(fontSize: 10))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: type,
            items: ["CATTLE", "PIGS", "TRACTOR", "SEMI-TRUCK"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => type = v!),
            decoration: const InputDecoration(labelText: "ASSET_CATEGORY"),
          ),
          const SizedBox(height: 20),
          TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "TAG_ID / SERIAL_NO")),
          const SizedBox(height: 40),
          SwitchListTile(
            title: const Text("SME_SAFETY_VERIFIED", style: TextStyle(fontSize: 10, color: Colors.cyan)),
            value: sse, onChanged: (v) => setState(() => sse = v),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: sse ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
            onPressed: sse ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idCtrl.text, 'type': type, 'status': 'SECURED', 'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            } : null,
            child: const Text("AUTHORIZE UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}
