import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - MASTER INTERLOCK V148.0
// REAL-TIME DATA CROSS-FLOW | ZERO-LATENCY COMMANDS
// CAGE: 1AHA8 | AUTHORIZED: J.D. HUMPHREY (CEO)
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
  runApp(const HVFNexusRealWork());
}

class HVFNexusRealWork extends StatelessWidget {
  const HVFNexusRealWork({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const OperationalNode(),
    );
  }
}

class OperationalNode extends StatefulWidget {
  const OperationalNode({super.key});
  @override
  State<OperationalNode> createState() => _OperationalNodeState();
}

class _OperationalNodeState extends State<OperationalNode> {
  // --- THE LIVE NODE STATE ---
  int _activeModule = 0; 
  double _stormChest = 2400000.00;
  int _activeInventory = 450;
  List<String> _commandLog = ["SYSTEM_READY: CAGE_1AHA8"];

  // --- CROSS-MODULE EXECUTION LOGIC ---
  void _executeTransaction(String lotId, double value) {
    setState(() {
      _activeInventory -= 50; // Inventory drops across all modules
      _stormChest += (value * 0.05); // Capital increases
      _commandLog.insert(0, "TRANSACTION: $lotId | LOGISTICS_DISPATCHED");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_COMMAND_ACTUAL", style: TextStyle(fontSize: 9, color: Color(0xFFC5A059))),
        actions: [Center(child: Text("CHEST: \$${_stormChest.toStringAsFixed(2)}  ", style: const TextStyle(color: Colors.greenAccent, fontSize: 8)))],
      ),
      body: Column(
        children: [
          _moduleSwitcher(),
          const Divider(color: Colors.white10, height: 1),
          Expanded(child: _buildActiveWorkSpace()),
          _commandTerminal(),
        ],
      ),
    );
  }

  Widget _moduleSwitcher() => Row(
    children: [
      _tab("OVERSEER", 0),
      _tab("BUYER", 1),
      _tab("PRODUCER", 2),
    ],
  );

  Widget _tab(String l, int i) => Expanded(
    child: InkWell(
      onTap: () => setState(() => _activeModule = i),
      child: Container(
        padding: const EdgeInsets.all(15),
        color: _activeModule == i ? const Color(0xFF0D0D0D) : Colors.black,
        child: Center(child: Text(l, style: TextStyle(fontSize: 8, color: _activeModule == i ? const Color(0xFFC5A059) : Colors.white24))),
      ),
    ),
  );

  Widget _buildActiveWorkSpace() {
    switch (_activeModule) {
      case 0: return _overseerWork();
      case 1: return _buyerWork();
      case 2: return _producerWork();
      default: return _overseerWork();
    }
  }

  // OVERSEER: Inventory and Utility Management
  Widget _overseerWork() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _workTile("CURRENT_INVENTORY", "$_activeInventory HEAD", Icons.inventory, () {}),
      _workTile("HELIO_GRID", "482 KW", Icons.bolt, () {}),
    ],
  );

  // BUYER: Market Execution
  Widget _buyerWork() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _workTile("ACQUIRE_LOT_A", "\$75,000", Icons.add_shopping_cart, () => _executeTransaction("LOT_A", 75000)),
      _workTile("ACQUIRE_LOT_B", "\$120,000", Icons.add_shopping_cart, () => _executeTransaction("LOT_B", 120000)),
    ],
  );

  // PRODUCER: Media and Compliance
  Widget _producerWork() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _workTile("UPLOAD_VIDEO_PROOF", "SME_VERIFICATION", Icons.videocam, () => setState(() => _commandLog.insert(0, "VIDEO_UPLOAD_INITIALIZED"))),
    ],
  );

  Widget _workTile(String t, String v, IconData i, VoidCallback a) => Card(
    color: const Color(0xFF0D0D0D),
    child: ListTile(
      leading: Icon(i, color: const Color(0xFFC5A059), size: 18),
      title: Text(t, style: const TextStyle(fontSize: 8)),
      trailing: Text(v, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.cyan)),
      onTap: a,
    ),
  );

  Widget _commandTerminal() => Container(
    height: 120, width: double.infinity, color: const Color(0xFF050505),
    padding: const EdgeInsets.all(10),
    child: ListView.builder(
      itemCount: _commandLog.length,
      itemBuilder: (context, i) => Text("> ${_commandLog[i]}", style: const TextStyle(fontSize: 7, color: Colors.white24)),
    ),
  );
}
