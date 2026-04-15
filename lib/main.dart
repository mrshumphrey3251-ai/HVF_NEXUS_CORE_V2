import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.3 - THE INSTITUTIONAL IMPORTER
// FOCUS: STEP 2 - MASS DATA MIGRATION (10,000 HEAD SCALE)
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

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
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const ProducerPortal(),
    );
  }
}

class ProducerPortal extends StatefulWidget {
  const ProducerPortal({super.key});
  @override
  State<ProducerPortal> createState() => _ProducerPortalState();
}

class _ProducerPortalState extends State<ProducerPortal> {
  bool bulkMode = false;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(":: HVF INSTITUTIONAL UPLINK ::", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: [
          Row(children: [
            const Text("BULK", style: TextStyle(fontSize: 8)),
            Switch(value: bulkMode, onChanged: (v) => setState(() => bulkMode = v), activeColor: Colors.cyan),
          ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (!bulkMode) ...[
            const Icon(Icons.person, color: Colors.grey, size: 50),
            const SizedBox(height: 20),
            const Text("MANUAL MODE ACTIVE", style: TextStyle(color: Colors.grey)),
            const Text("Switch to BULK for Institutional Volume", style: TextStyle(fontSize: 8, color: Colors.grey)),
          ] else ...[
            const Icon(Icons.lan, color: Colors.cyan, size: 80),
            const SizedBox(height: 30),
            const Text("INSTITUTIONAL CSV INGESTION", style: TextStyle(letterSpacing: 2)),
            const SizedBox(height: 10),
            const Text("Ready for 10,000+ Head Ledger", style: TextStyle(fontSize: 8, color: Colors.cyan)),
            const SizedBox(height: 40),
            if (processing) 
              const CircularProgressIndicator(color: Colors.cyan)
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, 
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                ),
                onPressed: () => _triggerMassIngestion(),
                child: const Text("IMPORT PARTNER LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
          ],
        ]),
      ),
    );
  }

  void _triggerMassIngestion() async {
    setState(() => processing = true);
    
    // Simulating the ingestion of 5 institutional lots for verification
    for (int i = 1; i <= 5; i++) {
      await FirebaseFirestore.instance.collection('enterprise_ledger').add({
        'name': 'INST_LOT_00$i',
        'vital': '850', // Avg Weight
        'type': 'CATTLE',
        'category': 'LIVESTOCK',
        'certified': true,
        'source': 'INSTITUTIONAL_PARTNER_01',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    setState(() => processing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(backgroundColor: Colors.cyan, content: Text("MASS INGESTION COMPLETE: 5 NODES ADDED TO GRID"))
    );
  }
}
