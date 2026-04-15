import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// =========================================================
// HVF NEXUS - INDUSTRIAL MVP V156.0 
// MISSION: FAMILY SURVIVAL | BASELINE FUNCTIONAL
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO)
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
  runApp(const HVFMVP());
}

class HVFMVP extends StatelessWidget {
  const HVFMVP({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const BaselineCommand(),
    );
  }
}

class BaselineCommand extends StatefulWidget {
  const BaselineCommand({super.key});
  @override
  State<BaselineCommand> createState() => _BaselineCommandState();
}

class _BaselineCommandState extends State<BaselineCommand> {
  double _balance = 0.00;
  int _inventory = 450;
  List<String> _logs = ["SYSTEM_READY: CAGE_1AHA8"];

  void _processSale(String item, double price) {
    setState(() {
      _inventory -= 50;
      _balance += (price * 0.05); // Your 5% SME Fee
      _logs.insert(0, "SOLD: $item | REVENUE_LOCK: \$${(price * 0.05).toStringAsFixed(2)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text("HVF_NEXUS_BASELINE", style: TextStyle(fontSize: 10, color: Color(0xFFC5A059))),
        actions: [Center(child: Text("FEE_EARNED: \$${_balance.toStringAsFixed(2)}  ", style: const TextStyle(color: Colors.greenAccent, fontSize: 10)))],
      ),
      body: Column(
        children: [
          // THE OVERSEER VIEW (Simplified)
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _stat("INV_COUNT", "$_inventory"),
                _stat("GRID", "482KW"),
                _stat("SME", "ACTIVE"),
              ],
            ),
          ),
          const Divider(color: Colors.white10),
          // THE EXCHANGE (Simplified)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                _saleCard("LOT_A: 50 HEAD", "\$75,000", () => _processSale("LOT_A", 75000)),
                _saleCard("LOT_B: EQUIPMENT", "\$120,000", () => _processSale("LOT_B", 120000)),
              ],
            ),
          ),
          // THE AUDIT TRAIL
          Container(
            height: 100, width: double.infinity, color: const Color(0xFF050505),
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, i) => Text("> ${_logs[i]}", style: const TextStyle(fontSize: 8, color: Colors.white24)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String l, String v) => Column(children: [
    Text(l, style: const TextStyle(fontSize: 8, color: Colors.white38)),
    Text(v, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyan)),
  ]);

  Widget _saleCard(String t, String p, VoidCallback a) => Card(
    color: const Color(0xFF111111),
    child: ListTile(
      title: Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      subtitle: Text("VALUE: $p", style: const TextStyle(fontSize: 9, color: Colors.greenAccent)),
      trailing: ElevatedButton(onPressed: a, child: const Text("EXECUTE")),
    ),
  );
}
