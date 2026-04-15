import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V127.0 - THE VETTING GATE
// 0900 EXECUTION | PARTNER & PRODUCER FILTRATION
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
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

class SovereignDashboard extends StatelessWidget {
  const SovereignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("PRODUCER_VETTING_ACTIVE", style: TextStyle(fontSize: 8, color: Colors.orangeAccent)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _sovereignHeader(),
          const Spacer(),
          const Icon(Icons.verified_user_rounded, size: 80, color: Color(0xFFC5A059)),
          const Text("THE VETTING GATE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("SME CONTROL: WEEDING THE BAD FRUIT", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sovereignHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    color: const Color(0xFF111111),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("CAGE: 1AHA8", style: TextStyle(fontSize: 7, color: Colors.cyan)),
        Text("STATUS: GATE_LOCKED", style: TextStyle(fontSize: 7, color: Colors.white24)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "PARTNER_APPLICATION", Icons.assignment_ind, const ApplicationPortal()),
      _btn(context, "SME_VETTING_DESK", Icons.fact_check, const Placeholder()),
      _btn(context, "SOVEREIGN_EXCHANGE", Icons.currency_exchange, const Placeholder()),
      _btn(context, "EXECUTIVE_WAR_ROOM", Icons.analytics, const Placeholder()),
    ],
  );

  Widget _btn(BuildContext context, String l, IconData i, Widget t) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => t)),
    child: Container(
      width: 155, height: 95,
      decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border.all(color: const Color(0xFFC5A059), width: 0.5)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(i, color: const Color(0xFFC5A059), size: 24),
        const SizedBox(height: 8),
        Text(l, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

// --- MODULE: PARTNER APPLICATION PORTAL ---
class ApplicationPortal extends StatefulWidget {
  const ApplicationPortal({super.key});
  @override
  State<ApplicationPortal> createState() => _ApplicationPortalState();
}

class _ApplicationPortalState extends State<ApplicationPortal> {
  final nameCtrl = TextEditingController();
  final taxIdCtrl = TextEditingController();
  bool certConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: NEW_PARTNER_INTAKE ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("SOVEREIGN COMPLIANCE FORM", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
          const SizedBox(height: 20),
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "LEGAL_ENTITY_NAME")),
          const SizedBox(height: 15),
          TextField(controller: taxIdCtrl, decoration: const InputDecoration(labelText: "TAX_ID_OR_CAGE")),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text("I ATTEST TO SME STANDARDS", style: TextStyle(fontSize: 8)),
            value: certConfirmed, onChanged: (v) => setState(() => certConfirmed = v!),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: certConfirmed ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
            onPressed: certConfirmed ? () {
              // Logic to submit to 'pending_partners' collection
              Navigator.pop(context);
            } : null,
            child: const Text("SUBMIT FOR CEO REVIEW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("UPLINK_STABLE")));
  }
}
