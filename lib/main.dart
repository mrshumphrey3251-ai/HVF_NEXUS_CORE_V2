import 'package:flutter/material.dart';

// HVF NEXUS CORE V102.0 - THE IRON & INK BUILD
// FEATURE: STAMPED DATA ENTRIES | TELEGRAPH PULSE TICKER | INDUSTRIAL CONTRAST
// STATUS: PHASE 5 - EXTERNAL AESTHETIC HARDENING
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() => runApp(const HVFApp());

const Color hvfGold = Color(0xFFC5A059); 
const Color hvfBlack = Color(0xFF0D0D0D);
const Color hvfIron = Color(0xFF262626);
const Color hvfSteel = Color(0xFF404040);

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: hvfBlack,
        fontFamily: 'Courier', // Monospace for that historical telegraph feel
      ),
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
  List<String> pulseLog = ["SYSTEM STABILIZED... READY FOR UPLINK"];

  void _addPulse(String m) => setState(() => pulseLog.insert(0, m.toUpperCase()));

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        title: Text(role == "CEO" ? ":: CEO OVERWATCH ::" : ":: FIELD UPLINK ::", 
          style: const TextStyle(color: hvfGold, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(icon: const Icon(Icons.close, color: hvfGold), onPressed: () => setState(() => role = null))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: hvfGold, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: role == "CEO" ? _ceoView() : _agentView()),
          _buildTelegraphTicker(),
        ],
      ),
    );
  }

  Widget _buildGate() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: hvfGold, width: 4)),
        margin: const EdgeInsets.all(30),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.settings_input_component, color: hvfGold, size: 100),
            const SizedBox(height: 20),
            const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, letterSpacing: 4, fontSize: 24, fontWeight: FontWeight.w900)),
            const Text("SOVEREIGN NEXUS GATEWAY", style: TextStyle(color: Colors.white24, letterSpacing: 2, fontSize: 12)),
            const SizedBox(height: 60),
            _gateBtn("ESTABLISH COMMAND", "CEO1880", "CEO"),
            const SizedBox(height: 20),
            _gateBtn("FIELD OPERATIONS", "FARMER2026", "AGENT"),
          ]),
        ),
      ),
    );
  }

  Widget _gateBtn(String l, String k, String r) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: hvfGold, width: 2),
        minimumSize: const Size(300, 65),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () => _auth(k, r),
      child: Text(l, style: const TextStyle(color: hvfGold, fontWeight: FontWeight.bold)),
    );
  }

  void _auth(String k, String r) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: hvfIron,
      title: const Text("IDENTITY VERIFICATION", style: TextStyle(color: hvfGold)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => val = v),
      actions: [TextButton(onPressed: () { if(val == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("ACCESS", style: TextStyle(color: hvfGold)))],
    ));
  }

  Widget _ceoView() {
    return ListView.builder(
      itemCount: ledger.length,
      itemBuilder: (c, i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: hvfIron,
          border: const Border(left: BorderSide(color: hvfGold, width: 5)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(ledger[i]['breed']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text("LOG_ID: ${ledger[i]['id']}", style: const TextStyle(color: hvfGold, fontSize: 12)),
          const Align(alignment: Alignment.bottomRight, child: Icon(Icons.check_circle, color: hvfGold, size: 20)),
        ]),
      ),
    );
  }

  Widget _agentView() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(children: [
        TextField(controller: b, decoration: const InputDecoration(labelText: "BREED", labelStyle: TextStyle(color: hvfGold))),
        const SizedBox(height: 20),
        TextField(controller: t, decoration: const InputDecoration(labelText: "DNA_TAG", labelStyle: TextStyle(color: hvfGold))),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 60), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          onPressed: () {
            setState(() => ledger.add({"breed": b.text, "id": t.text}));
            _addPulse("ASSET INDUCTED: ${b.text}");
            b.clear(); t.clear();
          },
          child: const Text("STAMP & UPLINK", style: TextStyle(color: hvfBlack, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }

  Widget _buildTelegraphTicker() {
    return Container(
      height: 40,
      width: double.infinity,
      color: hvfGold,
      alignment: Alignment.center,
      child: Text(
        pulseLog.first,
        style: const TextStyle(color: hvfBlack, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2),
      ),
    );
  }
}
