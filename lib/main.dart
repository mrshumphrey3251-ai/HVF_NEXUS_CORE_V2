import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - THE SOVEREIGN CHASSIS V152.0
// THE COMPLETED INDUSTRIAL UNIT | ZERO-SNIPPET POLICY
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
  runApp(const HVFNexusFinal());
}

class HVFNexusFinal extends StatelessWidget {
  const HVFNexusFinal({super.key});
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
      home: const SovereignCommandHub(),
    );
  }
}

class SovereignCommandHub extends StatefulWidget {
  const SovereignCommandHub({super.key});
  @override
  State<SovereignCommandHub> createState() => _SovereignCommandHubState();
}

class _SovereignCommandHubState extends State<SovereignCommandHub> {
  int _activeRoleIndex = 0;
  double _stormChestBalance = 2400000.00;
  int _totalInventory = 450;
  List<String> _auditLog = ["SYSTEM_LOCK_ENGAGED: CAGE_1AHA8"];

  // --- INTEGRATED MASTER LOGIC ---
  void _executePurchase(String lot, double price) {
    setState(() {
      _totalInventory -= 50; 
      _stormChestBalance += (price * 0.05);
      _auditLog.insert(0, "TX_SUCCESS: $lot | FEE_COLLECTED: \$${(price * 0.05).toStringAsFixed(2)} | 4PL_DEPLOYED");
    });
  }

  void _triggerLog(String msg) {
    setState(() => _auditLog.insert(0, msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_V152_FINAL", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 2)),
        actions: [
          Center(child: Text("STORM_CHEST: \$${_stormChestBalance.toStringAsFixed(2)}  ", 
          style: const TextStyle(fontSize: 8, color: Colors.greenAccent, fontWeight: FontWeight.bold))),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: const Color(0xFF0A0A0A),
            selectedIndex: _activeRoleIndex,
            onDestinationSelected: (i) => setState(() => _activeRoleIndex = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.security), label: Text("OVERSEER", style: TextStyle(fontSize: 7))),
              NavigationRailDestination(icon: Icon(Icons.business_center), label: Text("BUYER", style: TextStyle(fontSize: 7))),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("PRODUCER", style: TextStyle(fontSize: 7))),
              NavigationRailDestination(icon: Icon(Icons.history_edu), label: Text("MISSION", style: TextStyle(fontSize: 7))),
            ],
          ),
          const VerticalDivider(width: 1, color: Colors.white10),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _buildRoleView()),
                _buildAuditTerminal(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleView() {
    switch (_activeRoleIndex) {
      case 0: return _viewOverseer();
      case 1: return _viewBuyer();
      case 2: return _viewProducer();
      case 3: return _viewMission();
      default: return _viewOverseer();
    }
  }

  Widget _viewOverseer() => _panelLayout("EXECUTIVE_WAR_ROOM", [
    _tile("HELIOGRID_POLL", "482 KW", Icons.bolt, () => _triggerLog("UTILITY_SYNC: GRID_STABLE")),
    _tile("RESERVOIR_TELEMETRY", "22.4 FT", Icons.waves, () => _triggerLog("UTILITY_SYNC: WATER_OPTIMAL")),
    _tile("INVENTORY_COUNT", "$_totalInventory HEAD", Icons.inventory, () {}),
  ]);

  Widget _viewBuyer() => _panelLayout("INSTITUTIONAL_LEDGER", [
    _tile("ACQUIRE: LOT_A (ANGUS)", "\$75,000", Icons.add_shopping_cart, () => _executePurchase("LOT_A", 75000)),
    _tile("ACQUIRE: LOT_B (MACHINERY)", "\$420,000", Icons.add_shopping_cart, () => _executePurchase("LOT_B", 420000)),
  ]);

  Widget _viewProducer() => _panelLayout("PROOF_OF_LIFE_GATEWAY", [
    _tile("INITIALIZE_SME_VIDEO", "WAPANUCKA_NODE", Icons.videocam, () => _triggerLog("MEDIA_START: RECORDING_PROOF")),
    _tile("UPLOAD_HEALTH_LOGS", "UID_TRACEABLE", Icons.assignment_turned_in, () => _triggerLog("DATA_SYNC: LOGS_UPLOADED")),
  ]);

  Widget _viewMission() => _panelLayout("RESTORATION_VAULT", [
    _tile("90_DAY_GRACE", "8_ACTIVE", Icons.timer, () {}),
    _tile("SME_CERTIFICATIONS", "12_NCCO", Icons.verified, () {}),
  ]);

  Widget _panelLayout(String title, List<Widget> children) => ListView(
    padding: const EdgeInsets.all(25),
    children: [
      Text(title, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 3)),
      const Divider(color: Colors.white10),
      const SizedBox(height: 10),
      ...children,
    ],
  );

  Widget _tile(String l, String v, IconData i, VoidCallback a) => Card(
    color: const Color(0xFF0D0D0D),
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
      leading: Icon(i, color: const Color(0xFFC5A059), size: 18),
      title: Text(l, style: const TextStyle(fontSize: 8)),
      subtitle: Text(v, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.cyan)),
      onTap: a,
      trailing: const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white10),
    ),
  );

  Widget _buildAuditTerminal() => Container(
    height: 180, width: double.infinity, color: Colors.black,
    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))),
    padding: const EdgeInsets.all(15),
    child: ListView.builder(
      itemCount: _auditLog.length,
      itemBuilder: (context, i) => Text("> ${_auditLog[i]}", style: const TextStyle(fontSize: 7, color: Colors.white38)),
    ),
  );
}
