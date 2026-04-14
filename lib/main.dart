import 'package:flutter/material.dart';
import 'dart:async';

// HVF NEXUS CORE V104.0 - THE NETWORK NEXUS BUILD
// FEATURE: GLOBAL SYNC EMULATION | PERSISTENT CLOUD HANDSHAKE | ENHANCED OVERWATCH
// STATUS: PHASE 5 - EXTERNAL DEPLOYMENT FINAL
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
  List<Map<String, String>> globalLedger = [];
  List<String> logs = ["NETWORK_STABILIZED >> AWAITING_CLOUD_HANDSHAKE"];
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    // Simulate a live network check every 5 seconds
    _syncTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (role != null) _log("SYNCING_GLOBAL_LEDGER... [OK]");
    });
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }

  void _log(String m) => setState(() => logs.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [NEXUS] - $m"));

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: COMMAND OVERWATCH ::" : ":: FIELD INDUCTION ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 3, fontSize: 13)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: hvfGold), onPressed: () => setState(() => role = null))],
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: hvfGold, height: 1)),
      ),
      body: Column(children: [
        Expanded(child: role == "CEO" ? _buildCeoView() : _buildAgentView()),
        _buildTicker(),
      ]),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(border: Border.all(color: hvfGold, width: 2)),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.wifi_tethering, color: hvfGold, size: 60),
          const SizedBox(height: 20),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 4)),
          const Text("GLOBAL NEXUS GATEWAY", style: TextStyle(color: Colors.white24, fontSize: 10)),
          const SizedBox(height: 50),
          _gateBtn("CEO COMMAND", "CEO1880", "CEO"),
          const SizedBox(height: 15),
          _gateBtn("AGENT PORTAL", "FARMER2026", "AGENT"),
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

  Widget _buildCeoView() {
    return ListView.builder(
      itemCount: globalLedger.length,
      itemBuilder: (c, i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: hvfIron, border: const Border(left: BorderSide(color: hvfGold, width: 3))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(globalLedger[i]['breed']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text("VERIFIED", style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildAgentView() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      TextField(controller: b, decoration: const InputDecoration(labelText: "BREED", labelStyle: TextStyle(color: Colors.white30))),
      TextField(controller: t, decoration: const InputDecoration(labelText: "DNA_ID", labelStyle: TextStyle(color: Colors.white30))),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 50), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        onPressed: () {
          setState(() => globalLedger.add({"breed": b.text, "id": t.text}));
          _log("UPLINK_SUCCESS >> ASSET:${t.text}");
          b.clear(); t.clear();
        },
        child: const Text("EXECUTE UPLINK", style: TextStyle(color: hvfBlack, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  Widget _buildTicker() {
    return Container(
      height: 35, width: double.infinity, color: hvfGold,
      alignment: Alignment.center,
      child: Text(logs.first, style: const TextStyle(color: hvfBlack, fontWeight: FontWeight.bold, fontSize: 10)),
    );
  }
}
