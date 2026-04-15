import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// =========================================================
// HVF NEXUS OS - THE FUSION CORE V136.0
// THE "SINGLE UNIT" ARCHITECTURE
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
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const UnifiedSovereignCockpit(),
    );
  }
}

class UnifiedSovereignCockpit extends StatelessWidget {
  const UnifiedSovereignCockpit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_UNIFIED_COMMAND", style: TextStyle(fontSize: 8, color: Color(0xFFC5A059), letterSpacing: 4)),
        actions: const [
          Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan, fontWeight: FontWeight.bold))),
        ],
      ),
      body: Row(
        children: [
          // LEFT AXIS: THE MACHINE (LOGISTICS & UTILITIES)
          _sidePanel("MACHINE", [
            _dataPoint("RESERVOIR", "22.4 FT", Colors.blueAccent),
            _dataPoint("HELIO_GRID", "482 KW", Colors.orangeAccent),
            _dataPoint("FLEET_ACTIVE", "12 UNITS", Colors.greenAccent),
          ]),
          
          // CENTER AXIS: THE EXCHANGE & COMMAND STREAM
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _interlockHeader(),
                Expanded(child: _commandStream()),
                _actionQuickKeys(),
              ],
            ),
          ),

          // RIGHT AXIS: THE MISSION (RESTORATION & CAPITAL)
          _sidePanel("MISSION", [
            _dataPoint("SSI_MIL_ADV", "ACTIVE", Colors.cyan),
            _dataPoint("90_DAY_GRACE", "14 USERS", Colors.white24),
            _dataPoint("STORM_CHEST", "\$2.4M", Color(0xFFC5A059)),
          ]),
        ],
      ),
    );
  }

  Widget _sidePanel(String title, List<Widget> items) => Container(
    width: 200,
    decoration: const BoxDecoration(color: Color(0xFF0A0A0A), border: Border.symmetric(vertical: BorderSide(color: Colors.white10, width: 0.5))),
    child: Column(
      children: [
        Padding(padding: const EdgeInsets.all(15), child: Text(title, style: const TextStyle(fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold))),
        const Divider(color: Color(0xFFC5A059), thickness: 0.5),
        ...items
      ],
    ),
  );

  Widget _dataPoint(String l, String v, Color c) => Padding(
    padding: const EdgeInsets.all(15),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: TextStyle(fontSize: 7, color: c)),
      Text(v, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _interlockHeader() => Container(
    padding: const EdgeInsets.all(20),
    color: const Color(0xFF0D0D0D),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _stat("BUYER_LIQUIDITY", "HIGH", Colors.greenAccent),
        _stat("SELLER_INVENTORY", "450 HEAD", Colors.cyan),
        _stat("OVERSEER_STATUS", "SECURE", Color(0xFFC5A059)),
      ],
    ),
  );

  Widget _stat(String l, String v, Color c) => Column(children: [
    Text(l, style: const TextStyle(fontSize: 7, color: Colors.white24)),
    Text(v, style: TextStyle(fontSize: 10, color: c, fontWeight: FontWeight.bold)),
  ]);

  Widget _commandStream() => Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
    child: ListView(
      children: [
        _streamItem("SYSTEM", "CAGE 1AHA8 FEDERAL HANDSHAKE COMPLETE", Colors.cyan),
        _streamItem("EXCHANGE", "INSTITUTIONAL BUYER ACQUIRED LOT #772", Color(0xFFC5A059)),
        _streamItem("LOGISTICS", "MANIFEST GEN: NCCO DRIVER ASSIGNED", Colors.greenAccent),
        _streamItem("RESTORATION", "VETERAN ID: 094 COMPLETED NCCER", Colors.orangeAccent),
      ],
    ),
  );

  Widget _streamItem(String type, String msg, Color c) => ListTile(
    leading: Text(type, style: TextStyle(color: c, fontSize: 8, fontWeight: FontWeight.bold)),
    title: Text(msg, style: const TextStyle(fontSize: 8, color: Colors.white70)),
  );

  Widget _actionQuickKeys() => Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _qKey("INIT_EXCHANGE"),
        const SizedBox(width: 10),
        _qKey("VET_PARTNER"),
        const SizedBox(width: 10),
        _qKey("FLEET_DEPLOY"),
      ],
    ),
  );

  Widget _qKey(String l) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(border: Border.all(color: const Color(0xFFC5A059))),
    child: Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
  );
}
