import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// =========================================================
// HVF NEXUS OS - CONSOLIDATED WEB CORE V144.0
// THE "ONE-UNIT" ARCHITECTURE | WEB-STABILIZED
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
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
  runApp(const HVFNexusUnified());
}

class HVFNexusUnified extends StatelessWidget {
  const HVFNexusUnified({super.key});
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
      home: const SovereignHub(),
    );
  }
}

class SovereignHub extends StatefulWidget {
  const SovereignHub({super.key});
  @override
  State<SovereignHub> createState() => _SovereignHubState();
}

class _SovereignHubState extends State<SovereignHub> {
  int _viewIndex = 0; // 0: Overseer, 1: Buyer, 2: Producer

  void _notify(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF0D0D0D),
      content: Text(msg, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_UNIFIED_COMMAND", style: TextStyle(fontSize: 8, letterSpacing: 2)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan)))],
      ),
      body: Row(
        children: [
          // SIDE NAVIGATION: THE ROLE SELECTOR
          NavigationRail(
            backgroundColor: const Color(0xFF0A0A0A),
            selectedIndex: _viewIndex,
            onDestinationSelected: (int i) => setState(() => _viewIndex = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.security), label: Text("OVERSEER", style: TextStyle(fontSize: 7))),
              NavigationRailDestination(icon: Icon(Icons.shopping_cart), label: Text("BUYER", style: TextStyle(fontSize: 7))),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("PRODUCER", style: TextStyle(fontSize: 7))),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.white10),
          // MAIN COMMAND AREA
          Expanded(child: _buildActivePanel()),
        ],
      ),
    );
  }

  Widget _buildActivePanel() {
    switch (_viewIndex) {
      case 0: return _overseerPanel();
      case 1: return _buyerPanel();
      case 2: return _producerPanel();
      default: return _overseerPanel();
    }
  }

  Widget _overseerPanel() => _basePanel("EXECUTIVE_WAR_ROOM", [
    _cmdTile("HELIOGRID_SENTINEL", "482KW_STABLE", Icons.bolt, () => _notify("POLLING_GRID_DATA...")),
    _cmdTile("RESERVOIR_TELEMETRY", "22.4_FT", Icons.waves, () => _notify("POLLING_HYDRAULICS...")),
  ]);

  Widget _buyerPanel() => _basePanel("INSTITUTIONAL_EXCHANGE", [
    _cmdTile("EXECUTE_PURCHASE: LOT_772", "\$1,500", Icons.currency_exchange, () => _notify("INITIALIZING_TRANSACTION_CAGE_1AHA8...")),
    _cmdTile("FLEET_TRACKING", "IN_TRANSIT", Icons.local_shipping, () => _notify("FETCHING_4PL_MANIFESTS...")),
  ]);

  Widget _producerPanel() => _basePanel("PRODUCER_PROOF_PORTAL", [
    _cmdTile("INITIALIZE_VIDEO_PROOF", "SME_REQUIRED", Icons.videocam, () => _notify("LINKING_GEO_TAG_INTERFACE...")),
    _cmdTile("SUBMIT_ASSET_LOG", "WAPANUCKA_NODE", Icons.assignment, () => _notify("UPLOADING_SME_LOGS...")),
  ]);

  Widget _basePanel(String title, List<Widget> children) => Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 3)),
        const Divider(color: Colors.white10),
        const SizedBox(height: 20),
        ...children,
      ],
    ),
  );

  Widget _cmdTile(String l, String s, IconData i, VoidCallback a) => Card(
    color: const Color(0xFF0D0D0D),
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
      leading: Icon(i, color: const Color(0xFFC5A059)),
      title: Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
      subtitle: Text(s, style: const TextStyle(fontSize: 7, color: Colors.white24)),
      onTap: a,
    ),
  );
}
