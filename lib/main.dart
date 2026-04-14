import 'package:flutter/material.dart';

// HVF NEXUS CORE V96.0 - THE ESCROW & SETTLEMENT BUILD
// FEATURE: TWO-STAGE SETTLEMENT | ESCROW HOLDING | CEO FINAL RELEASE
// STATUS: PHASE 3 - FINANCIAL HARDENING
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
  List<Map<String, String>> escrowHolding = []; // NEW: ESCROW LAYER
  List<Map<String, String>> ownerVault = [];   
  List<String> auditLog = ["ESCROW ENGINE ACTIVE: ${DateTime.now().hour}:${DateTime.now().minute}"];

  void _log(String m) => setState(() => auditLog.insert(0, "${DateTime.now().hour}:${DateTime.now().minute} [SECURE] - $m"));

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
      case 1: return AgentPortal(onSync: (d) { setState(() => pendingQueue.add(d)); _log("UPLINK: ${d['id']}"); });
      case 2: return CEOPortal(
        queue: pendingQueue, 
        escrow: escrowHolding,
        audit: auditLog, 
        onAction: (it, app, pr) {
          setState(() { 
            pendingQueue.remove(it); 
            if (app) marketLive.add({...it, "price": pr});
          });
          _log(app ? "CERTIFIED: ${it['id']}" : "VOIDED: ${it['id']}");
        },
        onRelease: (it) {
          setState(() {
            escrowHolding.remove(it);
            ownerVault.add({...it, "ceo_stamp": "CERTIFIED BY JEFFERY HUMPHREY", "settled": "${DateTime.now()}"});
          });
          _log("FINAL SETTLEMENT: Deed Issued for ${it['id']}");
        }
      );
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, escrow: escrowHolding, onBuy: (it) {
        setState(() { marketLive.remove(it); escrowHolding.add(it); });
        _log("ESCROW INITIATED: Awaiting CEO Release for ${it['id']}");
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
  final List<Map<String, String>> escrow;
  final List<String> audit;
  final Function(Map<String, String>, bool, String) onAction;
  final Function(Map<String, String>) onRelease;

  const CEOPortal({super.key, required this.queue, required this.escrow, required this.audit, required this.onAction, required this.onRelease});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(backgroundColor: charcoal, appBar: AppBar(backgroundColor: deepBlack, bottom: const TabBar(tabs: [Tab(text: "QUEUE"), Tab(text: "ESCROW"), Tab(text: "AUDIT")])), body: TabBarView(children: [
      _buildList(queue, true),
      _buildEscrowList(escrow),
      ListView.builder(itemCount: audit.length, itemBuilder: (c, i) => ListTile(title: Text(audit[i], style: const TextStyle(color: Colors.white60, fontSize: 10))))
    ])));
  }

  Widget _buildList(List<Map<String, String>> list, bool isQueue) {
    return ListView.builder(itemCount: list.length, itemBuilder: (c, i) => ListTile(
      title: Text(list[i]['breed']!, style: const TextStyle(color: Colors.white)),
      trailing: ElevatedButton(onPressed: () => onAction(list[i], true, "\$2,850"), child: const Text("CERTIFY")),
    ));
  }

  Widget _buildEscrowList(List<Map<String, String>> list) {
    return list.isEmpty ? const Center(child: Text("NO PENDING SETTLEMENTS", style: TextStyle(color: Colors.white24))) :
    ListView.builder(itemCount: list.length, itemBuilder: (c, i) => ListTile(
      title: Text(list[i]['breed']!, style: const TextStyle(color: Colors.white)),
      subtitle: const Text("FUNDS PENDING VERIFICATION", style: TextStyle(color: goldAccent, fontSize: 10)),
      trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]), onPressed: () => onRelease(list[i]), child: const Text("RELEASE DEED")),
    ));
  }
}

class BuyerPortal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final List<Map<String, String>> escrow;
  final Function(Map<String, String>) onBuy;
  const BuyerPortal({super.key, required this.market, required this.vault, required this.escrow, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(appBar: AppBar(bottom: const TabBar(tabs: [Tab(text: "MARKET"), Tab(text: "VAULT")])), body: TabBarView(children: [
      ListView.builder(itemCount: market.length, itemBuilder: (c, i) => ListTile(title: Text(market[i]['breed']!), trailing: ElevatedButton(onPressed: () => onBuy(market[i]), child: const Text("BUY")))),
      ListView.builder(itemCount: vault.length + escrow.length, itemBuilder: (c, i) {
        if (i < escrow.length) return ListTile(title: Text(escrow[i]['breed']!), subtitle: const Text("PENDING CEO RELEASE..."), leading: const Icon(Icons.timer, color: Colors.orange));
        final vIndex = i - escrow.length;
        return ListTile(title: Text(vault[vIndex]['breed']!), subtitle: const Text("DEED SECURED"), leading: const Icon(Icons.verified, color: Colors.green));
      }),
    ])));
  }
}
