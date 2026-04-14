import 'package:flutter/material.dart';

// HVF NEXUS CORE V77.1 - THE HARDENED LEDGER
// FIX: RESOLVED VARIABLE MISMATCH IN TRANSACTION LOGIC
// STATUS: TOTAL PROOF OF CONCEPT | TOUR-READY
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
const Color certificateGold = Color(0xFFD4AF37);

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  int _selectedIndex = 0;
  
  // THE GLOBAL LEDGER: THE SINGLE SOURCE OF TRUTH
  List<Map<String, String>> pendingInductions = []; 
  List<Map<String, String>> marketplace = [];       
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
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20), 
              child: Icon(Icons.shield_rounded, color: goldAccent, size: 40)
            ),
            labelType: NavigationRailLabelType.all,
            unselectedLabelTextStyle: const TextStyle(color: Colors.white38, fontSize: 10),
            selectedLabelTextStyle: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.map), label: Text("MAP")),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("FARMER")),
              NavigationRailDestination(icon: Icon(Icons.admin_panel_settings), label: Text("CEO")),
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
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON CO.", style: TextStyle(color: goldAccent, letterSpacing: 2)));
      case 1: 
        return FarmerRoom(onSync: (id) {
          setState(() { pendingInductions.add({"id": id, "status": "Awaiting SME Review"}); });
        });
      case 2: 
        return CEORoom(queue: pendingInductions, onApprove: (item) {
          setState(() {
            pendingInductions.remove(item);
            marketplace.add({"id": item['id']!, "price": "\$2,750.00"});
          });
        });
      case 3: 
        return BuyerRoom(market: marketplace, vault: buyerVault, onBuy: (item) {
          setState(() {
            marketplace.remove(item);
            buyerVault.add(item); // FIXED: Variable alignment secured
          });
        });
      default: return const SizedBox();
    }
  }
}

// --- FARMER: THE INPUT ---
class FarmerRoom extends StatelessWidget {
  final Function(String) onSync;
  FarmerRoom({super.key, required this.onSync});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER UPLINK")),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const Text("ASSET INDUCTION ENGINE", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.brown)),
          const SizedBox(height: 30),
          TextField(controller: _controller, decoration: const InputDecoration(labelText: "DNA TAG / ASSET NAME", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 65)),
            onPressed: () { 
              if(_controller.text.isNotEmpty) {
                onSync(_controller.text);
                _controller.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET UPLINKED TO CEO DESK")));
              }
            },
            child: const Text("SYNC TO NEXUS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- CEO: THE AUTHORITY ---
class CEORoom extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>) onApprove;
  const CEORoom({super.key, required this.queue, required this.onApprove});

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
            title: Text(queue[i]['id']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text("DNA VERIFIED | AWAITING SIGNATURE", style: TextStyle(color: goldAccent, fontSize: 10)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onApprove(queue[i]),
              child: const Text("CERTIFY"),
            ),
          ),
        ),
      ),
    );
  }
}

// --- BUYER: THE SETTLEMENT ---
class BuyerRoom extends StatelessWidget {
  final List<Map<String, String>> market;
  final List<Map<String, String>> vault;
  final Function(Map<String, String>) onBuy;
  const BuyerRoom({super.key, required this.market, required this.vault, required this.onBuy});

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
          market.isEmpty ? const Center(child: Text("MARKETPLACE EMPTY")) :
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: market.length,
            itemBuilder: (context, i) => Card(
              child: ListTile(
                title: Text(market[i]['id']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("CEO CERTIFIED: SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                  onPressed: () => onBuy(market[i]),
                  child: Text("BUY ${market[i]['price']}"),
                ),
              ),
            ),
          ),
          vault.isEmpty ? const Center(child: Text("VAULT EMPTY")) :
          ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: vault.length,
            itemBuilder: (context, i) => Card(
              child: ListTile(
                leading: const Icon(Icons.verified, color: goldAccent),
                title: Text(vault[i]['id']!),
                subtitle: const Text("OFFICIAL CERTIFICATE ISSUED", style: TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
