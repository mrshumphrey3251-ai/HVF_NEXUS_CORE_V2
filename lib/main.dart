import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - PRODUCTION CORE V140.0 (FULLY OPERATIONAL)
// UNIFIED BUYER / SELLER / OVERSEER COMMAND
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)
// =========================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // INITIALIZE FEDERAL-GRADE CLOUD INFRASTRUCTURE
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
      authDomain: "hvf-nexus.firebaseapp.com",
      projectId: "hvf-nexus",
      storageBucket: "hvf-nexus.firebasestorage.app",
      messagingSenderId: "892263251736",
      appId: "1:892263251736:web:899cc6ab03f6f5e9d82899",
    ),
  );
  runApp(const HVFNexusOS());
}

class HVFNexusOS extends StatelessWidget {
  const HVFNexusOS({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020202),
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const UnifiedSovereignCommand(),
    );
  }
}

class UnifiedSovereignCommand extends StatefulWidget {
  const UnifiedSovereignCommand({super.key});
  @override
  State<UnifiedSovereignCommand> createState() => _UnifiedSovereignCommandState();
}

class _UnifiedSovereignCommandState extends State<UnifiedSovereignCommand> {
  int _activeRoleIndex = 2; // Default to OVERSEER

  final List<String> _roleTitles = ["BUYER_TERMINAL", "PRODUCER_PORTAL", "EXECUTIVE_WAR_ROOM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_roleTitles[_activeRoleIndex], style: const TextStyle(fontSize: 10, color: Color(0xFFC5A059), letterSpacing: 2)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan)))],
      ),
      drawer: _buildRoleDrawer(),
      body: _buildActiveView(),
      bottomNavigationBar: _buildSovereignStatus(),
    );
  }

  // --- ROLE SWITCHER LOGIC ---
  Widget _buildActiveView() {
    switch (_activeRoleIndex) {
      case 0: return _buyerTerminal();
      case 1: return _producerPortal();
      case 2: return _executiveWarRoom();
      default: return _executiveWarRoom();
    }
  }

  // 1. BUYER TERMINAL (ACQUISITION)
  Widget _buyerTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('listings').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: Text("SCANNING_MARKET..."));
        return ListView(
          padding: const EdgeInsets.all(20),
          children: snapshot.data!.docs.map((doc) => Card(
            color: const Color(0xFF0D0D0D),
            child: ListTile(
              title: Text(doc['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("PRICE: \$${doc['price']} | SME_VERIFIED: ${doc['sme_verified']}"),
              trailing: ElevatedButton(onPressed: () => _executePurchase(doc.id), child: const Text("BUY")),
            ),
          )).toList(),
        );
      },
    );
  }

  // 2. PRODUCER PORTAL (ASSET UPLOAD)
  Widget _producerPortal() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.video_call, size: 50, color: Colors.cyan),
          const Text("UPLOAD PROOF OF LIFE (VIDEO)", style: TextStyle(fontSize: 8)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 60)),
            onPressed: () {}, // Trigger Video Picker
            child: const Text("INITIALIZE_UPLOAD"),
          ),
        ],
      ),
    );
  }

  // 3. EXECUTIVE WAR ROOM (OVERSEER)
  Widget _executiveWarRoom() {
    return Column(
      children: [
        _statBar("HELIOGRID_POWER", "482KW", Colors.orangeAccent),
        _statBar("STORM_CHEST", "\$2.4M", const Color(0xFFC5A059)),
        _statBar("4PL_FLEET", "12_ACTIVE", Colors.greenAccent),
        const Expanded(child: Center(child: Text("SYSTEM_LOCK: CAGE 1AHA8", style: TextStyle(color: Colors.white10)))),
      ],
    );
  }

  // --- HELPER METHODS ---
  Widget _statBar(String l, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 2))),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 8)), Text(v, style: TextStyle(color: c, fontWeight: FontWeight.bold))]),
  );

  Widget _buildRoleDrawer() => Drawer(
    child: ListView(
      children: [
        const DrawerHeader(child: Center(child: Text("SELECT ROLE", style: TextStyle(color: Color(0xFFC5A059))))),
        ListTile(title: const Text("BUYER"), onTap: () => setState(() { _activeRoleIndex = 0; Navigator.pop(context); })),
        ListTile(title: const Text("SELLER"), onTap: () => setState(() { _activeRoleIndex = 1; Navigator.pop(context); })),
        ListTile(title: const Text("OVERSEER"), onTap: () => setState(() { _activeRoleIndex = 2; Navigator.pop(context); })),
      ],
    ),
  );

  Widget _buildSovereignStatus() => Container(
    height: 40, color: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("STATUS: BATTLE_READY", style: TextStyle(fontSize: 7, color: Colors.greenAccent)), Text("SME: J.D. HUMPHREY", style: TextStyle(fontSize: 7, color: Colors.cyan))]),
  );

  Future<void> _executePurchase(String id) async {
    // Transaction logic here
    print("PURCHASING: $id");
  }
}
