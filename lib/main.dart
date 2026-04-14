import 'package:flutter/material.dart';

// HVF NEXUS CORE V73.0 - OPERATIONAL SOVEREIGNTY
// FEATURE: PASSWORD GATES, DYNAMIC DATA BRIDGING, & FULL PATH EXECUTION
// STATUS: TOUR-READY DOMINANT BUILD
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
  bool _isCeoAuthenticated = false;
  bool _isProducerAuthenticated = false;

  // SYSTEM STATE (Simulating a Live Database for the Tour)
  List<Map<String, String>> pendingAssets = [
    {"id": "ANGUS-V77", "status": "Pending SME Review", "producer": "S. Smith"},
  ];
  List<Map<String, String>> marketplaceAssets = [
    {"id": "ANGUS-044", "price": "\$2,695.00", "grade": "SUPERIOR"},
  ];

  void _handleAuthentication(int index) {
    if (index == 1 && !_isCeoAuthenticated) {
      _showAuthDialog("CEO COMMAND ACCESS", "CEO1880", () {
        setState(() { _isCeoAuthenticated = true; _selectedIndex = index; });
      });
    } else if (index == 2 && !_isProducerAuthenticated) {
      _showAuthDialog("PRODUCER UPLINK", "FARMER2026", () {
        setState(() { _isProducerAuthenticated = true; _selectedIndex = index; });
      });
    } else {
      setState(() { _selectedIndex = index; });
    }
  }

  void _showAuthDialog(String title, String correctPass, VoidCallback onSuccess) {
    String input = "";
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: deepBlack,
      title: Text(title, style: const TextStyle(color: goldAccent, fontSize: 14)),
      content: TextField(
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(labelText: "ENTER ACCESS CODE", labelStyle: TextStyle(color: Colors.white54)),
        onChanged: (val) => input = val,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(
          onPressed: () {
            if (input == correctPass) {
              Navigator.pop(context);
              onSuccess();
            }
          }, 
          child: const Text("AUTHENTICATE")
        ),
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
            onDestinationSelected: _handleAuthentication,
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
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0: return const FlagshipMap();
      case 1: return CEORoom(assets: pendingAssets, onApprove: (id) {
        setState(() {
          pendingAssets.removeWhere((a) => a['id'] == id);
          marketplaceAssets.add({"id": id, "price": "\$2,500.00", "grade": "SUPERIOR"});
        });
      });
      case 2: return ProducerRoom(onUpload: (id) {
        setState(() { pendingAssets.add({"id": id, "status": "Pending SME Review", "producer": "YOU"}); });
      });
      case 3: return BuyerRoom(assets: marketplaceAssets);
      default: return const FlagshipMap();
    }
  }
}

// --- THE ROOMS (FUNCTIONAL PATHS) ---

class FlagshipMap extends StatelessWidget {
  const FlagshipMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFF152215), child: const Center(child: Text("HVF FLAGSHIP CAMPUS: LIVE OPS", style: TextStyle(color: goldAccent, letterSpacing: 2))));
  }
}

class CEORoom extends StatelessWidget {
  final List<Map<String, String>> assets;
  final Function(String) onApprove;
  const CEORoom({super.key, required this.assets, required this.onApprove});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND", style: TextStyle(color: goldAccent))),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assets.length,
        itemBuilder: (context, i) => Card(
          color: const Color(0xFF2A2A2A),
          child: ListTile(
            title: Text(assets[i]['id']!, style: const TextStyle(color: Colors.white)),
            subtitle: Text(assets[i]['status']!, style: const TextStyle(color: goldAccent, fontSize: 10)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900),
              onPressed: () => onApprove(assets[i]['id']!),
              child: const Text("CERTIFY"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProducerRoom extends StatelessWidget {
  final Function(String) onUpload;
  const ProducerRoom({super.key, required this.onUpload});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER UPLINK")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: "ASSET ID", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
            onPressed: () {
              onUpload("NEW-ANGUS-99");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SYNCED TO CEO DESK")));
            },
            child: const Text("SUBMIT TO NEXUS", style: TextStyle(color: goldAccent)),
          ),
        ]),
      ),
    );
  }
}

class BuyerRoom extends StatelessWidget {
  final List<Map<String, String>> assets;
  const BuyerRoom({super.key, required this.assets});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("MARKETPLACE")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assets.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            title: Text(assets[i]['id']!),
            subtitle: Text("GRADE: ${assets[i]['grade']}", style: const TextStyle(color: goldAccent, fontSize: 10)),
            trailing: Text(assets[i]['price']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          ),
        ),
      ),
    );
  }
}
