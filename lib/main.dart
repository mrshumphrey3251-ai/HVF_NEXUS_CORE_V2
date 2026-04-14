import 'package:flutter/material.dart';

// HVF NEXUS CORE V103.0 - THE UNIFIED FLAGSHIP COMMAND
// FEATURE: FULL-SPECTRUM INTEGRATION | INDUSTRIAL LEDGER | LIVE TELEGRAPH
// STATUS: PHASE 5 COMPLETE - DEPLOYMENT READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() => runApp(const HVFApp());

const Color hvfGold = Color(0xFFC5A059); 
const Color hvfBlack = Color(0xFF0D0D0D);
const Color hvfIron = Color(0xFF1E1E1E);
const Color hvfSteel = Color(0xFF333333);

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
  List<Map<String, String>> ledger = [];
  List<String> pulseLog = ["SYSTEM_V103.0_ONLINE >> READY_FOR_COMMAND"];

  void _pushPulse(String m) => setState(() => pulseLog.insert(0, m.toUpperCase()));

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: COMMAND OVERWATCH ::" : ":: FIELD INDUCTION ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 4, fontWeight: FontWeight.bold, fontSize: 14)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: hvfGold), onPressed: () => setState(() => role = null))],
        bottom: PreferredSize(preferredSize: const Size.fromHeight(2), child: Container(color: hvfGold, height: 1)),
      ),
      body: Column(children: [
        Expanded(child: role == "CEO" ? _buildCeoDashboard() : _buildAgentPortal()),
        _buildTelegraphTicker(),
      ]),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(border: Border.all(color: hvfGold, width: 3)),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield, color: hvfGold, size: 70),
          const SizedBox(height: 20),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 4)),
          const Text("NEXUS SOVEREIGN GATE", style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2)),
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
      style: OutlinedButton.styleFrom(side: const BorderSide(color: hvfGold), minimumSize: const Size(280, 60), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      onPressed: () => _verifyGate(k, r),
      child: Text(l, style: const TextStyle(color: hvfGold, fontWeight: FontWeight.bold)),
    );
  }

  void _verifyGate(String k, String r) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: hvfIron,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      title: const Text("ENTER AUTHORITY KEY", style: TextStyle(color: hvfGold, fontSize: 12)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
      actions: [TextButton(onPressed: () { if(val == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("VERIFY", style: TextStyle(color: hvfGold)))],
    ));
  }

  Widget _buildCeoDashboard() {
    return ledger.isEmpty 
      ? const Center(child: Text("NO LIVE ASSETS IN NETWORK", style: TextStyle(color: Colors.white12)))
      : ListView.builder(
          itemCount: ledger.length,
          itemBuilder: (c, i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: hvfIron, border: const Border(left: BorderSide(color: hvfGold, width: 4))),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(ledger[i]['breed']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("DNA_TAG: ${ledger[i]['id']}", style: const TextStyle(color: hvfGold, fontSize: 10)),
              ]),
              const Icon(Icons.verified, color: hvfGold, size: 20),
            ]),
          ),
        );
  }

  Widget _buildAgentPortal() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(padding: const EdgeInsets.all(40), child: Column(children: [
      TextField(controller: b, decoration: const InputDecoration(labelText: "BREED", labelStyle: TextStyle(color: hvfGold))),
      const SizedBox(height: 20),
      TextField(controller: t, decoration: const InputDecoration(labelText: "DNA_ID", labelStyle: TextStyle(color: hvfGold))),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 60), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        onPressed: () {
          if (b.text.isNotEmpty && t.text.isNotEmpty) {
            setState(() => ledger.add({"breed": b.text, "id": t.text}));
            _pushPulse("UPLINK_SUCCESS >> ASSET_ID:${t.text}");
            b.clear(); t.clear();
          }
        },
        child: const Text("EXECUTE UPLINK", style: TextStyle(color: hvfBlack, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  Widget _buildTelegraphTicker() {
    return Container(
      height: 45, width: double.infinity, color: hvfGold,
      alignment: Alignment.center,
      child: Text(pulseLog.first, style: const TextStyle(color: hvfBlack, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.5)),
    );
  }
}
