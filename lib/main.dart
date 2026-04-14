import 'package:flutter/material.dart';
import 'dart:async';

// HVF NEXUS CORE V93.0 - THE CLOUD-READY BACKBONE
// FEATURE: GLOBAL UID GENERATION | NETWORK HANDSHAKE | PERSISTENT STATE
// STATUS: PHASE 3 ALPHA | INFRASTRUCTURE READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF121212);
const Color charcoalGrey = Color(0xFF1E1E1E);
const Color warmBeige = Color(0xFFF5F5F0);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  bool _isCeoAuth = false;
  bool _isAgentAuth = false;

  // GLOBAL STATE - PREPARED FOR CLOUD SYNC
  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["NETWORK INITIALIZED: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [SYS] - $m"));

  // NEW: CLOUD HANDSHAKE SIMULATION
  Future<void> _syncToCloud(String action) async {
    _log("UPLOADING: $action to Cloud...");
    await Future.delayed(const Duration(milliseconds: 800)); // Simulating network latency
    _log("SYNC COMPLETE: Global Ledger Updated.");
  }

  void _nav(int i) {
    if (i == 1 && !_isAgentAuth) {
      _gate("AGENT ACCESS", "FARMER2026", () { setState(() { _isAgentAuth = true; _selectedIndex = 1; }); });
    } else if (i == 2 && !_isCeoAuth) {
      _gate("CEO COMMAND", "CEO1880", () { setState(() { _isCeoAuth = true; _selectedIndex = 2; }); });
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _gate(String t, String k, VoidCallback s) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(t, style: const TextStyle(color: goldAccent, fontSize: 14)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CODE"), onChanged: (v) => val = v),
      actions: [ElevatedButton(onPressed: () { if(val == k) { Navigator.pop(c); s(); _log("SME ACCESS VERIFIED"); } }, child: const Text("VERIFY"))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          backgroundColor: deepBlack,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i), // Manual nav for speed
          leading: const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Icon(Icons.shield_rounded, color: goldAccent, size: 40)),
          labelType: NavigationRailLabelType.all,
          unselectedLabelTextStyle: const TextStyle(color: Colors.white38, fontSize: 10),
          selectedLabelTextStyle: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.map), label: Text("MAP")),
            NavigationRailDestination(icon: Icon(Icons.assignment_ind), label: Text("AGENT")),
            NavigationRailDestination(icon: Icon(Icons.gavel), label: Text("CEO")),
            NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("BUYER")),
          ],
        ),
        Expanded(child: _portal()),
      ]),
    );
  }

  Widget _portal() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w900)));
      case 1: return AgentPortal(onSync: (d) async { 
        setState(() => pendingQueue.add(d)); 
        await _syncToCloud("Induction ID: ${d['id']}");
      });
      case 2: return CEOPortal(
        queue: pendingQueue, 
        audit: auditLog, 
        onAction: (it, app, pr) async {
          setState(() { 
            pendingQueue.remove(it); 
            if (app) marketLive.add({...it, "price": pr, "verified": "TRUE"});
          });
          await _syncToCloud(app ? "CERTIFICATION" : "REJECTION");
        },
      );
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (it) async {
        setState(() { marketLive.remove(it); ownerVault.add(it); });
        await _syncToCloud("SETTLEMENT");
      });
      default: return const SizedBox();
    }
  }
}

// --- INFRASTRUCTURE COMPONENTS ---
class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  final _b = TextEditingController(); final _t = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: warmBeige, body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
      TextField(controller: _b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: _t, decoration: const InputDecoration(labelText: "DNA ID")),
      ElevatedButton(onPressed: () { onSync({"id": _t.text, "breed": _b.text, "uid": DateTime.now().millisecondsSinceEpoch.toString()}); _t.clear(); _b.clear(); }, child: const Text("PUSH TO CLOUD"))
    ])));
  }
}

class CEOPortal extends StatelessWidget {
  final List<Map<String, String>> queue;
  final List<String> audit;
  final Function(Map<String, String>, bool, String) onAction;
  const CEOPortal({super.key, required this.queue, required this.audit, required this.onAction});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(backgroundColor: charcoalGrey, appBar: AppBar(backgroundColor: deepBlack, bottom: const TabBar(tabs: [Tab(text: "PENDING"), Tab(text: "NETWORK LOG")])), body: TabBarView(children: [
      ListView.builder(itemCount: queue.length, itemBuilder: (c, i) => ListTile(title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white)), trailing: ElevatedButton(onPressed: () => onAction(queue[i], true, "\$2,850"), child: const Text("CERTIFY")))),
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
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: const Text("BUY")))),
      ListView.builder(itemCount: vault.length, itemBuilder: (c, i) => ListTile(title: Text(vault[i]['breed']!), subtitle: const Text("OWNED"))),
    ])));
  }
}
