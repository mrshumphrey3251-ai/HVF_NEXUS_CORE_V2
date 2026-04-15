import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS OS V122.0 - THE MODULAR SOVEREIGN CORE
// 100% STABILITY BUILD | AUTHORIZED: JEFFERY DONNELL HUMPHREY
// UEI: S1M4ENLHTDH5 | PATENT: TPP99424 | SME: NCCER/NCCO

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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Courier',
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC5A059), secondary: Colors.cyan),
      ),
      home: const SovereignDashboard(),
    );
  }
}

// --- THE MASTER COMMAND CHASSIS ---
class SovereignDashboard extends StatelessWidget {
  const SovereignDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          color: const Color(0xFF0A0A0A),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("UEI: S1M4ENLHTDH5", style: TextStyle(fontSize: 7, color: Color(0xFFC5A059))),
              Text("HVF_NEXUS_CORE_V2.0", style: TextStyle(fontSize: 7, color: Colors.white24, letterSpacing: 2)),
              Text("PATENT: TPP99424", style: TextStyle(fontSize: 7, color: Colors.cyan)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          // THE HUMPHREY CREST
          const Center(
            child: Icon(Icons.shield_rounded, size: 110, color: Color(0xFFC5A059)),
          ),
          const SizedBox(height: 15),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 5)),
          const Text("SOVEREIGN INFRASTRUCTURE OS", style: TextStyle(fontSize: 9, color: Colors.grey, letterSpacing: 6)),
          const Spacer(),
          // MODULAR ACTION GRID
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Wrap(
              spacing: 12, runSpacing: 12, alignment: WrapAlignment.center,
              children: [
                _actionTile(context, "EXECUTIVE_WAR_ROOM", Icons.analytics),
                _actionTile(context, "WAPANUCKA_NODE", Icons.hub),
                _actionTile(context, "HELIO_GRID", Icons.solar_power),
                _actionTile(context, "RESTORATION", Icons.healing),
                _actionTile(context, "COMMODITY_EXCHANGE", Icons.currency_exchange),
                _actionTile(context, "HOUSING_GRID", Icons.home_work),
              ],
            ),
          ),
          const Spacer(),
          const Text("SME AUTHORITY: JEFFERY DONNELL HUMPHREY", style: TextStyle(fontSize: 8, color: Colors.cyan, letterSpacing: 1)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _actionTile(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Modular Routing Logic
        print("COMMAND: Accessing $title");
      },
      child: Container(
        width: 155, height: 95,
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          border: Border.all(color: const Color(0xFFC5A059), width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFC5A059), size: 22),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
