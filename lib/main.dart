import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - INSTITUTIONAL LEDGER V146.0
// BULK LOT BIDDING | CONTRACTUAL UNDERWRITING
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5
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
  int _viewIndex = 1; // Default to BUYER for this phase
  double _stormChestBalance = 2400000.00;

  // --- OPTION C: INSTITUTIONAL EXECUTION ---
  Future<void> _executeBulkPurchase(String lotId, double totalValue) async {
    // This executes the Humphrey Standard for bulk acquisition
    setState(() {
      _stormChestBalance += (totalValue * 0.05); // 5% SME Underwriting Fee
    });
    _notify("BULK_PURCHASE_COMPLETE: LOT_$lotId | CONTRACT_GENERATED_CAGE_1AHA8");
  }

  void _notify(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF0D0D0D),
      content: Text(msg, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_INSTITUTIONAL_LEDGER", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059))),
        actions: [
          Center(child: Text("CHEST: \$${_stormChestBalance.toStringAsFixed(2)}  ", 
          style: const TextStyle(fontSize: 8, color: Colors.greenAccent, fontWeight: FontWeight.bold))),
        ],
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
              NavigationRailDestination(icon: Icon(Icons.business_center), label: Text("LEDGER")),
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
    if (_viewIndex == 1) return _institutionalLedger();
    return _producer();
  }

  // 1. OVERSEER (RETAINED GROUND)
  Widget _overseer() => _layout("EXECUTIVE_WAR_ROOM", [
    _dataTile("HELIOGRID_STAT", "482 KW", Icons.bolt),
    _dataTile("RESERVOIR_DEPTH", "22.4 FT", Icons.waves),
  ]);

  // 2. INSTITUTIONAL LEDGER (THE NEW POWER)
  Widget _institutionalLedger() => _layout("BULK_ASSET_ACQUISITION", [
    _bulkLotCard("LOT_882: 50_ANGUS_MIX", "VALUE: \$75,000", 75000),
    _bulkLotCard("LOT_441: 5_CAT_EXCAVATORS", "VALUE: \$420,000", 420000),
    _bulkLotCard("LOT_109: VINEYARD_EQUIP_PKG", "VALUE: \$12,500", 12500),
  ]);

  // 3. PRODUCER (RETAINED GROUND)
  Widget _producer() => _layout("PROOF_OF_LIFE_VAULT", [
    const Text("SME VIDEO UPLOAD ACTIVE", style: TextStyle(fontSize: 9, color: Colors.cyan)),
    const SizedBox(height: 20),
    ElevatedButton(onPressed: () => _notify("INITIALIZING_SME_CAMERA..."), child: const Text("START_UPLOAD")),
  ]);

  Widget _layout(String title, List<Widget> children) => Padding(
    padding: const EdgeInsets.all(30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2)),
      const Divider(color: Colors.white10),
      const SizedBox(height: 20),
      Expanded(child: ListView(children: children)),
    ]),
  );

  Widget _bulkLotCard(String title, String val, double price) => Card(
    color: const Color(0xFF0D0D0D),
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
      title: Text(title, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
      subtitle: Text(val, style: const TextStyle(fontSize: 10, color: Colors.greenAccent)),
      trailing: ElevatedButton(
        onPressed: () => _executeBulkPurchase(title.split(":")[0], price),
        child: const Text("ACQUIRE_LOT", style: TextStyle(fontSize: 7)),
      ),
    ),
  );

  Widget _dataTile(String l, String v, IconData i) => ListTile(
    leading: Icon(i, color: const Color(0xFFC5A059)),
    title: Text(l, style: const TextStyle(fontSize: 8)),
    trailing: Text(v, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
  );
}
