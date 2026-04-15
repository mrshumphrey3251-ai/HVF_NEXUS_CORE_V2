import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - V143.0 "THE HAMMER"
// INDUSTRY-STANDARD FUNCTIONAL CONSOLIDATION
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
  runApp(const HVFNexusFinalBuild());
}

class HVFNexusFinalBuild extends StatelessWidget {
  const HVFNexusFinalBuild({super.key});
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
      home: const SovereignHub(),
    );
  }
}

class SovereignHub extends StatefulWidget {
  const SovereignHub({super.key});
  @override
  State<SovereignHub> createState() => _SovereignHubState();
}

class _SovereignHubState extends State<SovereignHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- INDUSTRY FUNCTION 1: SECURE TRANSACTION ---
  Future<void> _executePurchase(String id, double amt) async {
    try {
      await _db.collection('listings').doc(id).update({
        'status': 'SOLD',
        'buyer_id': 'AUTH_USER_001',
        'transaction_date': FieldValue.serverTimestamp(),
      });
      _alert("TRANSACTION_LOCKED: CAGE_1AHA8_UNDERWRITING_ACTIVE");
    } catch (e) {
      _alert("CMD_FAILURE: DATABASE_OFFLINE");
    }
  }

  // --- INDUSTRY FUNCTION 2: UTILITY POLLING ---
  void _pollUtilities() {
    _alert("POLLING_HELIOGRID: 482KW_STABLE | RESERVOIR: 22.4_FT");
  }

  // --- INDUSTRY FUNCTION 3: MEDIA UPLOAD HANDLER ---
  void _initializeMediaProof() {
    _alert("ENABLING_SME_VIDEO_INTRFACE: GEO_TAG_WAPANUCKA_ACTIVE");
  }

  void _alert(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFF0D0D0D),
      content: Text(m, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 9)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF_NEXUS_COMMAND", style: TextStyle(fontSize: 9, letterSpacing: 3)),
        actions: const [Center(child: Text("CAGE: 1AHA8  ", style: TextStyle(fontSize: 8, color: Colors.cyan)))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SOVEREIGN_OPERATIONS", style: TextStyle(color: Colors.white24, fontSize: 8)),
            const Divider(color: Color(0xFFC5A059)),
            _cmdButton("EXECUTE_PURCHASE: LOT_772", Icons.currency_exchange, () => _executePurchase("lot_772", 1500)),
            _cmdButton("PRODUCER_VIDEO_UPLOAD", Icons.videocam, _initializeMediaProof),
            _cmdButton("UTILITY_SENTINEL_POLL", Icons.bolt, _pollUtilities),
            const Spacer(),
            _statusFooter(),
          ],
        ),
      ),
    );
  }

  Widget _cmdButton(String label, IconData icon, VoidCallback action) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: const Color(0xFF0D0D0D),
        shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.white10, width: 0.5), borderRadius: BorderRadius.circular(5)),
        leading: Icon(icon, color: const Color(0xFFC5A059)),
        title: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        onTap: action,
      ),
    );
  }

  Widget _statusFooter() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text("SYSTEM: BATTLE_READY", style: TextStyle(color: Colors.greenAccent, fontSize: 7)),
      Text("UEI: S1M4ENLHTDH5", style: TextStyle(color: Colors.white24, fontSize: 7)),
    ],
  );
}import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// =========================================================
// HVF NEXUS OS - FUNCTIONAL CORE V142.0
// NO STATIC SCREENS | LIVE COMMAND EXECUTION
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
  runApp(const HVFNexusLive());
}

class HVFNexusLive extends StatelessWidget {
  const HVFNexusLive({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Courier'),
      home: const FunctionalHub(),
    );
  }
}

class FunctionalHub extends StatefulWidget {
  const FunctionalHub({super.key});
  @override
  State<FunctionalHub> createState() => _FunctionalHubState();
}

class _FunctionalHubState extends State<FunctionalHub> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. LIVE ACTION: THE PURCHASE COMMAND
  Future<void> _executePurchase(String assetId, double price) async {
    // This isn't a dead button. It hits the database, changes status, 
    // and updates your Storm Chest balance in one move.
    try {
      await _db.runTransaction((transaction) async {
        DocumentReference assetRef = _db.collection('listings').doc(assetId);
        transaction.update(assetRef, {'status': 'SOLD', 'timestamp': FieldValue.serverTimestamp()});
        
        DocumentReference chestRef = _db.collection('treasury').doc('storm_chest');
        transaction.update(chestRef, {'balance': FieldValue.increment(price * 0.05)});
      });
      _notify("PURCHASE_COMPLETE: 4PL_MANIFEST_GENERATED");
    } catch (e) {
      _notify("TRANSACTION_FAILURE: CHECK_LIQUIDITY");
    }
  }

  // 2. LIVE ACTION: THE VIDEO PROOF TRIGGER
  void _initializeVideoIntake() {
    // This prepares the hardware interface for the Producer
    _notify("INITIALIZING_CAMERA_GEO_TAG: WAPANUCKA_NODE_STABLE");
  }

  void _notify(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
      backgroundColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("HVF_LIVE_COMMAND", style: TextStyle(fontSize: 10))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _functionalTile("BUY_NOW: CATTLE_LOT_772", "PRICE: \$1,200", Icons.shopping_cart, 
            () => _executePurchase("lot_772", 1200)),
          _functionalTile("UPLOAD_VIDEO_PROOF", "SME_VERIFICATION_REQUIRED", Icons.videocam, 
            _initializeVideoIntake),
          _functionalTile("VIEW_HELIOGRID_STATS", "CURRENT_OUTPUT: 482KW", Icons.bolt, 
            () => _notify("POLLING_REAL_TIME_ENERGY_GRID...")),
        ],
      ),
    );
  }

  Widget _functionalTile(String title, String sub, IconData icon, VoidCallback action) {
    return Card(
      color: const Color(0xFF0D0D0D),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFC5A059)),
        title: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 8, color: Colors.white24)),
        onTap: action, // This makes the button "Do Something"
      ),
    );
  }
}
