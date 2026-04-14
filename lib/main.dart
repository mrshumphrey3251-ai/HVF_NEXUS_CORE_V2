import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V113.0 - TOTAL SYSTEMS INTEGRATION
// IDENTITY | MULTI-SECTOR | FINANCIAL ANALYTICS
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
  String activeCategory = "LIVESTOCK";

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() { role = null; userID = null; })),
        title: Text(":: $role DASHBOARD ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() { role = null; userID = null; }))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.account_tree, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF SOVEREIGN ERP", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("AGENT/PRODUCER", "PRODUCER"),
        _gateBtn("BUYER/CLIENT", "BUYER"),
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
        const Text("SECURE IDENTITY VERIFICATION", style: TextStyle(color: Color(0xFFC5A059), letterSpacing: 2)),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "ENTER NAME OR ENTITY ID")),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 55)),
          onPressed: () => setState(() => userID = idController.text),
          child: const Text("VERIFY & ENTER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerMarket();
    return _buildCEOOversight();
  }

  Widget _buildProducerEntry() {
    final n = TextEditingController(); final d = TextEditingController();
    return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _catTab("LIVESTOCK"), const SizedBox(width: 8),
          _catTab("CROPS"), const SizedBox(width: 8),
          _catTab("FLEET"),
        ]),
      ),
      const SizedBox(height: 30),
      TextField(controller: n, decoration: InputDecoration(labelText: activeCategory == "FLEET" ? "MACHINE/TRUCK ID" : "ASSET NAME")),
      TextField(controller: d, decoration: InputDecoration(labelText: activeCategory == "LIVESTOCK" ? "WEIGHT (LBS)" : "STATUS/DETAILS")),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          double val = activeCategory == "LIVESTOCK" ? (double.tryParse(d.text) ?? 0) * 1.85 * 1.15 : 0;
          await FirebaseFirestore.instance.collection('enterprise_ledger').add({
            'name': n.text, 'detail': d.text, 'category': activeCategory,
            'value': val, 'status': 'AVAILABLE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
          });
          n.clear(); d.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ENTERPRISE UPLINK SUCCESSFUL")));
        },
        child: const Text("UPLINK TO SYSTEM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ])));
  }

  Widget _catTab(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(
      label: Text(c, style: TextStyle(color: active ? Colors.black : const Color(0xFFC5A059), fontSize: 10)), 
      selected: active, 
      onSelected: (s) => setState(() => activeCategory = c), 
      selectedColor: const Color(0xFFC5A059),
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(side: BorderSide(color: Color(0xFFC5A059))),
    );
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        final docs = snapshot.data!.docs;
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: ListTile(
            title: Text(data['name'], style: const TextStyle(color: Color(0xFFC5A059))),
            subtitle: Text("${data['category']} | SOURCE: ${data['source']}"),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => docs[i].reference.update({'status': 'CLAIMED', 'buyer': userID}), 
              child: const Text("SECURE", style: TextStyle(color: Colors.white))),
          ));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
        double totalValue = 0;
        for (var d in snapshot.data!.docs) { totalValue += (d.data() as Map<String, dynamic>)['value'] ?? 0; }
        
        return Column(children: [
          Container(
            padding: const EdgeInsets.all(20), width: double.infinity, color: const Color(0xFF111111),
            child: Column(children: [
              const Text("TOTAL MARKET PORTFOLIO", style: TextStyle(color: Colors.grey, fontSize: 10)),
              Text("\$${totalValue.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 28, fontWeight: FontWeight.bold)),
            ]),
          ),
          Expanded(child: ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
            final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            return ListTile(
              leading: Icon(data['status'] == 'CLAIMED' ? Icons.check_circle : Icons.radio_button_unchecked, color: const Color(0xFFC5A059)),
              title: Text(data['name']),
              subtitle: Text("SOURCE: ${data['source']} | CAT: ${data['category']}"),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snapshot.data!.docs[i].reference.delete()),
            );
          }))
        ]);
      },
    );
  }
}
