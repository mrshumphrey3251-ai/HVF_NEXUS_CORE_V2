import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.0 - THE RESTRUCTURED CORE
// FOCUS: INSTITUTIONAL SCALE & CLUTTER PREVENTION
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
      authDomain: "hvf-nexus.firebaseapp.com",
      projectId: "hvf-nexus",
      storageBucket: "hvf-nexus.firebasestorage.app",
      messagingSenderId: "892263251736",
      appId: "1:892263251736:web:899cc6ab03f6f5e9d8286d",
    ),
  );
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const HVFShell(),
    );
  }
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildGate();
    if (userID == null) return _buildAuth();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(":: HVF NEXUS v117 ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 4)),
        leading: IconButton(icon: const Icon(Icons.logout, color: Colors.red, size: 16), onPressed: () => setState(() { role = null; userID = null; })),
      ),
      body: _buildPageRouter(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF111111),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'HUB'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_vert), label: 'EXCHANGE'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'LEDGER'),
        ],
      ),
    );
  }

  // --- RESTRUCTURED INTERFACES ---

  Widget _buildPageRouter() {
    switch (_selectedIndex) {
      case 0: return _buildMainHub();
      case 1: return _buildExchange();
      case 2: return _buildLedger();
      default: return _buildMainHub();
    }
  }

  // HUB: THE COMMAND CENTER
  Widget _buildMainHub() {
    return Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      _summaryCard("NATIONAL VOLUME", "12,450 HEAD", Colors.cyan),
      const SizedBox(height: 15),
      _summaryCard("MONTHLY DIVIDENDS", "\$622,500.00", const Color(0xFFC5A059)),
      const SizedBox(height: 40),
      const Text(":: ACTIVE ASSET TRACKING ::", style: TextStyle(fontSize: 10, color: Colors.grey)),
      const Expanded(child: Center(child: Icon(Icons.map, size: 100, color: Colors.white10))),
    ]));
  }

  // EXCHANGE: THE BUYER'S PATH
  Widget _buildExchange() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((doc) {
          final d = doc.data() as Map<String, dynamic>;
          return ListTile(
            leading: const Icon(Icons.token, color: Color(0xFFC5A059)),
            title: Text(d['name'] ?? "ASSET"),
            subtitle: Text("VALUE: \$${d['value']}"),
            trailing: const Icon(Icons.chevron_right),
          );
        }).toList());
      },
    );
  }

  // LEDGER: THE SME AUDIT
  Widget _buildLedger() {
    return const Center(child: Text("SME FINANCIAL AUDIT ACTIVE", style: TextStyle(color: Colors.grey)));
  }

  // --- UI UTILITIES ---

  Widget _summaryCard(String title, String val, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 4))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      Text(val, style: TextStyle(fontSize: 22, color: c, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _buildGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.public, color: Color(0xFFC5A059), size: 80),
        const SizedBox(height: 20),
        const Text("HVF GLOBAL INFRASTRUCTURE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 40),
        _gateBtn("CEO COMMAND", "CEO"),
        _gateBtn("PARTNER FARMER", "PRODUCER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
      onPressed: () => setState(() => role = r), child: Text(l)),
  );

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("ENTITY AUTHENTICATION"),
        TextField(controller: c, decoration: const InputDecoration(labelText: "NAME / ID")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
      ])),
    );
  }
}
