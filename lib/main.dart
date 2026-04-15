import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.4 - SPRINT A STABILIZED
// FOCUS: CORRECTING CONTROLLER LOGIC & CLEANING COMPILER SCOPE
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
          double marketValue = count * 2250.0;

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _metric("MANAGED_NODES", "$count UNITS", Colors.cyan),
              const SizedBox(height: 15),
              _metric("TOTAL_GRID_FMV", "\$${marketValue.toStringAsFixed(0)}", const Color(0xFFC5A059)),
              const SizedBox(height: 15),
              _metric("CARRIER_RESERVE", "\$${(count * 10).toStringAsFixed(2)}", Colors.greenAccent),
              const Spacer(),
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
            value: certified, 
            onChanged: (v) => setState(() => certified = v!),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: certified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 65)),
            onPressed: certified ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idController.text, 'type': selectedType, 'certified': true, 'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            } : null,
            child: const Text("EXECUTE SECURE UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}
