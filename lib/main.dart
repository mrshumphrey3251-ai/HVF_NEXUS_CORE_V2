import 'package:flutter/material.dart';

//impoimport 'package:flutter/material.dart';

// HVF NEXUS CORE V83.0 - THE HUMPHREY STANDARD BUILD
// STATUS: DISCRETIONARY PRICING | ACCOUNTABILITY LOGIC | SME HARDENED
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
  
  // THE MASTER LEDGER
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
          "status": "CEO CERTIFIED"
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

// --- PORTAL 2: AGENT WORKSHEET ---
class AgentWorksheet extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentWorksheet({super.key, required this.onSync});
  final _breed = TextEditingController();
  final _tag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("SME FIELD INDUCTION")),
      body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
        TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED LINEAGE", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if(_tag.text.isNotEmpty) {
              onSync({"id": _tag.text, "breed": _breed.text});
              _tag.clear(); _breed.clear();
            }
          },
          child: const Text("UPLINK TO COMMAND", style: TextStyle(color: goldAccent)),
        ),
      ])),
    );
  }
}

// --- PORTAL 3: CEO COMMAND (DECISION ENGINE) ---
class CEOCommandDesk extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>, bool, String) onAction;
  const CEOCommandDesk({super.key, required this.queue, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO DECISION DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("NO PENDING ASSETS", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) {
          final priceController = TextEditingController(text: "\$2,850.00");
          return Card(
            color: const Color(0xFF252525),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                ListTile(
                  title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("TAG: ${queue[i]['id']}", style: const TextStyle(color: goldAccent)),
                ),
                TextField(
                  controller: priceController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "SET MARKET PRICE", labelStyle: TextStyle(color: Colors.white54)),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(onPressed: () => onAction(queue[i], false, ""), child: const Text("REJECT", style: TextStyle(color: Colors.red))),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                    onPressed: () => onAction(queue[i], true, priceController.text), 
                    child: const Text("APPROVE & RELEASE")
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
              subtitle: const Text("CEO CERTIFIED", style: TextStyle(color: goldAccent, fontSize: 10)),
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
              subtitle: Text("PRICE PAID: ${vault[i]['price']}", style: const TextStyle(fontSize: 10)),
            )),
          ),
        ]),
      ),
    );
  }
}rt 'package:flutter/material.dart';

// HVF NEXUS CORE V82.0 - THE EXECUTIVE DECISION ENGINE
// STATUS: ACTIVE DISCRETIONARY LOGIC | CEO JUDGMENT SEAT
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
  
  // SYSTEM LEDGER
  List<Map<String, String>> pendingInductions = []; 
  List<Map<String, String>> marketplaceLive = [];       
  List<Map<String, String>> buyerVault = [];        

  // EXECUTIVE COMMAND: AGENT DATA UPLINK
  void _agentUplink(Map<String, String> data) {
    setState(() {
      pendingInductions.add(data);
    });
  }

  // EXECUTIVE COMMAND: THE DECISION (APPROVE OR REJECT)
  void _ceoDecision(Map<String, String> item, bool isApproved) {
    setState(() {
      pendingInductions.remove(item);
      if (isApproved) {
        marketplaceLive.add({
          ...item, 
          "price": "\$2,850.00", 
          "status": "CEO CERTIFIED"
        });
      }
    });
  }

  // EXECUTIVE COMMAND: SETTLEMENT
  void _purchaseAsset(Map<String, String> item) {
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
          Expanded(child: _buildPortal()),
        ],
      ),
    );
  }

  Widget _buildPortal() {
    switch (_selectedIndex) {
      case 0: return const FlagshipMap();
      case 1: return AgentPortal(onSync: _agentUplink);
      case 2: return CEODecisionRoom(queue: pendingInductions, onDecision: _ceoDecision);
      case 3: return BuyerPortal(market: marketplaceLive, vault: buyerVault, onBuy: _purchaseAsset);
      default: return const FlagshipMap();
    }
  }
}

// --- PORTAL 1: MAP ---
class FlagshipMap extends StatelessWidget {
  const FlagshipMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: fieldGreen, child: const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(color: goldAccent, letterSpacing: 3, fontWeight: FontWeight.bold))));
  }
}

// --- PORTAL 2: AGENT (FIELD DATA) ---
class AgentPortal extends StatelessWidget {
  final Function(Map<String, String>) onSync;
  AgentPortal({super.key, required this.onSync});
  
  final _breed = TextEditingController();
  final _tag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("FIELD INDUCTION")),
      body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
        TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if(_tag.text.isNotEmpty) {
              onSync({"id": _tag.text, "breed": _breed.text});
              _tag.clear(); _breed.clear();
            }
          },
          child: const Text("UPLINK TO COMMAND", style: TextStyle(color: goldAccent)),
        ),
      ])),
    );
  }
}

// --- PORTAL 3: CEO (THE JUDGMENT SEAT) ---
class CEODecisionRoom extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>, bool) onDecision;
  const CEODecisionRoom({super.key, required this.queue, required this.onDecision});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("NO PENDING DECISIONS", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF252525),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("TAG: ${queue[i]['id']}", style: const TextStyle(color: goldAccent)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => onDecision(queue[i], false), 
                      child: const Text("REJECT", style: TextStyle(color: Colors.red))
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
                      onPressed: () => onDecision(queue[i], true), 
                      child: const Text("AUTHORIZE RELEASE")
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- PORTAL 4: BUYER ---
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
        appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER PORTAL"), bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [Tab(text: "MARKET"), Tab(text: "VAULT")])),
        body: TabBarView(children: [
          _market(market, onBuy),
          _vault(vault),
        ]),
      ),
    );
  }

  Widget _market(List market, Function onBuy) {
    return market.isEmpty ? const Center(child: Text("NO AUTHORIZED ASSETS")) : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: market.length,
      itemBuilder: (context, i) => Card(child: ListTile(
        title: Text(market[i]['breed']!),
        subtitle: const Text("CEO CERTIFIED", style: TextStyle(color: goldAccent, fontSize: 10)),
        trailing: ElevatedButton(onPressed: () => onBuy(market[i]), style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800), child: Text("BUY ${market[i]['price']}")),
      )),
    );
  }

  Widget _vault(List vault) {
    return vault.isEmpty ? const Center(child: Text("VAULT EMPTY")) : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vault.length,
      itemBuilder: (context, i) => Card(child: ListTile(
        leading: const Icon(Icons.verified, color: goldAccent),
        title: Text(vault[i]['breed']!),
        subtitle: const Text("RECORD SECURED", style: TextStyle(fontSize: 10)),
      )),
    );
  }
} HVF NEXUS CORE V81.0 - THE COMMAND-ACTIVE BUILD
// STATUS: ALL LOGIC HARD-WIRED | ZERO PLACEHOLDERS | AGENT-READY
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
  
  // THE MASTER LEDGER - THE SYSTEM'S BRAIN
  List<Map<String, String>> pendingInductions = []; 
  List<Map<String, String>> marketplaceLive = [];       
  List<Map<String, String>> buyerVault = [];        

  // COMMAND ACTION: AGENT TO CEO SYNC
  void _executeAgentSync(Map<String, String> data) {
    setState(() {
      pendingInductions.add(data);
      _selectedIndex = 2; // Auto-jump to CEO to show the Board the data moved
    });
  }

  // COMMAND ACTION: CEO CERTIFICATION
  void _executeCEOCertify(Map<String, String> item) {
    setState(() {
      pendingInductions.remove(item);
      marketplaceLive.add({
        ...item, 
        "price": "\$2,850.00", 
        "certifiedBy": "CEO J. HUMPHREY"
      });
    });
  }

  // COMMAND ACTION: BUYER SETTLEMENT
  void _executeBuyerPurchase(Map<String, String> item) {
    setState(() {
      marketplaceLive.remove(item);
      buyerViewVault.add(item); 
    });
  }

  // ALIGNMENT FIX: Ensuring variable name match for the compiler
  List<Map<String, String>> get buyerViewVault => buyerVault;

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
          Expanded(child: _buildPortal()),
        ],
      ),
    );
  }

  Widget _buildPortal() {
    switch (_selectedIndex) {
      case 0: return const FlagshipMap();
      case 1: return AgentWorksheet(onSyncCommand: _executeAgentSync);
      case 2: return CEOCommand(queue: pendingInductions, onCertifyCommand: _executeCEOCertify);
      case 3: return BuyerPortal(market: marketplaceLive, vault: buyerVault, onBuyCommand: _executeBuyerPurchase);
      default: return const FlagshipMap();
    }
  }
}

// --- MAP ---
class FlagshipMap extends StatelessWidget {
  const FlagshipMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: fieldGreen, child: const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY", style: TextStyle(color: goldAccent, letterSpacing: 3, fontWeight: FontWeight.bold))));
  }
}

// --- AGENT: DATA ENTRY COMMANDS ---
class AgentWorksheet extends StatelessWidget {
  final Function(Map<String, String>) onSyncCommand;
  AgentWorksheet({super.key, required this.onSyncCommand});
  
  final _breed = TextEditingController();
  final _tag = TextEditingController();
  final _weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("AGENT WORKSHEET")),
      body: Padding(padding: const EdgeInsets.all(40), child: Column(children: [
        TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        TextField(controller: _weight, decoration: const InputDecoration(labelText: "WEIGHT (LBS)", border: OutlineInputBorder())),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
          onPressed: () {
            if(_tag.text.isNotEmpty) {
              onSyncCommand({"id": _tag.text, "breed": _breed.text, "weight": _weight.text});
            }
          },
          child: const Text("EXECUTE SYNC TO CEO", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ),
      ])),
    );
  }
}

// --- CEO: CERTIFICATION COMMANDS ---
class CEOCommand extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>) onCertifyCommand;
  const CEOCommand({super.key, required this.queue, required this.onCertifyCommand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("QUEUE CLEAR", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF252525),
          child: ListTile(
            title: Text(queue[i]['breed']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("TAG: ${queue[i]['id']} | ${queue[i]['weight']} LBS", style: const TextStyle(color: goldAccent, fontSize: 11)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onCertifyCommand(queue[i]),
              child: const Text("STAMP & CERTIFY"),
            ),
          ),
        ),
      ),
    );
  }
}

// --- BUYER: SETTLEMENT COMMANDS ---
class BuyerPortal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onBuyCommand;
  const BuyerPortal({super.key, required this.market, required this.vault, required this.onBuyCommand});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER PORTAL"), bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [Tab(text: "MARKET"), Tab(text: "VAULT")])),
        body: TabBarView(children: [
          _marketList(),
          _vaultList(context),
        ]),
      ),
    );
  }

  Widget _marketList() {
    return market.isEmpty ? const Center(child: Text("NO ASSETS AVAILABLE")) : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: market.length,
      itemBuilder: (context, i) => Card(child: ListTile(
        title: Text(market[i]['breed']!),
        subtitle: const Text("CEO CERTIFIED SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10)),
        trailing: ElevatedButton(onPressed: () => onBuyCommand(market[i]), style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800), child: Text("BUY ${market[i]['price']}")),
      )),
    );
  }

  Widget _vaultList(BuildContext context) {
    return vault.isEmpty ? const Center(child: Text("VAULT EMPTY")) : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vault.length,
      itemBuilder: (context, i) => Card(child: ListTile(
        leading: const Icon(Icons.verified, color: goldAccent),
        title: Text(vault[i]['breed']!),
        subtitle: const Text("OFFICIAL RECORD SECURED", style: TextStyle(fontSize: 10)),
      )),
    );
  }
}
