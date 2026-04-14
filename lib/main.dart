import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V111.1 - COMMAND & CONTROL NAV
// FOCUS: GLOBAL NAVIGATION & ESCAPE PROTOCOLS
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

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4,
        // The Global Return: Sends you back to the Role Selection screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)),
          onPressed: () => setState(() => role = null),
        ),
        title: Text(":: $role DASHBOARD ::", 
          style: const TextStyle(color: Color(0xFFC5A059), letterSpacing: 2, fontSize: 14)),
        actions: [
          // The Executive Kill-Switch: Immediate Sign Out
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.red),
            onPressed: () => setState(() => role = null),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.agriculture, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF TRANSACTION ENGINE", 
          style: TextStyle(color: Color(0xFFC5A059), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 3)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER (ENTRY)", "PRODUCER"),
        _gateBtn("BUYER (MARKET)", "BUYER"),
      ]))),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFC5A059), width: 2),
          minimumSize: const Size(300, 60),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        onPressed: () => setState(() => role = r), 
        child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerMarket();
    return _buildCEOOversight();
  }

  // --- PRODUCER: INDUCTION ---
  Widget _buildProducerEntry() {
    final b = TextEditingController(); final i = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUCT ASSET TO PIPELINE", style: TextStyle(color: Colors.grey, letterSpacing: 2)),
      const SizedBox(height: 20),
      TextField(controller: b, decoration: const InputDecoration(labelText: "ANIMAL BREED", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
      TextField(controller: i, decoration: const InputDecoration(labelText: "ANIMAL ID / TAG", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059))))),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          if(b.text.isNotEmpty && i.text.isNotEmpty) {
            await FirebaseFirestore.instance.collection('pipeline').add({
              'breed': b.text, 'id': i.text, 'status': 'AVAILABLE', 'timestamp': FieldValue.serverTimestamp(),
            });
            b.clear(); i.clear();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET INDUCTED SUCCESSFULLY")));
          }
        },
        child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  // --- BUYER: MARKETPLACE ---
  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text("MARKETPLACE EMPTY", style: TextStyle(color: Colors.grey)));
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF1A1A1A),
              child: ListTile(
                title: Text(data['breed'], style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
                subtitle: Text("ID: ${data['id']}", style: const TextStyle(color: Colors.white70)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => docs[index].reference.update({'status': 'CLAIMED'}),
                  child: const Text("BUY", style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- CEO: OVERSIGHT ---
  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pipeline').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            bool isClaimed = data['status'] == 'CLAIMED';
            return ListTile(
              leading: Icon(isClaimed ? Icons.check_circle : Icons.radio_button_unchecked, color: isClaimed ? Colors.green : Colors.orange),
              title: Text("${data['breed']} [${data['id']}]"),
              subtitle: Text("STATUS: ${data['status']}"),
              trailing: IconButton(icon: const Icon(Icons.delete_sweep, color: Colors.red), onPressed: () => docs[index].reference.delete()),
            );
          },
        );
      },
    );
  }
}
