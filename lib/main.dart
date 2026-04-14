import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V115.9.1 - PARTNER FLEET STABILIZATION
// FOCUS: RESTORING SHELL CLASS & PARTNER MARKETPLACE
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
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Colors.black, 
        fontFamily: 'Courier'
      ),
      home: const HVFShell(),
    );
  }
}

// RESTORED: THE CORE INTERFACE SHELL
class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() { role = null; userID = null; })
        ),
        title: Text(":: $role PARTNER FLEET ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.engineering, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE V115", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PARTNER FARMER", "PRODUCER"),
        _gateBtn("FLEET BUYER", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildIdentityOnboarding() {
    final idController = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(40), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("PARTNER VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "AGENT ID / ENTITY NAME")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildFleetListing();
    if (role == "BUYER") return _buildFleetMarket();
    return _buildCEOOversight();
  }

  Widget _buildFleetListing() {
    final m = TextEditingController(); 
    final h = TextEditingController(); 
    final p = TextEditingController();
    
    return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
      const Text("UPLINK USED EQUIPMENT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextField(controller: m, decoration: const InputDecoration(labelText: "MODEL (e.g. Caterpillar 320)")),
      TextField(controller: h, decoration: const InputDecoration(labelText: "SERVICE HOURS")),
      TextField(controller: p, decoration: const InputDecoration(labelText: "ASKING PRICE", prefixText: "\$")),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': m.text, 'vital1': h.text, 'value': double.tryParse(p.text) ?? 0,
            'category': 'FLEET', 'status': 'FOR SALE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
          });
          m.clear(); h.clear(); p.clear();
        },
        child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ])));
  }

  Widget _buildFleetMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger')
        .where('category', isEqualTo: 'FLEET')
        .where('status', isEqualTo: 'FOR SALE')
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: ListTile(
            leading: const Icon(Icons.build_circle, color: Colors.orange),
            title: Text(data['name'] ?? "UNKNOWN UNIT", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("HOURS: ${data['vital1']} | PRICE: \$${data['value']}"),
            trailing: OutlinedButton(onPressed: () {}, child: const Text("ENQUIRE", style: TextStyle(color: Color(0xFFC5A059)))),
          ));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('category', isEqualTo: 'FLEET').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name'] ?? "UNNAMED"),
            subtitle: Text("PARTNER: ${data['source']} | STATUS: ${data['status']}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => docs[i].reference.delete()),
          );
        });
      },
    );
  }
}import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V115.9 - PARTNER FLEET EXCHANGE
// FOCUS: DEDICATED SECONDARY MARKET FOR PARTNER FARMERS
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
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Colors.black, 
        fontFamily: 'Courier'
      ),
      home: const HVFShell(),
    );
  }
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() { role = null; userID = null; })
        ),
        title: Text(":: $role PARTNER FLEET ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.settings_input_component, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE V115", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PARTNER FARMER", "PRODUCER"),
        _gateBtn("FLEET BUYER", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildIdentityOnboarding() {
    final idController = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(40), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("PARTNER VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "AGENT ID / ENTITY NAME")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildFleetListing();
    if (role == "BUYER") return _buildFleetMarket();
    return _buildCEOOversight();
  }

  // --- PARTNER FARMER: LISTING FOR SALE ---
  Widget _buildFleetListing() {
    final m = TextEditingController(); 
    final h = TextEditingController(); 
    final p = TextEditingController();
    
    return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
      const Text("UPLINK USED EQUIPMENT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextField(controller: m, decoration: const InputDecoration(labelText: "MODEL (e.g. John Deere 5075E)")),
      TextField(controller: h, decoration: const InputDecoration(labelText: "TOTAL SERVICE HOURS")),
      TextField(controller: p, decoration: const InputDecoration(labelText: "ASKING PRICE", prefixText: "\$")),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': m.text, 'vital1': h.text, 'value': double.tryParse(p.text) ?? 0,
            'category': 'FLEET', 'status': 'FOR SALE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
          });
          m.clear(); h.clear(); p.clear();
        },
        child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ])));
  }

  // --- BUYER: THE PARTNER FLEET MARKET ---
  Widget _buildFleetMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger')
        .where('category', isEqualTo: 'FLEET')
        .where('status', isEqualTo: 'FOR SALE')
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: ListTile(
            leading: const Icon(Icons.settings, color: Colors.orange),
            title: Text(data['name'] ?? "UNKNOWN UNIT", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("HOURS: ${data['vital1']} | PRICE: \$${data['value']}"),
            trailing: OutlinedButton(onPressed: () {}, child: const Text("ENQUIRE", style: TextStyle(color: Color(0xFFC5A059)))),
          ));
        });
      },
    );
  }

  // --- CEO: OVERSIGHT OF ALL PARTNER TRANSACTIONS ---
  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('category', isEqualTo: 'FLEET').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name'] ?? "UNNAMED"),
            subtitle: Text("PARTNER: ${data['source']} | STATUS: ${data['status']}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => docs[i].reference.delete()),
          );
        });
      },
    );
  }
}
