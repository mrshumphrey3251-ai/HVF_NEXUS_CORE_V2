import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V128.0 - THE RESTORATION PATHWAY
// INCLUSIVE VETTING | AUTOMATED GUIDANCE FOR GROWING ASSETS
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
        title: const Text("RESTORATION_PATHWAY: ACTIVE", style: TextStyle(fontSize: 8, color: Colors.cyan)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _sovereignHeader(),
          const Spacer(),
          const Icon(Icons.trending_up_rounded, size: 80, color: Color(0xFFC5A059)),
          const Text("INTAKE & GUIDANCE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          _actionGrid(context),
          const Spacer(),
          const Text("HVF MISSION: WE GUIDE THE GROWTH", style: TextStyle(fontSize: 7, color: Colors.white24)),
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
        Text("MISSION: RESTORATION", style: TextStyle(fontSize: 7, color: Colors.white24)),
        Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
      ],
    ),
  );

  Widget _actionGrid(BuildContext context) => Wrap(
    spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
    children: [
      _btn(context, "START_APPLICATION", Icons.assignment_turned_in, const RestorationPortal()),
      _btn(context, "GUIDANCE_RESOURCES", Icons.map, const Placeholder()),
      _btn(context, "SOVEREIGN_EXCHANGE", Icons.currency_exchange, const Placeholder()),
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

// --- THE RESTORATION PORTAL ---
class RestorationPortal extends StatefulWidget {
  const RestorationPortal({super.key});
  @override
  State<RestorationPortal> createState() => _RestorationPortalState();
}

class _RestorationPortalState extends State<RestorationPortal> {
  final nameCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  String cert = "NONE";
  bool isFarmer = false;

  // Logic to determine if they need guidance
  bool get needsPath => cert == "NONE" && !isFarmer;
  bool get canSubmit => nameCtrl.text.isNotEmpty && idCtrl.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: ENTER_THE_PATHWAY ::", style: TextStyle(fontSize: 9))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "NAME / FARM_ENTITY"), onChanged: (_) => setState(() {})),
          const SizedBox(height: 10),
          TextField(controller: idCtrl, decoration: const InputDecoration(labelText: "TAX_ID / FARM_REG_NUMBER"), onChanged: (_) => setState(() {})),
          const SizedBox(height: 15),
          SwitchListTile(
            title: const Text("I AM OPERATING AS A FARMER", style: TextStyle(fontSize: 8)),
            value: isFarmer, onChanged: (v) => setState(() => isFarmer = v),
          ),
          const Text("PRIMARY CERTIFICATION (IF ANY)", style: TextStyle(fontSize: 7, color: Colors.cyan)),
          DropdownButton<String>(
            value: cert, isExpanded: true,
            items: ["NONE", "NCCER", "NCCO", "AGRICULTURE_SME"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 10)))).toList(),
            onChanged: (v) => setState(() => cert = v!),
          ),
          const Spacer(),
          if (needsPath && nameCtrl.text.isNotEmpty) 
            Container(
              padding: const EdgeInsets.all(15), color: Colors.cyan.withOpacity(0.1),
              child: const Text("PATHWAY DETECTED: You will be routed to HVF Certification Guidance upon submission.", style: TextStyle(fontSize: 8, color: Colors.cyan)),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: canSubmit ? const Color(0xFFC5A059) : Colors.grey, minimumSize: const Size(double.infinity, 60)),
            onPressed: canSubmit ? () {
              // Submit and trigger guidance if needed
              Navigator.pop(context);
            } : null,
            child: Text(needsPath ? "BEGIN RESTORATION PATH" : "SUBMIT SOVEREIGN APPLICATION", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
    return const Scaffold(body: Center(child: Text("GUIDANCE_MOD_SYNCING...")));
  }
}
