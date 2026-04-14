import 'package:flutter/material.dart';

// HVF NEXUS CORE V78.0 - THE AGENT-READY INFRASTRUCTURE
// FEATURE: FULL SME GRADING WORKSHEET & AGENT-TO-CEO SYNC
// STATUS: DEPLOYMENT READY | 40-CITY TOUR COMPLIANT
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

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  
  // THE AGENT-CEO LEDGER
  List<Map<String, String>> masterInductionQueue = []; 
  List<Map<String, String>> marketplaceLive = [];       
  List<Map<String, String>> buyerVault = [];        

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
              NavigationRailDestination(icon: Icon(Icons.payments), label: Text("BUYER")),
            ],
          ),
          Expanded(child: _buildOperationalRoom()),
        ],
      ),
    );
  }

  Widget _buildOperationalRoom() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON CO.", style: TextStyle(color: goldAccent, letterSpacing: 2)));
      case 1: 
        return AgentInductionWorksheet(onSubmission: (data) {
          setState(() { masterInductionQueue.add(data); });
        });
      case 2: 
        return CEOCommandDesk(queue: masterInductionQueue, onCertify: (item) {
          setState(() {
            masterInductionQueue.remove(item);
            marketplaceLive.add({...item, "price": "\$2,850.00"});
          });
        });
      case 3: 
        return BuyerTerminal(market: marketplaceLive, vault: buyerVault, onPurchase: (item) {
          setState(() {
            marketplaceLive.remove(item);
            buyerVault.add(item);
          });
        });
      default: return const SizedBox();
    }
  }
}

// --- THE AGENT'S WORKSHEET ---
class AgentInductionWorksheet extends StatefulWidget {
  final Function(Map<String, String>) onSubmission;
  const AgentInductionWorksheet({super.key, required this.onSubmission});

  @override
  State<AgentInductionWorksheet> createState() => _AgentInductionWorksheetState();
}

class _AgentInductionWorksheetState extends State<AgentInductionWorksheet> {
  final _breed = TextEditingController();
  final _tag = TextEditingController();
  final _weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("AGENT INDUCTION WORKSHEET")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("SME FIELD DATA ENTRY", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.brown)),
          const SizedBox(height: 30),
          TextField(controller: _breed, decoration: const InputDecoration(labelText: "BREED / LINEAGE", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          TextField(controller: _tag, decoration: const InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          TextField(controller: _weight, decoration: const InputDecoration(labelText: "EST. WEIGHT (LBS)", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () {
              if(_tag.text.isNotEmpty) {
                widget.onSubmission({
                  "id": _tag.text,
                  "breed": _breed.text,
                  "weight": _weight.text,
                  "status": "Awaiting CEO Approval"
                });
                _tag.clear(); _breed.clear(); _weight.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("DATA SYNCED TO CEO COMMAND")));
              }
            },
            child: const Text("OFFICIALLY SYNC TO NEXUS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- CEO COMMAND DESK ---
class CEOCommandDesk extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>) onCertify;
  const CEOCommandDesk({super.key, required this.queue, required this.onCertify});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("NO PENDING ASSETS", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: queue.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF252525),
          child: ListTile(
            title: Text("${queue[i]['breed']} - TAG: ${queue[i]['id']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("WEIGHT: ${queue[i]['weight']} lbs", style: const TextStyle(color: goldAccent, fontSize: 11)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onCertify(queue[i]),
              child: const Text("APPROVE"),
            ),
          ),
        ),
      ),
    );
  }
}

// --- BUYER TERMINAL ---
class BuyerTerminal extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onPurchase;
  const BuyerTerminal({super.key, required this.market, required this.vault, required this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: const Text("BUYER PORTAL"),
          bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [
            Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
            Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
          ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: market.length,
            itemBuilder: (context, i) => Card(
              child: ListTile(
                title: Text("${market[i]['breed']} #${market[i]['id']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("CEO CERTIFIED SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                  onPressed: () => onPurchase(market[i]),
                  child: Text("BUY ${market[i]['price']}"),
                ),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: vault.length,
            itemBuilder: (context, i) => Card(
              child: ListTile(
                leading: const Icon(Icons.verified, color: goldAccent),
                title: Text("${vault[i]['breed']} #${vault[i]['id']}"),
                subtitle: const Text("OWNERSHIP RECORD SECURED", style: TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
