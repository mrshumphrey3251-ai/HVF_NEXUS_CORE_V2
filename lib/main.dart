import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.5 - SPRINT B: THE REVENUE ENGINE
// FOCUS: AUTOMATED PREMIUM ROUTING & CARRIER RESERVE LOGIC
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
          _actionBtn(context, "EXECUTIVE_WAR_ROOM", const CEOWarRoom(), true),
          _actionBtn(context, "PARTNER_UPLINK", const ProducerUplink(), false),
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

// --- CEO COMMAND: THE REVENUE MONITOR ---
class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: GLOBAL_RESERVE_OVERSIGHT ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Colors.cyan));
          
          double totalReserve = 0;
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            totalReserve += (data['premium'] ?? 0.0);
          }

          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _metric("CARRIER_RESERVE_TOTAL", "\$${totalReserve.toStringAsFixed(2)}", const Color(0xFFC5A059)),
              const SizedBox(height: 15),
              _metric("ACTIVE_UNDERWRITTEN_UNITS", "${snapshot.data!.docs.length} NODES", Colors.cyan),
              const Divider(height: 40, color: Colors.white10),
              const Text("REVENUE_STREAM: RECURRING_MONTHLY", style: TextStyle(fontSize: 8, color: Colors.greenAccent)),
              const Spacer(),
              const Center(child: Icon(Icons.account_balance_outlined, color: Colors.white10, size: 80)),
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
      Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    ]),
  );
}

// --- PARTNER PORTAL: PREMIUM ROUTING ---
class ProducerUplink extends StatefulWidget {
  const ProducerUplink({super.key});
  @override
  State<ProducerUplink> createState() => _ProducerUplinkState();
}

class _ProducerUplinkState extends State<ProducerUplink> {
  String selectedType = "CATTLE";
  bool certified = false;
  final idController = TextEditingController();

  // THE REVENUE LOGIC
  final Map<String, double> premiumRates = {
    "CATTLE": 10.0,
    "PIGS": 5.0,
    "CHICKENS": 2.0,
    "FLEET_UNIT": 25.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: CARRIER_UPLINK_RAILS ::", style: TextStyle(fontSize: 9))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: selectedType,
            items: premiumRates.keys.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)))).toList(),
            onChanged: (v) => setState(() => selectedType = v!),
            decoration: const InputDecoration(labelText: "ASSET_CLASS"),
          ),
          const SizedBox(height: 20),
          Text("REQUIRED_MONTHLY_PREMIUM: \$${premiumRates[selectedType]}", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
          const SizedBox(height: 30),
          TextField(controller: idController, decoration: const InputDecoration(labelText: "ASSET_ID")),
          const SizedBox(height: 50),
          CheckboxListTile(
            activeColor: const Color(0xFFC5A059),
            title: const Text("ATTEST TO CARRIER STANDARDS", style: TextStyle(fontSize: 9)),
            value: certified, 
            onChanged: (v) => setState(() => certified = v!),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: certified ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 65)),
            onPressed: certified ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idController.text,
                'type': selectedType,
                'premium': premiumRates[selectedType],
                'certified': true,
                'timestamp': FieldValue.serverTimestamp()
              });
              Navigator.pop(context);
            } : null,
            child: const Text("INITIALIZE REVENUE FLOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}
