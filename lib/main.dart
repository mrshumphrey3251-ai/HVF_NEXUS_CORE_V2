import 'package:flutter/material.dart';

// HVF NEXUS CORE V98.0 - THE AUTONOMOUS GOVERNOR
// FEATURE: AUTO-CERTIFICATION | AUTO-SETTLEMENT | CEO OVERRIDE COMMANDS
// STATUS: PHASE 4 - SCALABLE INFRASTRUCTURE
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
  
  // THE NEXUS AUTONOMOUS LEDGER
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["NEXUS AUTONOMY ACTIVE: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [AUTO-GOV] - $m"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          backgroundColor: deepBlack,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          leading: const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Icon(Icons.shield_rounded, color: goldAccent, size: 40)),
          labelType: NavigationRailLabelType.all,
          unselectedLabelTextStyle: const TextStyle(color: Colors.white38, fontSize: 10),
          selectedLabelTextStyle: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.map), label: Text("MAP")),
            NavigationRailDestination(icon: Icon(Icons.assignment_ind), label: Text("AGENT")),
            NavigationRailDestination(icon: Icon(Icons.gavel), label: Text("OVERWATCH")),
            NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("BUYER")),
          ],
        ),
        Expanded(child: _buildPortal()),
      ]),
    );
  }

  Widget _buildPortal() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w900)));
      case 1: return AgentPortal(onSync: (d) { 
        // AUTONOMOUS INDUCTION: The Nexus validates and pushes to market immediately.
        setState(() => marketLive.add({...d, "price": "\$2,850", "status": "AUTO-CERTIFIED"})); 
        _log("AUTO-CERTIFIED: Tag ${d['id']} bypassed manual queue via Nexus Logic.");
      });
      case 2: return CEOOverwatch(market: marketLive, audit: auditLog, onFreeze: (it) {
        setState(() { marketLive.remove(it); });
        _log("CEO INTERVENTION: Asset ${it['id']} FROZEN and removed from market.");
      });
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (it) {
        // AUTONOMOUS SETTLEMENT: Once 'funds' are confirmed, Nexus issues deed.
        setState(() { 
          marketLive.remove(it); 
          ownerVault.add({...it, "sig": "NEXUS-AUTO-SIG-${DateTime.now().millisecondsSinceEpoch}"}); 
        });
        _log("AUTO-SETTLEMENT: Deed issued for ${it['id']} via Secure Handshake.");
      });
      default: return const SizedBox();
    }
  }
}

class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  final _b = TextEditingController(); final _t = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
      const Text("AGENT UPLINK (AUTO-MODE)"),
      TextField(controller: _b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: _t, decoration: const InputDecoration(labelText: "DNA ID")),
      ElevatedButton(onPressed: () { onSync({"id": _t.text, "breed": _b.text}); _t.clear(); _b.clear(); }, child: const Text("UPLINK"))
    ])));
  }
}

class CEOOverwatch extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<String> audit;
  final Function(Map<String, String>) onFreeze;
  const CEOOverwatch({super.key, required this.market, required this.audit, required this.onFreeze});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(backgroundColor: const Color(0xFF1E1E1E), appBar: AppBar(backgroundColor: deepBlack, bottom: const TabBar(tabs: [Tab(text: "LIVE MARKET MONITOR"), Tab(text: "SYSTEM LOG")])), body: TabBarView(children: [
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(
        title: Text(market[i]['breed']!, style: const TextStyle(color: Colors.white)),
        subtitle: const Text("RUNNING UNDER AUTO-GOV", style: TextStyle(color: Colors.green, fontSize: 10)),
        trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]), onPressed: () => onFreeze(market[i]), child: const Text("FREEZE ASSET")),
      )),
      ListView.builder(itemCount: audit.length, itemBuilder: (c, i) => ListTile(title: Text(audit[i], style: const TextStyle(color: Colors.white60, fontSize: 10))))
    ])));
  }
}

class BuyerPortal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onBuy;
  const BuyerPortal({super.key, required this.market, required this.vault, required this.onBuy});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(bottom: const TabBar(tabs: [Tab(text: "MARKET"), Tab(text: "VAULT")])), body: TabBarView(children: [
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: const Text("PURCHASE")))),
      ListView.builder(itemCount: vault.length, itemBuilder: (c, i) => ListTile(title: Text(vault[i]['breed']!), subtitle: const Text("AUTO-DEED ISSUED"), leading: const Icon(Icons.auto_awesome, color: goldAccent))),
    ])));
  }
}
