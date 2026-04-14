import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

// HVF NEXUS CORE V114.4 - FMV MARKET LOCKDOWN
// FOCUS: RESTORING FAIR MARKET VALUE & REGIONAL INDEX
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
  String buyerView = "MARKET";

  // SOVEREIGN MARKET DATA (OKLAHOMA REGIONAL INDEX)
  final double regionalAvgLive = 1.85; 
  final double hvfPremiumRate = 1.15; // 15% CEO PREMIUM

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() { role = null; userID = null; })),
        title: Text(":: $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
        actions: [IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() { role = null; userID = null; }))],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.account_balance, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER/AGENT", "PRODUCER"),
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
        const Text("IDENTITY VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "NAME / ENTITY")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("INITIALIZE")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return _buildProducerEntry();
    if (role == "BUYER") return _buildBuyerInterface();
    return _buildCEOOversight();
  }

  Widget _buildProducerEntry() {
    final n = TextEditingController(); final d1 = TextEditingController(); final d2 = TextEditingController(); final v = TextEditingController();
    return StatefulBuilder(builder: (context, setInternalState) {
      double liveWt = double.tryParse(d1.text) ?? 0;
      double fmv = liveWt * regionalAvgLive * hvfPremiumRate;

      return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [_catTab("LIVESTOCK"), const SizedBox(width: 8), _catTab("CROPS"), const SizedBox(width: 8), _catTab("FLEET")]),
        const SizedBox(height: 30),
        TextField(controller: n, decoration: InputDecoration(labelText: activeCategory == "CROPS" ? "CROP VARIETY" : "ASSET NAME")),
        TextField(controller: d1, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: activeCategory == "LIVESTOCK" ? "LIVE WEIGHT (LBS)" : "PRIMARY VITAL"), 
          onChanged: (v) => setInternalState(() {})),
        TextField(controller: d2, decoration: InputDecoration(labelText: activeCategory == "LIVESTOCK" ? "VACCINATION STATUS" : "SECONDARY VITAL")),
        TextField(controller: v, decoration: const InputDecoration(labelText: "VIDEO URL", icon: Icon(Icons.videocam, color: Colors.red))),
        const SizedBox(height: 20),
        if (activeCategory == "LIVESTOCK" && liveWt > 0) 
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: Colors.cyan)), child: Column(children: [
            _row("EST. HANGING WEIGHT:", "${(liveWt * 0.62).toStringAsFixed(1)} LBS"),
            _row("SOVEREIGN FMV:", "\$${fmv.toStringAsFixed(2)}"),
          ])),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () async {
            await FirebaseFirestore.instance.collection('enterprise_ledger').add({
              'name': n.text, 'vital1': d1.text, 'vital2': d2.text, 'category': activeCategory, 'video': v.text,
              'value': activeCategory == "LIVESTOCK" ? fmv : 0, 'status': 'AVAILABLE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
            });
            n.clear(); d1.clear(); d2.clear(); v.clear();
          },
          child: const Text("UPLINK ASSET WITH FMV", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])));
    });
  }

  Widget _row(String l, String v) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey)), Text(v, style: const TextStyle(fontSize: 10, color: Colors.cyan))]);

  Widget _catTab(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(label: Text(c), selected: active, onSelected: (s) => setState(() => activeCategory = c), selectedColor: Color(0xFFC5A059));
  }

  Widget _buildBuyerInterface() {
    return Column(children: [
      Row(children: [
        Expanded(child: InkWell(onTap: () => setState(() => buyerView = "MARKET"), child: Container(padding: const EdgeInsets.all(15), color: buyerView == "MARKET" ? const Color(0xFFC5A059) : Colors.transparent, child: Center(child: Text("MARKETPLACE", style: TextStyle(color: buyerView == "MARKET" ? Colors.black : Colors.grey)))))),
        Expanded(child: InkWell(onTap: () => setState(() => buyerView = "PORTFOLIO"), child: Container(padding: const EdgeInsets.all(15), color: buyerView == "PORTFOLIO" ? const Color(0xFFC5A059) : Colors.transparent, child: Center(child: Text("MY ASSETS", style: TextStyle(color: buyerView == "PORTFOLIO" ? Colors.black : Colors.grey)))))),
      ]),
      Expanded(child: buyerView == "MARKET" ? _buildBuyerMarket() : _buildBuyerPortfolio())
    ]);
  }

  Widget _buildBuyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: ListTile(
            title: Text(data['name'], style: const TextStyle(color: Color(0xFFC5A059))),
            subtitle: Text("FMV: \$${(data['value'] ?? 0).toStringAsFixed(2)} | WT: ${data['vital1']}"),
            trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => snapshot.data!.docs[i].reference.update({'status': 'CLAIMED', 'buyer': userID}), child: const Text("SECURE")),
          ));
        });
      },
    );
  }

  Widget _buildBuyerPortfolio() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('buyer', isEqualTo: userID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          return Card(color: const Color(0xFF111111), margin: const EdgeInsets.all(10), child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(data['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("SECURED AT FMV: \$${(data['value'] ?? 0).toStringAsFixed(2)}"),
            trailing: data['video'] != "" ? IconButton(icon: const Icon(Icons.play_circle, color: Colors.red), onPressed: () => html.window.open(data['video'], '_blank')) : null,
          ));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        double totalValue = 0;
        for (var d in snapshot.data!.docs) { totalValue += (d.data() as Map<String, dynamic>)['value'] ?? 0; }
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), width: double.infinity, color: const Color(0xFF111111), child: Column(children: [
            const Text("TOTAL ENTERPRISE FMV", style: TextStyle(color: Colors.grey, fontSize: 10)),
            Text("\$${totalValue.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
          Expanded(child: ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
            final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            return ListTile(
              leading: Icon(Icons.circle, color: data['status'] == 'CLAIMED' ? Colors.green : Colors.orange, size: 12),
              title: Text("${data['name']} | \$${(data['value'] ?? 0).toStringAsFixed(2)}"),
              subtitle: Text("AGENT: ${data['source']} | CAT: ${data['category']}"),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snapshot.data!.docs[i].reference.delete()),
            );
          }))
        ]);
      },
    );
  }
}
