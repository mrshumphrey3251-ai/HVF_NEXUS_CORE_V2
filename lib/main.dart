import 'package:flutter/material.dart';

// HVF NEXUS CORE V94.0 - ASSET INTEGRITY BUILD
// FEATURE: HEALTH METRIC LOGGING | LIVE WEIGHT VERIFICATION | AUDIT ENHANCEMENT
// STATUS: PHASE 3 - ASSET HARDENING
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF121212);
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

  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["INTEGRITY ENGINE ONLINE: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [LOG] - $m"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          backgroundColor: deepBlack,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) {
             if (i == 1 && !_isAgentAuth) {
               _gate("AGENT ACCESS", "FARMER2026", () { setState(() { _isAgentAuth = true; _selectedIndex = 1; }); });
             } else if (i == 2 && !_isCeoAuth) {
               _gate("CEO COMMAND", "CEO1880", () { setState(() { _isCeoAuth = true; _selectedIndex = 2; }); });
             } else {
               setState(() => _selectedIndex = i);
             }
          },
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
        Expanded(child: _buildPortal()),
      ]),
    );
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

  Widget _buildPortal() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w900)));
      case 1: return AgentPortal(onSync: (d) {
        setState(() => pendingQueue.add(d));
        _log("INDUCTION: Tag ${d['id']} (${d['weight']} lbs) Uploaded.");
      });
      case 2: return CEOPortal(queue: pendingQueue, audit: auditLog, onAction: (it, app, pr) {
        setState(() { 
          pendingQueue.remove(it); 
          if (app) marketLive.add({...it, "price": pr, "verified": "TRUE"});
        });
        _log(app ? "CERTIFIED: Asset ${it['id']} Verified for Market." : "REJECTED: Asset ${it['id']} Failed Integrity.");
      });
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (it) {
        setState(() { marketLive.remove(it); ownerVault.add(it); });
        _log("SETTLEMENT: Asset ${it['id']} Ownership Transferred.");
      });
      default: return const SizedBox();
    }
  }
}

class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  final _b = TextEditingController(); final _t = TextEditingController(); final _w = TextEditingController(); final _h = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: warmBeige, body: Padding(padding: const EdgeInsets.all(40), child: SingleChildScrollView(child: Column(children: [
      const Text("ASSET INTEGRITY FORM", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
      TextField(controller: _b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: _t, decoration: const InputDecoration(labelText: "DNA ID")),
      TextField(controller: _w, decoration: const InputDecoration(labelText: "WEIGHT (LBS)")),
      TextField(controller: _h, decoration: const InputDecoration(labelText: "LAST VET DATE")),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: deepBlack), onPressed: () { 
        if(_t.text.isNotEmpty) onSync({"id": _t.text, "breed": _b.text, "weight": _w.text, "vet": _h.text}); 
        _t.clear(); _b.clear(); _w.clear(); _h.clear();
      }, child: const Text("UPLINK TO COMMAND", style: TextStyle(color: goldAccent)))
    ]))));
  }
}

class CEOPortal extends StatelessWidget {
  final List<Map<String, String>> queue;
  final List<String> audit;
  final Function(Map<String, String>, bool, String) onAction;
  const CEOPortal({super.key, required this.queue, required this.audit, required this.onAction});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(backgroundColor: Colors.grey[900], appBar: AppBar(backgroundColor: deepBlack, bottom: const TabBar(tabs: [Tab(text: "ASSET QUEUE"), Tab(text: "AUDIT LOG")])), body: TabBarView(children: [
      ListView.builder(itemCount: queue.length, itemBuilder: (c, i) => Card(color: deepBlack, child: Column(children: [
        ListTile(title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white)), subtitle: Text("TAG: ${queue[i]['id']} | ${queue[i]['weight']} LBS", style: const TextStyle(color: goldAccent))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text("HEALTH STATUS: ${queue[i]['vet']}", style: const TextStyle(color: Colors.white54, fontSize: 10))),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(onPressed: () => onAction(queue[i], false, ""), child: const Text("REJECT", style: TextStyle(color: Colors.red))),
          ElevatedButton(onPressed: () => onAction(queue[i], true, "\$2,850"), child: const Text("CERTIFY"))
        ])
      ]))),
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
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(bottom: const TabBar(tabs: [Tab(text: "MARKET"), Tab(text: "OWNED")])), body: TabBarView(children: [
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), subtitle: Text("${market[i]['weight']} LBS | CERTIFIED"), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: Text("BUY ${market[i]['price']}")))),
      ListView.builder(itemCount: vault.length, itemBuilder: (c, i) => ListTile(title: Text(vault[i]['breed']!), subtitle: const Text("RECORD SECURED"))),
    ])));
  }
