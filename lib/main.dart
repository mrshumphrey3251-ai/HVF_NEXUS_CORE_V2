import 'package:flutter/material.dart';

// HVF NEXUS CORE V84.0 - THE EQUAL GROUND BUILD
// FEATURE: FAIR MARKET BASELINE & VALUE PROOF LOGIC
// STATUS: ANTI-MONOPOLY HARDENED | HUMPHREY STANDARD COMPLIANT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFShell(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color fieldGreen = Color(0xFF152215);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  
  // THE EQUAL GROUND LEDGER
  List<Map<String, String>> pendingQueue = []; 
  List<Map<String, String>> marketplaceLive = [];       
  List<Map<String, String>> buyerVault = [];        

  void _agentUplink(Map<String, String> data) {
    setState(() => pendingQueue.add(data));
  }

  void _ceoExecutiveAction(Map<String, String> item, bool isApproved, String price) {
    setState(() {
      pendingQueue.remove(item);
      if (isApproved) {
        marketplaceLive.add({
          ...item, 
          "price": price, 
          "certifiedBy": "CEO J. HUMPHREY"
        });
      }
    });
  }

  void _buyerPurchase(Map<String, String> item) {
    setState(() {
      marketplaceLive.remove(item);
      buyerVault.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
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
          Expanded(child: _buildRoom()),
        ],
      ),
    );
  }

  Widget _buildRoom() {
    switch (_selectedIndex) {
      case 0: return const CampusMap();
      case 1: return AgentWorksheet(onSync: _agentUplink);
      case 2: return CEOCommandDesk(queue: pendingQueue, onAction: _ceoExecutiveAction);
      case 3: return BuyerTerminal(market: marketplaceLive, vault: buyerVault, onBuy: _buyerPurchase);
      default: return const CampusMap();
    }
  }
}

// --- PORTAL 1: THE MAP ---
class CampusMap extends StatelessWidget {
  const CampusMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: fieldGreen, child: const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(color: goldAccent, letterSpacing: 3, fontWeight: FontWeight.bold))));
  }
}

// --- PORTAL 2: AGENT WORKSHEET (Value Proof Focused) ---
class AgentWorksheet extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentWorksheet({super.key, required this.onSync});
  final _breed = TextEditingController();
  final _tag = TextEditingController();
  final _ask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("FAIR MARKET INDUCTION")),
      body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
        const Text("PROVE VALUE +/-", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
        const SizedBox(height: 20),
        TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _ask, decoration: const InputDecoration(labelText: "REQUESTED PRICE", border: OutlineInputBorder())),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if(_tag.text.isNotEmpty) {
              onSync({"id": _tag.text, "breed": _breed.text, "ask": _ask.text});
              _tag.clear(); _breed.clear(); _ask.clear();
            }
          },
          child: const Text("UPLINK FOR SME REVIEW", style: TextStyle(color: goldAccent)),
        ),
      ])),
    );
  }
}

// --- PORTAL 3: CEO COMMAND (FAIRNESS DESK) ---
class CEOCommandDesk extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>, bool, String) onAction;
  const CEOCommandDesk({super.key, required this.queue, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("FAIR MARKET OVERSIGHT", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("ALL RECORDS EQUALIZED", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) {
          final priceController = TextEditingController(text: queue[i]['ask']);
          return Card(
            color: const Color(0xFF252525),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                ListTile(
                  title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("DNA TAG: ${queue[i]['id']}", style: const TextStyle(color: goldAccent)),
                ),
                TextField(
                  controller: priceController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "VERIFIED FAIR MARKET VALUE", labelStyle: TextStyle(color: Colors.white54)),
                ),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(onPressed: () => onAction(queue[i], false, ""), child: const Text("REJECT", style: TextStyle(color: Colors.red))),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                    onPressed: () => onAction(queue[i], true, priceController.text), 
                    child: const Text("AUTHORIZE EQUAL RELEASE")
                  ),
                ]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

// --- PORTAL 4: BUYER TERMINAL ---
class BuyerTerminal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onBuy;
  const BuyerTerminal({super.key, required this.market, required this.vault, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER PORTAL"), bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [Tab(text: "MARKET"), Tab(text: "VAULT")])),
        body: TabBarView(children: [
          market.isEmpty ? const Center(child: Text("NO AUTHORIZED ASSETS")) :
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: market.length,
            itemBuilder: (context, i) => Card(child: ListTile(
              title: Text(market[i]['breed']!),
              subtitle: const Text("CEO CERTIFIED: FAIR MARKET", style: TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(onPressed: () => onBuy(market[i]), style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800), child: Text("BUY ${market[i]['price']}")),
            )),
          ),
          vault.isEmpty ? const Center(child: Text("VAULT EMPTY")) :
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: vault.length,
            itemBuilder: (context, i) => Card(child: ListTile(
              leading: const Icon(Icons.verified, color: goldAccent),
              title: Text(vault[i]['breed']!),
              subtitle: Text("FAIR PRICE SECURED: ${vault[i]['price']}", style: const TextStyle(fontSize: 10)),
            )),
          ),
        ]),
      ),
    );
  }
}
