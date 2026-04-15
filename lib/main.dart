import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.5 - SOVEREIGN UNDERWRITER & COMPILER RECOVERY
// TARGET: ZERO-FAILURE ENTRYPOINT FOR INSTITUTIONAL SCALE
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
      home: const UnderwriterPortal(),
    );
  }
}

class UnderwriterPortal extends StatefulWidget {
  const UnderwriterPortal({super.key});
  @override
  State<UnderwriterPortal> createState() => _UnderwriterPortalState();
}

class _UnderwriterPortalState extends State<UnderwriterPortal> {
  final Map<String, double> insPremium = {
    "CATTLE": 10.0, 
    "PIGS": 5.0, 
    "CHICKENS": 2.0, 
    "FLEET": 25.0
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(":: HVF GLOBAL RESERVE ::", style: TextStyle(color: Colors.cyan, fontSize: 10)),
        actions: const [Icon(Icons.shield, color: Colors.cyan, size: 16), SizedBox(width: 15)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Colors.cyan));
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("AWAITING SUPPLY DATA...", style: TextStyle(color: Colors.grey, fontSize: 10)));
          
          double totalReserve = 0;
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            totalReserve += insPremium[data['type']] ?? 0.0;
          }

          return Column(children: [
            Container(
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              color: const Color(0xFF111111),
              child: Column(children: [
                const Text("MONTHLY UNDERWRITING INFLOW", style: TextStyle(fontSize: 8, color: Colors.grey)),
                Text("\$${totalReserve.toStringAsFixed(2)}", style: const TextStyle(fontSize: 28, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                const Text("SOVEREIGN PROTECTION ACTIVE", style: TextStyle(fontSize: 7, color: Colors.cyan)),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
                  return Card(
                    color: const Color(0xFF0D0D0D),
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.verified_user, color: Colors.cyan, size: 18),
                      title: Text(d['name'] ?? "ASSET", style: const TextStyle(fontSize: 12)),
                      subtitle: Text("CATEGORY: ${d['type'] ?? 'UNSPECIFIED'} | PREMIUM: \$${insPremium[d['type']] ?? 0.0}", style: const TextStyle(fontSize: 8)),
                      trailing: const Text("SECURED", style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
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
