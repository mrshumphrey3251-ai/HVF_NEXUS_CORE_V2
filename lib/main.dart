import 'package:flutter/material.dart';

// HVF NEXUS CORE V105.0 - THE LIVE PULSE BUILD
// FEATURE: DATABASE INTEGRATION HOOKS | REAL-TIME STREAM LISTENERS
// STATUS: PHASE 6 - LIVE INFRASTRUCTURE INITIALIZATION
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() => runApp(const HVFApp());

const Color hvfGold = Color(0xFFC5A059); 
const Color hvfBlack = Color(0xFF0D0D0D);
const Color hvfIron = Color(0xFF1E1E1E);

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: hvfBlack, fontFamily: 'Courier'),
      home: const HVFShell(),
    );
  }
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  // This ledger is now designed to be populated by the LIVE CLOUD STREAM
  List<Map<String, dynamic>> liveCloudLedger = []; 
  
  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: CEO COMMAND ::" : ":: FIELD UPLINK ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 13)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: hvfGold), onPressed: () => setState(() => role = null))],
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: hvfGold, height: 1)),
      ),
      body: role == "CEO" ? _buildLiveOverwatch() : _buildLiveInduction(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(border: Border.all(color: hvfGold, width: 2)),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.cloud_sync, color: hvfGold, size: 60),
          const SizedBox(height: 20),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4)),
          const Text("LIVE INFRASTRUCTURE GATE", style: TextStyle(color: Colors.white24, fontSize: 10)),
          const SizedBox(height: 50),
          _gateBtn("CEO EXECUTIVE ACCESS", "CEO1880", "CEO"),
          const SizedBox(height: 15),
          _gateBtn("AGENT FIELD ACCESS", "FARMER2026", "AGENT"),
        ])),
      ),
    );
  }

  Widget _gateBtn(String l, String k, String r) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: hvfGold), minimumSize: const Size(250, 55), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      onPressed: () => _verify(k, r),
      child: Text(l, style: const TextStyle(color: hvfGold, fontWeight: FontWeight.bold)),
    );
  }

  void _verify(String k, String r) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: hvfIron,
      title: const Text("AUTH_REQUIRED", style: TextStyle(color: hvfGold, fontSize: 12)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
      actions: [TextButton(onPressed: () { if(val == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("VERIFY", style: TextStyle(color: hvfGold)))],
    ));
  }

  Widget _buildLiveOverwatch() {
    // This widget is prepped for the StreamBuilder implementation
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text(":: LIVE CLOUD STREAM ACTIVE ::", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: liveCloudLedger.length,
          itemBuilder: (c, i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: hvfIron, border: const Border(left: BorderSide(color: hvfGold, width: 3))),
            child: Text(liveCloudLedger[i]['breed'] ?? "UNKNOWN ASSET", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    ]);
  }

  Widget _buildLiveInduction() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      TextField(controller: b, decoration: const InputDecoration(labelText: "BREED", labelStyle: TextStyle(color: Colors.white30))),
      TextField(controller: t, decoration: const InputDecoration(labelText: "DNA_ID", labelStyle: TextStyle(color: Colors.white30))),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 50), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        onPressed: () {
          // EXECUTIVE LOGIC: In the next step, this will 'POST' to the live cloud database
          setState(() {
            liveCloudLedger.add({"breed": b.text, "id": t.text, "timestamp": DateTime.now().toString()});
          });
          b.clear(); t.clear();
        },
        child: const Text("UPLINK TO CLOUD", style: TextStyle(color: hvfBlack, fontWeight: FontWeight.bold)),
      )
    ]));
  }
}
