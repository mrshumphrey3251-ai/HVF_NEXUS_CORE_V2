import 'package:flutter/material.dart';

// HVF NEXUS CORE V75.0 - THE COMPLETE BUYER CIRCUIT
// FEATURE: MARKET-TO-VAULT SETTLEMENT & DIGITAL DEED ISSUANCE
// STATUS: DOMINANT UNIFIED BUILD | FULL TRANSACTIONAL PROOF
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
  
  // SHARED STATE FOR DEMO
  List<Map<String, String>> marketplace = [
    {"id": "ANGUS-V77", "price": "\$2,750.00", "grade": "SUPERIOR"},
    {"id": "HEREFORD-B12", "price": "\$2,400.00", "grade": "SUPERIOR"},
  ];
  List<Map<String, String>> myVault = [];

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
              NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text("MARKET")),
              NavigationRailDestination(icon: Icon(Icons.lock_person), label: Text("VAULT")),
            ],
          ),
          Expanded(child: _buildRoom()),
        ],
      ),
    );
  }

  Widget _buildRoom() {
    switch (_selectedIndex) {
      case 0: return const Center(child: Text("HVF FLAGSHIP MAP", style: TextStyle(color: goldAccent)));
      case 1: return MarketplaceRoom(assets: marketplace, onPurchase: (item) {
        setState(() {
          marketplace.remove(item);
          myVault.add(item);
        });
      });
      case 2: return VaultRoom(assets: myVault);
      default: return const SizedBox();
    }
  }
}

// --- BUYER MARKETPLACE ---
class MarketplaceRoom extends StatelessWidget {
  final List<Map<String, String>> assets;
  final Function(Map<String, String>) onPurchase;
  const MarketplaceRoom({super.key, required this.assets, required this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("HVF MARKETPLACE")),
      body: assets.isEmpty ? const Center(child: Text("ALL ASSETS ACQUIRED")) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assets.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            title: Text(assets[i]['id']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("CEO CERTIFIED: SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
              onPressed: () => onPurchase(assets[i]),
              child: Text("BUY ${assets[i]['price']}"),
            ),
          ),
        ),
      ),
    );
  }
}

// --- BUYER VAULT ---
class VaultRoom extends StatelessWidget {
  final List<Map<String, String>> assets;
  const VaultRoom({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("MY SECURED VAULT")),
      body: assets.isEmpty ? const Center(child: Text("NO ASSETS OWNED")) :
      ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assets.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            leading: const Icon(Icons.verified, color: goldAccent),
            title: Text(assets[i]['id']!),
            subtitle: const Text("VIEW CERTIFICATE OF LINEAGE", style: TextStyle(fontSize: 10)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeedView())),
          ),
        ),
      ),
    );
  }
}

// --- THE DIGITAL DEED (THE PROOF) ---
class DeedView extends StatelessWidget {
  const DeedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: const Color(0xFFFFFDF7), border: Border.all(color: certificateGold, width: 8)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("HVF - 1880 STANDARD", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
            const Divider(color: goldAccent),
            const SizedBox(height: 20),
            const Text("CERTIFICATE OF LINEAGE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 40),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
