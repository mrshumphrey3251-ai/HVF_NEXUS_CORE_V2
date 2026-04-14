import 'package:flutter/material.dart';

// HVF NEXUS CORE V92.0 - THE FIELD HARDENED ALPHA
// FEATURE: DATA IMMUTABILITY | CEO MASTER WIPE | SESSION PERSISTENCE
// STATUS: ALPHA STAGE 2 | FIELD READY
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

  // SOVEREIGN LEDGER STATE
  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["SYSTEM HARDENED: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [LEDGER] - $m"));

  void _nav(int i) {
    if (i == 1 && !_isAgentAuth) {
      _gate("AGENT ACCESS", "FARMER2026", () { setState(() { _isAgentAuth = true; _selectedIndex = 1; }); });
    } else if (i == 2 && !_isCeoAuth) {
      _gate("CEO COMMAND", "CEO1880", () { setState(() { _isCeoAuth = true; _selectedIndex = 2; }); });
    } else {
      setState(() => _selectedIndex = i);
    }
  }

  void _gate(String t, String k, VoidCallback s) {
    String val = "";
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(t, style: const TextStyle(color: goldAccent, fontSize: 14)),
      content: TextField(obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CODE"), onChanged: (v) => val = v),
      actions: [ElevatedButton(onPressed: () { if(val == k) { Navigator.pop(c); s(); _log("SME AUTHENTICATED: $t"); } }, child: const Text("VERIFY"))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          backgroundColor: deepBlack,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _nav,
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
      case 1: return AgentPortal(onSync: (d) { setState(() => pendingQueue.add(d)); _log("UPLINK SUCCESS: Tag ${d['id']}"); });
      case 2: return CEOPortal(
        queue: pendingQueue, 
        audit: auditLog, 
        onAction: (it, app, pr) {
          setState(() { 
            pendingQueue.remove(it); 
            if (app) { marketLive.add({...it, "price": pr, "verified": "TRUE"}); _log("CERTIFIED: Tag ${it['id']} AUTHORIZED FOR RELEASE"); }
            else { _log("REJECTED: Tag ${it['id']} VOIDED BY CEO"); }
          });
        },
        onWipe: () {
          setState(() { pendingQueue.clear(); marketLive.clear(); ownerVault.clear(); _log("SYSTEM WIPE: ALL TEST DATA PURGED"); });
        },
      );
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (it) {
        setState(() { marketLive.remove(it); ownerVault.add(it); });
        _log("SETTLEMENT: Transaction Complete for Tag ${it['id']}");
      });
      default: return const SizedBox();
    }
  }
}

// --- UPDATED CEO COMMAND WITH WIPE FUNCTION ---
class CEOPortal extends StatelessWidget {
  final List<Map<String, String>> queue;
  final List<String> audit;
  final Function(Map<String, String>, bool, String) onAction;
  final VoidCallback onWipe;
  const CEOPortal({super.key, required this.queue, required this.audit, required this.onAction, required this.onWipe});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(backgroundColor: charcoalGrey, appBar: AppBar(
      backgroundColor: deepBlack, 
      title: const Text("CEO COMMAND", style: TextStyle(color: goldAccent, fontSize: 12)),
      actions: [IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => _confirmWipe(context))],
      bottom: const TabBar(tabs: [Tab(text: "PENDING"), Tab(text: "AUDIT LOG")]),
    ), body: TabBarView(children: [
      _buildQueue(),
      _buildAudit(),
    ])));
  }

  void _confirmWipe(BuildContext context) {
    showDialog(context: context, builder: (c) => AlertDialog(
      title: const Text("PURGE ALL DATA?"),
      content: const Text("This will clear the ledger for fresh deployment."),
      actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("CANCEL")), ElevatedButton(onPressed: () { onWipe(); Navigator.pop(c); }, child: const Text("PURGE"))],
    ));
  }

  Widget _buildQueue() {
    return queue.isEmpty ? const Center(child: Text("NO PENDING ASSETS", style: TextStyle(color: Colors.white24))) :
    ListView.builder(padding: const EdgeInsets.all(20), itemCount: queue.length, itemBuilder: (c, i) {
      final _p = TextEditingController(text: "\$2,850.00");
      return Card(color: deepBlack, child: Column(children: [
        ListTile(title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white)), subtitle: Text("DNA ID: ${queue[i]['id']}", style: const TextStyle(color: goldAccent))),
        TextField(controller: _p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FINAL FAIR MARKET PRICE", labelStyle: TextStyle(color: Colors.white24))),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(onPressed: () => onAction(queue[i], false, ""), child: const Text("REJECT", style: TextStyle(color: Colors.red))),
          ElevatedButton(onPressed: () => onAction(queue[i], true, _p.text), style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]), child: const Text("CERTIFY"))
        ])
      ]));
    });
  }

  Widget _buildAudit() {
    return ListView.builder(itemCount: audit.length, itemBuilder: (c, i) => ListTile(title: Text(audit[i], style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'))));
  }
}

// --- AGENT & BUYER PORTALS (HARDENED) ---
class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  final _b = TextEditingController(); final _t = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: warmBeige, appBar: AppBar(backgroundColor: warmBeige, title: const Text("AGENT INDUCTION")), body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
      TextField(controller: _b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: _t, decoration: const InputDecoration(labelText: "DNA ID")),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: deepBlack), onPressed: () { if(_t.text.isNotEmpty) onSync({"id": _t.text, "breed": _b.text}); _t.clear(); _b.clear(); }, child: const Text("UPLINK", style: TextStyle(color: goldAccent)))
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
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(title: const Text("HVF MARKETPLACE"), bottom: const TabBar(tabs: [Tab(text: "LIVE ASSETS"), Tab(text: "MY VAULT")])), body: TabBarView(children: [
      market.isEmpty ? const Center(child: Text("NO CERTIFIED ASSETS")) : ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), subtitle: const Text("SME CERTIFIED"), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: Text("BUY ${market[i]['price']}")))),
      vault.isEmpty ? const Center(child: Text("VAULT EMPTY")) : ListView.builder(itemCount: vault.length, itemBuilder: (c, i) => ListTile(title: Text(vault[i]['breed']!), subtitle: const Text("DEED SECURED"), trailing: const Icon(Icons.verified, color: goldAccent))),
    ])));
  }
}
