import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - CONSOLIDATED MASTER CORE V141.0
// THE ENTIRE WAPANUCKA NODE IN ONE UNIT
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | PATENT: TPP99424
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)
// =========================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(const HVFNexusConsolidated());
}

class HVFNexusConsolidated extends StatelessWidget {
  const HVFNexusConsolidated({super.key});
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
      home: const MainNavigationHub(),
    );
  }
}

class MainNavigationHub extends StatefulWidget {
  const MainNavigationHub({super.key});
  @override
  State<MainNavigationHub> createState() => _MainNavigationHubState();
}

class _MainNavigationHubState extends State<MainNavigationHub> {
  int _selectedIndex = 0;

  // CONSOLIDATED VIEWS
  final List<Widget> _views = [
    const OverseerDashboard(),
    const BuyerTerminal(),
    const ProducerPortal(),
    const RestorationVault(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.white24,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.security), label: "OVERSEER"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "BUYER"),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: "PRODUCER"),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: "RESTORATION"),
        ],
      ),
    );
  }
}

// --- MODULE 1: OVERSEER (THE MACHINE) ---
class OverseerDashboard extends StatelessWidget {
  const OverseerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header("EXECUTIVE_WAR_ROOM"),
        _stat("HELIO_GRID", "482 KW", Colors.orangeAccent),
        _stat("RESERVOIR", "22.4 FT", Colors.blueAccent),
        _stat("FLEET_STATUS", "12 ACTIVE", Colors.greenAccent),
        const Spacer(),
        const Text("CAGE: 1AHA8 | SYSTEM SECURE", style: TextStyle(fontSize: 8, color: Colors.white10)),
        const SizedBox(height: 20),
      ],
    );
  }
}

// --- MODULE 2: BUYER (THE EXCHANGE) ---
class BuyerTerminal extends StatelessWidget {
  const BuyerTerminal({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header("INSTITUTIONAL_BUYER_TERMINAL"),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('listings').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              return ListView(
                children: snapshot.data!.docs.map((doc) => ListTile(
                  title: Text(doc['title']),
                  subtitle: Text("PRICE: \$${doc['price']}"),
                  trailing: const Icon(Icons.add_shopping_cart, color: Color(0xFFC5A059)),
                )).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

// --- MODULE 3: PRODUCER (THE FARM) ---
class ProducerPortal extends StatelessWidget {
  const ProducerPortal({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header("PRODUCER_PROOF_PORTAL"),
        const SizedBox(height: 40),
        const Icon(Icons.videocam, size: 80, color: Colors.cyan),
        const Text("UPLOAD_VIDEO_PROOF", style: TextStyle(letterSpacing: 2)),
        const Padding(
          padding: EdgeInsets.all(30),
          child: Text("All uploads are timestamped and geo-tagged to the Wapanucka Node for SME verification.", textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: Colors.white38)),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("INITIALIZE_UPLOAD")),
      ],
    );
  }
}

// --- MODULE 4: RESTORATION (THE MISSION) ---
class RestorationVault extends StatelessWidget {
  const RestorationVault({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header("VETERAN_ADVOCACY_VAULT"),
        _stat("SSI/SSDI_CLAIMS", "4 PENDING", Colors.cyan),
        _stat("SME_CERTIFICATIONS", "12 ACTIVE", Color(0xFFC5A059)),
        _stat("90_DAY_GRACE", "8 PROVISIONAL", Colors.white24),
      ],
    );
  }
}

// --- SHARED UI COMPONENTS ---
Widget _header(String t) => Container(
  width: double.infinity, padding: const EdgeInsets.only(top: 60, bottom: 20), color: Colors.black,
  child: Center(child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 3, fontWeight: FontWeight.bold))),
);

Widget _stat(String l, String v, Color c) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(color: const Color(0xFF0D0D0D), border: Border(left: BorderSide(color: c, width: 2))),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 8)), Text(v, style: TextStyle(color: c, fontWeight: FontWeight.bold))]),
);
