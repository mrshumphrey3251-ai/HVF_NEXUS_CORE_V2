import 'package:flutter/material.dart';

// HVF NEXUS CORE - HARDENED PRODUCTION V1.4.6
// EMERGENCY RECOVERY BUILD | SME AUTHORIZED
// UEI: S1M4ENLHTDH5

void main() {
  runApp(const MaterialApp(
    home: HVFShell(),
    debugShowCheckedModeBanner: false,
  ));
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String activeRole = "GATE";
  String activeSector = "LIVESTOCK";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS :: $activeRole", 
          style: const TextStyle(color: Color(0xFFC5A059), fontSize: 14)),
        centerTitle: true,
      ),
      bottomNavigationBar: activeRole == "GATE" ? null : BottomAppBar(
        color: const Color(0xFF111111),
        child: TextButton.icon(
          onPressed: () => setState(() => activeRole = "GATE"),
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text("EXIT TO GATE", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: activeRole == "GATE" ? _buildGate() : _buildSectorDeck(),
    );
  }

  Widget _buildGate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 60),
      const SizedBox(height: 40),
      _gateBtn("CEO OVERSIGHT", "CEO"),
      _gateBtn("PRODUCER DECK", "PRODUCER"),
    ]));
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFC5A059), width: 2),
        minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => activeRole = r),
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ),
  );

  Widget _buildSectorDeck() {
    return Column(children: [
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET"),
      ]),
      const Spacer(),
      Text("SECTOR: $activeSector", 
        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      const Text("SYSTEMS OPERATIONAL", style: TextStyle(color: Colors.greenAccent, fontSize: 10)),
      const Spacer(),
    ]);
  }

  Widget _tab(String s) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ChoiceChip(
      label: Text(s), 
      selected: activeSector == s,
      onSelected: (b) => setState(() => activeSector = s),
      selectedColor: const Color(0xFFC5A059),
    ),
  );
}
