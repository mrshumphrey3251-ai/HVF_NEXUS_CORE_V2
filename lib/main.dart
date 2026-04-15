import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V119.6 - SPRINT C: THE OPERATIONAL FORTRESS
// FOCUS: SME BIO-SECURITY LOCK & SOVEREIGN AUDIT TRAIL
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
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignGate(),
    );
  }
}

// --- ENTRY GATE ---
class SovereignGate extends StatelessWidget {
  const SovereignGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.security, size: 80, color: Color(0xFFC5A059)),
          const SizedBox(height: 10),
          const Text("HVF NEXUS OS", style: TextStyle(letterSpacing: 10, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          _nav(context, "CEO_COMMAND", const CEOWarRoom()),
          _nav(context, "PARTNER_UPLINK", const ProducerUplink()),
        ]),
      ),
    );
  }
  Widget _nav(BuildContext context, String l, Widget t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2)),
    ),
  );
}

// --- CEO COMMAND: THE AUDIT FORTRESS ---
class CEOWarRoom extends StatelessWidget {
  const CEOWarRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: SOVEREIGN_AUDIT_LOG ::", style: TextStyle(fontSize: 10))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          return Column(children: [
            Container(
              padding: const EdgeInsets.all(25),
              color: const Color(0xFF0A0A0A),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("GRID_INTEGRITY", style: TextStyle(fontSize: 8, color: Colors.cyan)),
                  Text("${snapshot.data!.docs.length} SECURED", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
                const Icon(Icons.verified, color: Colors.greenAccent, size: 30),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))),
                    child: Row(children: [
                      const Icon(Icons.shield, color: Colors.cyan, size: 14),
                      const SizedBox(width: 15),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(d['name'] ?? "UNKNOWN", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        Text("TYPE: ${d['type']} | PREMIUM: \$${d['premium']}", style: const TextStyle(fontSize: 7, color: Colors.grey)),
                      ]),
                      const Spacer(),
                      const Text("CERTIFIED", style: TextStyle(color: Colors.green, fontSize: 8)),
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

// --- PARTNER: THE FORTRESS RAILS ---
class ProducerUplink extends StatefulWidget {
  const ProducerUplink({super.key});
  @override
  State<ProducerUplink> createState() => _ProducerUplinkState();
}

class _ProducerUplinkState extends State<ProducerUplink> {
  String type = "CATTLE";
  bool healthy = false;
  bool maintained = false;
  final idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: SECURE_INITIALIZATION ::", style: TextStyle(fontSize: 10))),
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
          TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "SERIAL_NUMBER / TAG_ID")),
          const SizedBox(height: 30),
          const Text("BIO-SECURITY & MAINTENANCE ATTESTATION", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
          CheckboxListTile(title: const Text("NO DISEASE / DEFECTS", style: TextStyle(fontSize: 9)), value: healthy, onChanged: (v) => setState(() => healthy = v!)),
          CheckboxListTile(title: const Text("SME PROTOCOLS MET", style: TextStyle(fontSize: 9)), value: maintained, onChanged: (v) => setState(() => maintained = v!)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: (healthy && maintained) ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
            onPressed: (healthy && maintained) ? () async {
              await FirebaseFirestore.instance.collection('enterprise_ledger').add({
                'name': idCtrl.text, 'type': type, 'premium': type == "CATTLE" ? 10.0 : 25.0,
                'status': 'SECURED', 'timestamp': FieldValue.serverTimestamp()
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
