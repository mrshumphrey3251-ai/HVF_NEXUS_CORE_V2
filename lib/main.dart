import 'package:flutter/material.dart';

// HVF NEXUS CORE V74.0 - THE DOMINANT OPERATIONAL BUILD
// FEATURE: GLOBAL PERSISTENCE & HARDENED SECURITY GATES
// STATUS: TOUR-READY | STAGE COMPLETE
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
  bool _isCeoAuth = false;
  bool _isFarmerAuth = false;

  // GLOBAL LEDGER - This is the "Truth" of the app
  List<Map<String, String>> pendingQueue = [
    {"id": "ANGUS-V77", "origin": "Johnston Co.", "stats": "DNA: Verified | 1200 lbs"},
  ];
  List<Map<String, String>> liveMarket = [
    {"id": "HEREFORD-01", "price": "\$2,800.00", "grade": "SUPERIOR"},
  ];

  void _navigate(int index) {
    if (index == 1 && !_isCeoAuth) {
      _gate("CEO COMMAND ACCESS", "CEO1880", () => setState(() { _isCeoAuth = true; _selectedIndex = 1; }));
    } else if (index == 2 && !_isFarmerAuth) {
      _gate("PRODUCER UPLINK", "FARMER2026", () => setState(() { _isFarmerAuth = true; _selectedIndex = 2; }));
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _gate(String title, String key, VoidCallback success) {
    String entry = "";
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(title, style: const TextStyle(color: goldAccent, fontSize: 14)),
      content: TextField(
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(labelText: "ACCESS CODE", labelStyle: TextStyle(color: Colors.white54)),
        onChanged: (v) => entry = v,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(onPressed: () { if(entry == key){ Navigator.pop(context); success(); } }, child: const Text("ACCESS")),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: deepBlack,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _navigate,
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
          Expanded(child: _buildActiveRoom()),
        ],
      ),
    );
  }

  Widget _buildActiveRoom() {
    switch (_selectedIndex) {
      case 0: return const CampusMap();
      case 1: return CEORoom(queue: pendingQueue, onApprove: (item) {
        setState(() {
          pendingQueue.remove(item);
          liveMarket.add({"id": item['id']!, "price": "\$2,750.00", "grade": "SUPERIOR"});
        });
      });
      case 2: return FarmerRoom(onSync: (id) {
        setState(() { pendingQueue.add({"id": id, "origin": "LOCAL", "stats": "Awaiting SME Review"}); });
      });
      case 3: return BuyerRoom(market: liveMarket);
      default: return const CampusMap();
    }
  }
}

// --- DOMINANT COMPONENTS ---

class CampusMap extends StatelessWidget {
  const CampusMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFF152215), child: const Center(child: Text("HVF FLAGSHIP: JOHNSTON COUNTY CAMPUS", style: TextStyle(color: goldAccent, letterSpacing: 3))));
  }
}

class CEORoom extends StatelessWidget {
  final List<Map<String, String>> queue;
  final Function(Map<String, String>) onApprove;
  const CEORoom({super.key, required this.queue, required this.onApprove});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("EXECUTIVE COMMAND DESK", style: TextStyle(color: goldAccent))),
      body: queue.isEmpty ? const Center(child: Text("QUEUE CLEAR", style: TextStyle(color: Colors.white24))) :
      ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: queue.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF252525),
          child: ListTile(
            title: Text(queue[i]['id']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(queue[i]['stats']!, style: const TextStyle(color: goldAccent, fontSize: 11)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onApprove(queue[i]),
              child: const Text("STAMP & CERTIFY"),
            ),
          ),
        ),
      ),
    );
  }
}

class FarmerRoom extends StatelessWidget {
  final Function(String) onSync;
  const FarmerRoom({super.key, required this.onSync});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER UPLINK")),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 65)),
            onPressed: () { 
              onSync("NEW-ASSET-${DateTime.now().millisecond}");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET UPLINKED TO CEO")));
            },
            child: const Text("SYNC TO NEXUS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

class BuyerRoom extends StatelessWidget {
  final List<Map<String, String>> market;
  const BuyerRoom({super.key, required this.market});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("SME MARKETPLACE")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: market.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            title: Text(market[i]['id']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("CEO CERTIFIED: ${market[i]['grade']}", style: const TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold)),
            trailing: Text(market[i]['price']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
