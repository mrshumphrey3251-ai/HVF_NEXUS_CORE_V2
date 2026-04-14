import 'package:flutter/material.dart';

// HVF NEXUS CORE V101.0 - THE FLAGSHIP AESTHETIC BUILD
// THEME: 1880s INDUSTRIAL MINING TOWN | EXECUTIVE AUTHORITY
// STATUS: PHASE 5 - EXTERNAL VISUAL HARDENING
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() => runApp(const HVFApp());

const Color hvfGold = Color(0xFFC5A059); 
const Color hvfBlack = Color(0xFF0D0D0D);
const Color hvfIron = Color(0xFF262626);
const Color hvfPaper = Color(0xFFE8E4D9);

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: hvfBlack,
        fontFamily: 'Georgia', // Using standard serif for that vintage feel
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

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hvfBlack,
        elevation: 0,
        centerTitle: true,
        title: Text(role == "CEO" ? "CEO COMMAND DESK" : "AGENT FIELD UPLINK", 
          style: const TextStyle(color: hvfGold, letterSpacing: 4, fontWeight: FontWeight.bold, fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.redAccent), 
            onPressed: () => setState(() => role = null)
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: hvfGold.withOpacity(0.3), height: 1.0),
        ),
      ),
      body: role == "CEO" ? _ceoView() : _agentView(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: hvfGold, width: 2),
          color: hvfBlack,
        ),
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.account_balance, color: hvfGold, size: 80),
            const SizedBox(height: 20),
            const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: hvfGold, letterSpacing: 5, fontSize: 22, fontWeight: FontWeight.w900)),
            const Text("EST. 2026 | JOHNSTON COUNTY", style: TextStyle(color: Colors.white38, letterSpacing: 2, fontSize: 10)),
            const SizedBox(height: 60),
            _gateBtn("EXECUTIVE ACCESS", "CEO1880", "CEO"),
            const SizedBox(height: 20),
            _gateBtn("FIELD AGENT ACCESS", "FARMER2026", "AGENT"),
          ]),
        ),
      ),
    );
  }

  Widget _gateBtn(String label, String key, String r) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: hvfGold),
        minimumSize: const Size(280, 60),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () => _verify(key, r),
      child: Text(label, style: const TextStyle(color: hvfGold, letterSpacing: 2)),
    );
  }

  void _verify(String k, String r) {
    String input = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: hvfIron,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      title: const Text("ENTER AUTHORITY CODE", style: TextStyle(color: hvfGold, fontSize: 12)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => input = v),
      actions: [
        TextButton(onPressed: () { if(input == k) { Navigator.pop(c); setState(() => role = r); } }, 
        child: const Text("VERIFY", style: TextStyle(color: hvfGold)))
      ],
    ));
  }

  Widget _ceoView() {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: ledger.length,
          itemBuilder: (c, i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(border: Border.all(color: hvfGold.withOpacity(0.5))),
            child: ListTile(
              tileColor: hvfIron,
              title: Text(ledger[i]['breed']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("ID: ${ledger[i]['id']} | STATUS: ACTIVE", style: const TextStyle(color: hvfGold, fontSize: 10)),
              trailing: const Icon(Icons.verified, color: Colors.green, size: 16),
            ),
          ),
        ),
      ),
      _footer("MONITORING LIVE NETWORK...")
    ]);
  }

  Widget _agentView() {
    final b = TextEditingController(); final t = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("ASSET DATA INDUCTION", style: TextStyle(color: hvfGold, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        _field(b, "BREED / CLASSIFICATION"),
        const SizedBox(height: 20),
        _field(t, "DNA TAG IDENTIFICATION"),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: hvfGold, minimumSize: const Size(double.infinity, 50), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          onPressed: () {
            setState(() => ledger.add({"breed": b.text, "id": t.text}));
            b.clear(); t.clear();
          },
          child: const Text("COMMENCE UPLINK", style: TextStyle(color: hvfBlack, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }

  Widget _field(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.white30, fontSize: 12),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: hvfGold)),
      ),
    );
  }

  Widget _footer(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: hvfIron,
      child: Text(text, style: const TextStyle(color: hvfGold, fontSize: 9, letterSpacing: 1), textAlign: TextAlign.center),
    );
  }
}
