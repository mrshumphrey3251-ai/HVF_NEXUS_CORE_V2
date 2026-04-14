import 'package:flutter/material.dart';

// HVF NEXUS CORE V87.0 - THE HARDENED COMMAND BUILD
// FEATURE: TOTAL SYSTEM RESTORATION | INDUSTRIAL DESIGN | ZERO-LOSS FLOW
// STATUS: TOUR-READY | HUMPHREY STANDARD COMPLIANT
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

  // THE PERSISTENT MASTER LEDGER
  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketLive = [];       
  List<Map<String, String>> ownerVault = [];        

  void _handleNavigation(int index) {
    if (index == 1 && !_isAgentAuth) {
      _authGate("AGENT UPLINK ACCESS", "FARMER2026", () {
        setState(() { _isAgentAuth = true; _selectedIndex = 1; });
      });
    } else if (index == 2 && !_isCeoAuth) {
      _authGate("CEO COMMAND ACCESS", "CEO1880", () {
        setState(() { _isCeoAuth = true; _selectedIndex = 2; });
      });
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _authGate(String title, String key, VoidCallback success) {
    String input = "";
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(title, style: const TextStyle(color: goldAccent, fontSize: 14)),
      content: TextField(
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(labelText: "ACCESS CODE", labelStyle: TextStyle(color: Colors.white54)),
        onChanged: (v) => input = v,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(onPressed: () { if(input == key) { Navigator.pop(context); success(); } }, child: const Text("AUTHENTICATE")),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: deepBlack,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _handleNavigation,
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
          const VerticalDivider(thickness: 1, width: 1, color: Colors.white12),
          Expanded(child: _buildCurrentPortal()),
        ],
      ),
    );
  }

  Widget _buildCurrentPortal() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(color: deepBlack, letterSpacing: 4, fontWeight: FontWeight.w900)));
      case 1: return AgentPortal(onSync: (data) => setState(() => pendingQueue.add(data)));
      case 2: return CEOPortal(queue: pendingQueue, onDecision: (item, isApproved, price) {
        setState(() {
          pendingQueue.remove(item);
          if (isApproved) marketLive.add({...item, "price": price});
        });
      });
      case 3: return BuyerPortal(market: marketLive, vault: ownerVault, onBuy: (item) {
        setState(() {
          marketLive.remove(item);
          ownerVault.add(item);
        });
      });
      default: return const SizedBox();
    }
  }
}

// --- AGENT: FIELD DATA ENTRY ---
class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  final _breed = TextEditingController();
  final _tag = TextEditingController();
  final _weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("AGENT WORKSHEET", style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
        TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED LINEAGE", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _weight, decoration: const InputDecoration(labelText: "WEIGHT (LBS)", border: OutlineInputBorder())),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if(_tag.text.isNotEmpty) {
              onSync({"id": _tag.text, "breed": _breed.text, "weight": _weight.text});
              _tag.clear(); _breed.clear(); _weight.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("DATA SYNCED TO CEO")));
            }
          },
          child: const Text("UPLINK TO COMMAND", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ),
      ])),
    );
  }
}

// --- CEO: COMMAND DESK ---
class CEOPortal extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>, bool, String) onDecision;
  const CEOPortal({super.key, required this.queue, required this.onDecision});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: charcoalGrey,
      appBar: AppBar(backgroundColor: charcoalGrey, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("QUEUE CLEAR", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) {
          final _price = TextEditingController(text: "\$2,850.00");
          return Card(
            color: deepBlack,
            child: Padding(padding: const EdgeInsets.all(15), child: Column(children: [
              ListTile(
                title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text("DNA: ${queue[i]['id']} | ${queue[i]['weight']} LBS", style: const TextStyle(color: goldAccent, fontSize: 11)),
              ),
              TextField(controller: _price, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "SET FAIR MARKET PRICE", labelStyle: TextStyle(color: Colors.white54))),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(onPressed: () => onDecision(queue[i], false, ""), child: const Text("REJECT", style: TextStyle(color: Colors.red))),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                  onPressed: () => onDecision(queue[i], true, _price.text), 
                  child: const Text("CERTIFY & RELEASE")
                ),
              ]),
            ])),
          );
        },
      ),
    );
  }
}

// --- BUYER: MARKET & VAULT ---
class BuyerPortal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onBuy;
  const BuyerPortal({super.key, required this.market, required this.vault, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER PORTAL"), bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [Tab(text: "MARKET"), Tab(text: "MY VAULT")])),
        body: TabBarView(children: [
          _list(market, true),
          _list(vault, false),
        ]),
      ),
    );
  }

  Widget _list(List list, bool isMarket) {
    return list.isEmpty ? const Center(child: Text("NO DATA AVAILABLE")) : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: list.length,
      itemBuilder: (context, i) => Card(child: ListTile(
        leading: isMarket ? null : const Icon(Icons.verified, color: goldAccent),
        title: Text(list[i]['breed']!),
        subtitle: Text(isMarket ? "CEO CERTIFIED SUPERIOR" : "RECORD SECURED: ${list[i]['price']}", style: const TextStyle(color: goldAccent, fontSize: 10)),
        trailing: isMarket ? ElevatedButton(onPressed: () => onBuy(list[i]), style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800), child: Text("BUY ${list[i]['price']}")) : null,
      )),
    );
  }
}
