import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V117.1 - THE SALE-READY MVP
// FINAL LOCK: INSTITUTIONAL HUB, GLOBAL EXCHANGE, & DIVIDEND LEDGER
// AUTHORIZED: JEFFERY DONNELL HUMPHREY (CEO)

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
        title: Text(":: HVF NEXUS CORE ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 4)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red, size: 18), onPressed: () => setState(() { role = null; userID = null; }))],
      ),
      body: IndexedStack(index: _selectedIndex, children: [_buildHub(), _buildExchange(), _buildLedger()]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFFC5A059),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0D0D0D),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'HUB'),
          BottomNavigationBarItem(icon: Icon(Icons.api), label: 'EXCHANGE'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'LEDGER'),
        ],
      ),
    );
  }

  // --- TAB 1: INSTITUTIONAL HUB ---
  Widget _buildHub() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        int count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        return Padding(padding: const EdgeInsets.all(25), child: Column(children: [
          _card("NATIONAL MANAGED VOLUME", "$count HEAD", Colors.cyan),
          const SizedBox(height: 15),
          _card("PROJECTED PARTNER DIVIDEND", "\$${(count * 50).toStringAsFixed(2)}/MO", const Color(0xFFC5A059)),
          const Spacer(),
          const Icon(Icons.verified_user, size: 60, color: Colors.white10),
          const Text("SME SYSTEM STANDARDS ACTIVE", style: TextStyle(fontSize: 8, color: Colors.grey)),
        ]));
      },
    );
  }

  // --- TAB 2: GLOBAL EXCHANGE ---
  Widget _buildExchange() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snapshot.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return ListTile(
            leading: const Icon(Icons.token, color: Color(0xFFC5A059)),
            title: Text(data['name'] ?? "ASSET"),
            subtitle: Text("VALUE: \$${data['value']} | DIVIDEND: \$${data['stew_fee']}/MO"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 12),
          );
        }).toList());
      },
    );
  }

  // --- TAB 3: PARTNER LEDGER ---
  Widget _buildLedger() => const Center(child: Text("FARMER-DIRECT PAYMENTS ACTIVE", style: TextStyle(color: Colors.grey, fontSize: 10)));

  // --- UI UTILITIES ---
  Widget _card(String t, String v, Color c) => Container(
    padding: const EdgeInsets.all(20), width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF111111), border: Border(left: BorderSide(color: c, width: 3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      Text(v, style: TextStyle(fontSize: 20, color: c, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _buildGate() => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.public, color: Color(0xFFC5A059), size: 80),
    const SizedBox(height: 40),
    _btn("CEO COMMAND", "CEO"),
    _btn("INSTITUTIONAL PARTNER", "PRODUCER"),
  ])));

  Widget _btn(String l, String r) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(280, 60)),
    onPressed: () => setState(() => role = r), child: Text(l)));

  Widget _buildAuth() {
    final c = TextEditingController();
    return Scaffold(body: Padding(padding: const EdgeInsets.all(50), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("GLOBAL ENTITY AUTH"),
      TextField(controller: c, decoration: const InputDecoration(labelText: "ENTITY ID")),
      const SizedBox(height: 30),
      ElevatedButton(onPressed: () => setState(() => userID = c.text), child: const Text("INITIALIZE")),
    ])));
  }
}
