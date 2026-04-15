import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.3 - SPRINT A FINALIZATION
// FOCUS: HIGH-DENSITY POLISH & SOVEREIGN AUDIT TRAIL
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
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFFC5A059), fontSize: 10),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
        ),
      ),
      home: const SovereignGate(),
    );
  }
}

// --- SOVEREIGN ENTRY GATE ---
class SovereignGate extends StatelessWidget {
  const SovereignGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0A0A0A), Color(0xFF000000)])
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_outlined, size: 70, color: Color(0xFFC5A059)),
          const SizedBox(height: 15),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(letterSpacing: 4, fontSize: 14, fontWeight: FontWeight.bold)),
          const Text("N E X U S   O S", style: TextStyle(letterSpacing: 8, fontSize: 8, color: Colors.grey)),
          const SizedBox(height: 80),
          _actionBtn(context, "CEO_COMMAND_WAR_ROOM", const CEOWarRoom(), true),
          _actionBtn(context, "PARTNER_UPLINK_RAILS", const ProducerUplink(), false),
          const SizedBox(height: 60),
          const Text("EST 1840 | PROPRIETARY CORE V2.0", style: TextStyle(fontSize: 7, color: Colors.white10)),
        ]),
      ),
    );
  }

  Widget _actionBtn(BuildContext context, String label, Widget target, bool isCEO) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isCEO ? const Color(0xFFC5A059) : Colors.white10),
        minimumSize: const Size(300, 60),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Text(label, style: TextStyle(color: isCEO ? const Color(0xFFC5A059) : Colors.grey, letterSpacing: 2, fontSize: 9)),
    ),
  );
}

// --- CEO COMMAND: HIGH-DENSITY OVERSIGHT ---
class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: EXECUTIVE_SUMMARY ::", style: TextStyle(fontSize: 9, letterSpacing: 2))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Colors.cyan));
          int count = snapshot.data!.docs.length;
          double marketValue = count * 2250.0; // Simulated asset market floor

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _metric("MANAGED_NODES", "$count UNITS", Colors.cyan),
              const SizedBox(height: 15),
              _metric("TOTAL_GRID_FMV", "\$${marketValue.toStringAsFixed(0)}", const Color(0xFFC5A059)),
              const SizedBox(height: 15),
              _metric("CARRIER_RESERVE", "\$${(count * 10).toStringAsFixed(2)}", Colors.greenAccent),
              const Spacer(),
              const Divider(color: Colors.white10),
              const Center(child: Text("HVF SOVEREIGN SYSTEM STATUS: OPERATIONAL", style: TextStyle(fontSize: 7, color: Colors.white24))),
            ]),
          );
        },
      ),
    );
  }

  Widget _metric(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF0A0A0A), border: Border(left: BorderSide(color: c, width: 2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1)),
    ]),
  );
}

// --- PARTNER PORTAL: THE SME RAILS ---
class ProducerUplink extends StatefulWidget {
  const ProducerUplink({super.key});
  @override
  State<ProducerUplink> createState() => _ProducerUplinkState();
}

class _ProducerUplinkState extends State<ProducerUplink> {
  String selectedType = "CATTLE";
  bool certified = false;
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: INITIALIZE_UPLINK ::", style: TextStyle(fontSize: 9))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: selectedType,
            items: ["CATTLE", "PIGS", "CHICKENS", "FLEET_UNIT"].map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)))).toList(),
            onChanged: (v) => setState(() => selectedType = v!),
            decoration: const InputDecoration(labelText: "ASSET_CLASS"),
          ),
          const SizedBox(height: 25),
          TextField(controller: idController, decoration: const InputDecoration(labelText: "UNIQUE_IDENTIFIER (RFID/VIN)")),
          const SizedBox(height: 50),
          CheckboxListTile(
            activeColor: const Color(0xFFC5A059),
            title: const Text("ATTEST TO SME SAFETY STANDARDS", style: TextStyle(fontSize: 9, color: Colors.cyan)),
            subtitle: const Text("Strict adherence to HVF biosecurity and maintenance protocols.", style: TextStyle(fontSize: 7, color: Colors.grey)),
            value: certified, 
            onChanged: (v) => setState(() => certified = v!),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: certified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 65)),
            onPressed: certified ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idController.controller.text, 'type': selectedType, 'certified': true, 'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            } : null,
            child: const Text("EXECUTE SECURE UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
        ]),
      ),
    );
  }
}import 'package:flutter/material.dart';
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
