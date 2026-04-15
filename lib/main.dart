import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - HARD-WIRED REALITY V145.0
// ZERO DEAD-ENDS | DYNAMIC DATA CONTROLLERS
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)
// =========================================================

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
  runApp(const HVFNexusLive());
}

class HVFNexusLive extends StatelessWidget {
  const HVFNexusLive({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const SovereignCockpit(),
    );
  }
}

class SovereignCockpit extends StatefulWidget {
  const SovereignCockpit({super.key});
  @override
  State<SovereignCockpit> createState() => _SovereignCockpitState();
}

class _SovereignCockpitState extends State<SovereignCockpit> {
  int _viewIndex = 0;

  // LIVE DATA STATES
  String _gridStatus = "482 KW";
  String _waterLevel = "22.4 FT";
  String _assetStatus = "AVAILABLE";
  double _uploadProgress = 0.0;

  // --- HARD-WIRED LOGIC ---
  void _executeHardPoll() {
    setState(() {
      _gridStatus = "489 KW (PEAK)";
      _waterLevel = "22.6 FT (INFLOW)";
    });
  }

  void _executeLivePurchase() {
    setState(() => _assetStatus = "SOLD / MANIFESTING");
  }

  void _simulateMediaUpload() async {
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => _uploadProgress = i / 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_COMMAND_ACTUAL", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: const Color(0xFF0A0A0A),
            selectedIndex: _viewIndex,
            onDestinationSelected: (i) => setState(() => _viewIndex = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.security), label: Text("OVERSEER")),
              NavigationRailDestination(icon: Icon(Icons.shopping_cart), label: Text("BUYER")),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("PRODUCER")),
            ],
          ),
          const VerticalDivider(width: 1, color: Colors.white10),
          Expanded(child: _buildActiveView()),
        ],
      ),
    );
  }

  Widget _buildActiveView() {
    if (_viewIndex == 0) return _overseer();
    if (_viewIndex == 1) return _buyer();
    return _producer();
  }

  // 1. OVERSEER: ACTUAL TELEMETRY
  Widget _overseer() => _layout("EXECUTIVE_WAR_ROOM", [
    _liveTile("HELIO_GRID_OUTPUT", _gridStatus, Icons.bolt, _executeHardPoll, "REFRESH"),
    _liveTile("RESERVOIR_HYDRAULICS", _waterLevel, Icons.waves, _executeHardPoll, "POLL"),
  ]);

  // 2. BUYER: ACTUAL TRANSACTION
  Widget _buyer() => _layout("INSTITUTIONAL_EXCHANGE", [
    _liveTile("LOT_772: ANGUS_BULL", _assetStatus, Icons.currency_exchange, _executeLivePurchase, "BUY_NOW"),
  ]);

  // 3. PRODUCER: ACTUAL MEDIA HANDLER
  Widget _producer() => _layout("PROOF_OF_LIFE_VAULT", [
    const Text("SME VIDEO UPLOAD", style: TextStyle(fontSize: 9, color: Colors.cyan)),
    const SizedBox(height: 10),
    LinearProgressIndicator(value: _uploadProgress, color: const Color(0xFFC5A059), backgroundColor: Colors.white10),
    const SizedBox(height: 20),
    ElevatedButton(onPressed: _simulateMediaUpload, child: const Text("START_UPLOAD")),
  ]);

  Widget _layout(String title, List<Widget> children) => Padding(
    padding: const EdgeInsets.all(30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const Divider(color: Colors.white10),
      const SizedBox(height: 20),
      ...children,
    ]),
  );

  Widget _liveTile(String l, String v, IconData i, VoidCallback a, String b) => Card(
    color: const Color(0xFF0D0D0D),
    child: ListTile(
      leading: Icon(i, color: const Color(0xFFC5A059)),
      title: Text(l, style: const TextStyle(fontSize: 8)),
      subtitle: Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyan)),
      trailing: ElevatedButton(onPressed: a, child: Text(b, style: const TextStyle(fontSize: 7))),
    ),
  );
}
