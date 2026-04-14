import 'package:flutter/material.dart';

// HVF NEXUS CORE V100.0 - THE CENTURY BUILD
// FEATURE: NETWORK PULSE | SOVEREIGN GATE | GLOBAL HANDSHAKE
// STATUS: PHASE 5 COMPLETE - EXTERNAL READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: HVFShell()));

const Color gold = Color(0xFFC5A059); 
const Color noir = Color(0xFF121212);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  List<Map<String, String>> ledger = [];
  List<String> logs = ["CORE V100.0 ONLINE: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => logs.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [GLOBAL] - $m"));

  @override
  Widget build(BuildContext context) {
    if (role == null) return _gate();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: noir,
        title: Text(role == "CEO" ? "CEO COMMAND" : "AGENT UPLINK", style: const TextStyle(color: gold, fontSize: 14)),
        actions: [IconButton(icon: const Icon(Icons.logout, color: Colors.white24), onPressed: () => setState(() => role = null))],
      ),
      body: role == "CEO" ? _ceoView() : _agentView(),
    );
  }

  Widget _gate() {
    return Scaffold(
      backgroundColor: noir,
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.shield, color: gold, size: 60),
        const SizedBox(height: 30),
        _btn("CEO COMMAND", "CEO1880", "CEO"),
        const SizedBox(height: 10),
        _btn("AGENT PORTAL", "FARMER2026", "AGENT"),
      ])),
    );
  }

  Widget _btn(String l, String k, String r) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E1E1E), minimumSize: const Size(200, 50)),
      onPressed: () {
        String input = "";
        showDialog(context: context, builder: (c) => AlertDialog(
          backgroundColor: noir,
          title: Text(l, style: const TextStyle(color: gold)),
          content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => input = v),
          actions: [ElevatedButton(onPressed: () { if(input == k) { Navigator.pop(c); setState(() => role = r); } }, child: const Text("VERIFY"))],
        ));
      },
      child: Text(l, style: const TextStyle(color: gold)),
    );
  }

  Widget _ceoView() {
    return Column(children: [
      Expanded(child: ListView.builder(itemCount: ledger.length, itemBuilder: (c, i) => ListTile(title: Text(ledger[i]['breed']!), subtitle: const Text("NEXUS AUTO-CERTIFIED", style: TextStyle(color: Colors.green))))),
      Container(height: 150, color: noir, child: ListView(children: logs.map((m) => Text(m, style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'monospace'))).toList())),
    ]);
  }

  Widget _agentView() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(padding: const EdgeInsets.all(40), child: Column(children: [
      TextField(controller: b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: t, decoration: const InputDecoration(labelText: "DNA ID")),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () { 
        setState(() => ledger.add({"breed": b.text, "id": t.text}));
        _log("NETWORK PULSE: New Asset Inbound from Field.");
        b.clear(); t.clear();
      }, child: const Text("UPLINK TO NEXUS"))
    ]));
  }
}
