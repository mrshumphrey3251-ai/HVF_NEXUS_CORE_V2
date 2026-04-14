import 'package:flutter/material.dart';

// HVF NEXUS CORE V76.0 - THE TOTAL SYNCHRONIZATION BUILD
// FEATURE: FULL PORTAL RESTORATION & INTEGRATED SUPPORT LOGIC
// STATUS: TOUR-READY | ZERO-LOSS ARCHITECTURE
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
  
  // GLOBAL LEDGER (Maintains data across all portals)
  List<Map<String, String>> pendingForCEO = [
    {"id": "ANGUS-V88", "producer": "S. Smith", "status": "DNA: Verified"},
  ];
  List<Map<String, String>> liveMarket = [
    {"id": "HEREFORD-B12", "price": "\$2,400.00", "grade": "SUPERIOR"},
  ];
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
              NavigationRailDestination(icon: Icon(Icons.admin_panel_settings), label: Text("CEO")),
              NavigationRailDestination(icon: Icon(Icons.agriculture), label: Text("FARMER")),
              NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("BUYER")),
            ],
          ),
          Expanded(child: _buildIntegratedRoom()),
        ],
      ),
    );
  }

  Widget _buildIntegratedRoom() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP: JOHNSTON CO.", style: TextStyle(color: goldAccent, letterSpacing: 2)));
      case 1: return CEORoom(assets: pendingForCEO, onApprove: (item) {
        setState(() {
          pendingForCEO.remove(item);
          liveMarket.add({"id": item['id']!, "price": "\$2,750.00", "grade": "SUPERIOR"});
        });
      });
      case 2: return FarmerRoom(onUpload: (id) {
        setState(() { pendingForCEO.add({"id": id, "producer": "YOU", "status": "Syncing..."}); });
      });
      case 3: return BuyerPortal(market: liveMarket, vault: buyerVault, onBuy: (item) {
        setState(() { liveMarket.remove(item); buyerVault.add(item); });
      });
      default: return const SizedBox();
    }
  }
}

// --- CEO ROOM ---
class CEORoom extends StatelessWidget {
  final List<Map<String, String>> assets;
  final Function(Map<String, String>) onApprove;
  const CEORoom({super.key, required this.assets, required this.onApprove});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: assets.isEmpty ? const Center(child: Text("QUEUE CLEAR", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assets.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF252525),
          child: ListTile(
            title: Text(assets[i]['id']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(assets[i]['status']!, style: const TextStyle(color: goldAccent, fontSize: 10)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onApprove(assets[i]),
              child: const Text("CERTIFY"),
            ),
          ),
        ),
      ),
    );
  }
}

// --- FARMER ROOM ---
class FarmerRoom extends StatelessWidget {
  final Function(String) onUpload;
  const FarmerRoom({super.key, required this.onUpload});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER UPLINK")),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: "ASSET ID / DNA TAG", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 65)),
            onPressed: () { 
              onUpload("ANGUS-${DateTime.now().millisecond}");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SUCCESSFUL")));
            },
            child: const Text("SYNC TO CEO", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- BUYER PORTAL (MARKET + VAULT + SUPPORT) ---
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
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: const Text("BUYER PORTAL"),
          bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [
            Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
            Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
          ]),
        ),
        body: TabBarView(children: [
          _buildMarket(),
          _buildVault(context),
        ]),
      ),
    );
  }

  Widget _buildMarket() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: market.length,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          title: Text(market[i]['id']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
            onPressed: () => onBuy(market[i]),
            child: Text("BUY ${market[i]['price']}"),
          ),
        ),
      ),
    );
  }

  Widget _buildVault(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vault.length,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.verified, color: goldAccent),
          title: Text(vault[i]['id']!),
          subtitle: const Text("SME CERTIFIED", style: TextStyle(fontSize: 10)),
          trailing: OutlinedButton(
            onPressed: () => _showGraceDialog(context),
            child: const Text("REQUEST GRACE", style: TextStyle(fontSize: 9, color: Colors.brown)),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeedView())),
        ),
      ),
    );
  }

  void _showGraceDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("SOVEREIGN SUPPORT"),
      content: const Text("Request a 14-day payment extension for CEO review?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("SUBMIT REQUEST")),
      ],
    ));
  }
}

// --- THE DEED ---
class DeedView extends StatelessWidget {
  const DeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Container(
          width: 400, padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: const Color(0xFFFFFDF7), border: Border.all(color: certificateGold, width: 8)),
          child: const Column(mainAxisSize: MainAxisSize.min, children: [
            Text("HVF - 1880 STANDARD", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
            Divider(color: goldAccent),
            SizedBox(height: 20),
            Text("CERTIFICATE OF LINEAGE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
            SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("OFFICIAL SEAL", style: TextStyle(fontSize: 8)),
              Icon(Icons.shield, color: goldAccent, size: 40),
              Text("CEO J. HUMPHREY", style: TextStyle(fontSize: 8)),
            ]),
          ]),
        ),
      ),
    );
  }
}
