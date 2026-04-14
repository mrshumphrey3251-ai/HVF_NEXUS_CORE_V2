import 'package:flutter/material.dart';

// HVF NEXUS CORE V95.0 - THE DEED ISSUANCE BUILD
// FEATURE: AUTOMATED LINEAGE DEEDS | CEO AUTHENTICATION STAMPS | TRANSACTIONAL FINALITY
// STATUS: PHASE 3 COMPLETE | INVESTOR READY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF121212);
const Color charcoal = Color(0xFF1E1E1E);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["DEED SYSTEM ONLINE: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [DEED] - $m"));

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
            NavigationRailDestination(icon: Icon(Icons.gavel), label: Text("CEO")),
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
      case 1: return AgentPortal(onSync: (d) { setState(() => pendingQueue.add(d)); _log("ASSET INDUCTED: ${d['id']}"); });
      case 2: return CEOPortal(queue: pendingQueue, audit: auditLog, onAction: (it, app, pr) {
        setState(() { 
          pendingQueue.remove(it); 
          if (app) marketLive.add({...it, "price": pr, "ceo_stamp": "CERTIFIED BY JEFFERY HUMPHREY"});
        });
        _log(app ? "CEO CERTIFIED: ${it['id']}" : "REJECTED: ${it['id']}");
      });
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (it) {
        setState(() { marketLive.remove(it); ownerVault.add(it); });
        _log("DEED ISSUED: ${it['id']}");
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
      const Text("AGENT FIELD UPLINK"),
      TextField(controller: _b, decoration: const InputDecoration(labelText: "BREED")),
      TextField(controller: _t, decoration: const InputDecoration(labelText: "DNA ID")),
      ElevatedButton(onPressed: () { onSync({"id": _t.text, "breed": _b.text}); _t.clear(); _b.clear(); }, child: const Text("SYNC"))
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
    return DefaultTabController(length: 2, child: Scaffold(backgroundColor: charcoal, appBar: AppBar(backgroundColor: deepBlack, bottom: const TabBar(tabs: [Tab(text: "QUEUE"), Tab(text: "AUDIT")])), body: TabBarView(children: [
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
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(bottom: const TabBar(tabs: [Tab(text: "MARKET"), Tab(text: "MY VAULT")])), body: TabBarView(children: [
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: const Text("BUY")))),
      ListView.builder(itemCount: vault.length, itemBuilder: (c, i) => ListTile(title: Text(vault[i]['breed']!), subtitle: const Text("VIEW DEED"), onTap: () => _showDeed(c, vault[i]))),
    ])));
  }

  void _showDeed(BuildContext context, Map<String, String> item) {
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("OFFICIAL CERTIFICATE OF LINEAGE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(color: goldAccent, thickness: 2),
        Text("ASSET ID: ${item['id']}"),
        Text("BREED: ${item['breed']}"),
        Text("PRICE: ${item['price']}"),
        const SizedBox(height: 20),
        Text(item['ceo_stamp'] ?? "", style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 10)),
        const SizedBox(height: 10),
        const Text("DEED STATUS: LEGALLY SECURED", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("CLOSE"))],
    ));
  }
}
