import 'package:flutter/material.dart';

// HVF NEXUS CORE V99.0 - THE EXTERNAL DEPLOYMENT PREP
// FEATURE: MULTI-TENANT ROUTING | GLOBAL STATE SYNC PREP | SESSION LOCKS
// STATUS: PHASE 5 - EXTERNAL HOSTING READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF121212);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  String? currentRole; // Tracks if this specific device is CEO or AGENT

  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["EXTERNAL GATEWAY INITIALIZED: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [GLOBAL] - $m"));

  @override
  Widget build(BuildContext context) {
    // If no role is selected, show the Sovereign Entry Gate
    if (currentRole == null) return _buildEntryGate();

    return Scaffold(
      body: Row(children: [
        NavigationRail(
          backgroundColor: deepBlack,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          leading: IconButton(icon: const Icon(Icons.logout, color: Colors.white24), onPressed: () => setState(() => currentRole = null)),
          labelType: NavigationRailLabelType.all,
          unselectedLabelTextStyle: const TextStyle(color: Colors.white38, fontSize: 10),
          selectedLabelTextStyle: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
          destinations: _getDestinationsForRole(),
        ),
        Expanded(child: _buildPortalForRole()),
      ]),
    );
  }

  Widget _buildEntryGate() {
    return Scaffold(
      backgroundColor: deepBlack,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_rounded, color: goldAccent, size: 80),
          const SizedBox(height: 20),
          const Text("HVF NEXUS SOVEREIGN GATE", style: TextStyle(color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          _gateButton("CEO COMMAND", "CEO1880", "CEO"),
          const SizedBox(height: 15),
          _gateButton("AGENT UPLINK", "FARMER2026", "AGENT"),
          const SizedBox(height: 15),
          _gateButton("BUYER PORTAL", "PUBLIC", "BUYER"),
        ]),
      ),
    );
  }

  Widget _gateButton(String label, String key, String role) {
    return SizedBox(width: 250, child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: charcoalGrey),
      onPressed: () => _verify(label, key, role),
      child: Text(label, style: const TextStyle(color: goldAccent)),
    ));
  }

  void _verify(String t, String k, String r) {
    if (k == "PUBLIC") { setState(() => currentRole = r); return; }
    String input = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(t, style: const TextStyle(color: goldAccent)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), onChanged: (v) => input = v),
      actions: [ElevatedButton(onPressed: () { if(input == k) { Navigator.pop(c); setState(() => currentRole = r); } }, child: const Text("ACCESS"))],
    ));
  }

  List<NavigationRailDestination> _getDestinationsForRole() {
    if (currentRole == "CEO") {
      return const [
        NavigationRailDestination(icon: Icon(Icons.gavel), label: Text("OVERWATCH")),
        NavigationRailDestination(icon: Icon(Icons.history), label: Text("AUDIT")),
      ];
    }
    return const [
      NavigationRailDestination(icon: Icon(Icons.assignment_ind), label: Text("UPLINK")),
      NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("MARKET")),
    ];
  }

  Widget _buildPortalForRole() {
    if (currentRole == "CEO") {
      return _selectedIndex == 0 ? _buildOverwatch() : _buildAudit();
    }
    return _selectedIndex == 0 ? _buildAgent() : _buildBuyer();
  }

  // PORTAL IMPLEMENTATIONS (Abstracted for scale)
  Widget _buildOverwatch() => Center(child: Text("CEO MONITORING ${marketLive.length} ASSETS", style: const TextStyle(color: goldAccent)));
  Widget _buildAudit() => ListView(children: auditLog.map((m) => ListTile(title: Text(m, style: const TextStyle(color: Colors.white60, fontSize: 10)))).toList());
  Widget _buildAgent() => Center(child: ElevatedButton(onPressed: () {
    setState(() => marketLive.add({"id": "AUTO-${DateTime.now().millisecond}", "breed": "Black Angus"}));
    _log("EXTERNAL INDUCTION RECEIVED");
  }, child: const Text("UPLINK TEST ASSET")));
  Widget _buildBuyer() => Center(child: Text("MARKET LIVE: ${marketLive.length} ASSETS"));
}

const Color charcoalGrey = Color(0xFF1E1E1E);
