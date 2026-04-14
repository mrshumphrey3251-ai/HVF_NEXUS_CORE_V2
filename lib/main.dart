import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

// HVF NEXUS CORE V115.1 - MULTI-COMMODITY STABILIZATION
// FOCUS: CATTLE, PIGS, CHICKENS & NATIVE UPLOAD BYPASS
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
  String species = "CATTLE";

  // SOVEREIGN MARKET DATA (OKLAHOMA REGIONAL INDEX)
  final Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  final Map<String, double> dressingPct = {"CATTLE": 0.62, "PIGS": 0.74, "CHICKENS": 0.75};

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() { role = null; userID = null; })),
        title: Text(":: $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.hub, color: Color(0xFFC5A059), size: 60),
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
    final n = TextEditingController(); final w = TextEditingController();
    return StatefulBuilder(builder: (context, setInternalState) {
      double weight = double.tryParse(w.text) ?? 0;
      double avg = regionalAvg[species] ?? 1.85;
      double fmv = weight * avg * 1.15;

      return Padding(padding: const EdgeInsets.all(30), child: SingleChildScrollView(child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [_catTab("LIVESTOCK"), _catTab("CROPS"), _catTab("FLEET")]),
        const SizedBox(height: 20),
        if(activeCategory == "LIVESTOCK") 
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _speciesChip("CATTLE", setInternalState),
            _speciesChip("PIGS", setInternalState),
            _speciesChip("CHICKENS", setInternalState),
          ]),
        const SizedBox(height: 20),
        TextField(controller: n, decoration: const InputDecoration(labelText: "ASSET NAME / TAG")),
        TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "LIVE WEIGHT (LBS)"), 
          onChanged: (v) => setInternalState((){})),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red), minimumSize: const Size(double.infinity, 50)),
          icon: const Icon(Icons.camera_alt, color: Colors.red),
          label: const Text("DIRECT UPLOAD PROOF", style: TextStyle(color: Colors.red)),
          onPressed: () {
            html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
            uploadInput.accept = 'image/*,video/*';
            uploadInput.click();
            uploadInput.onChange.listen((e) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("MEDIA ATTACHED TO ASSET"))));
          },
        ),
        const SizedBox(height: 20),
        if (weight > 0) Container(padding: const EdgeInsets.all(15), color: Colors.white10, child: Column(children: [
          _row("EST. HANGING WT:", "${(weight * (dressingPct[species] ?? 0.62)).toStringAsFixed(1)} LBS"),
          _row("SOVEREIGN FMV:", "\$${fmv.toStringAsFixed(2)}"),
        ])),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
          onPressed: () async {
            await FirebaseFirestore.instance.collection('enterprise_ledger').add({
              'name': n.text, 'vital1': w.text, 'species': species, 'category': activeCategory,
              'value': activeCategory == "LIVESTOCK" ? fmv : 0, 'status': 'AVAILABLE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
            });
            n.clear(); w.clear();
          },
          child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])));
    });
  }

  Widget _speciesChip(String s, Function setStateInternal) {
    bool selected = species == s;
    return ChoiceChip(
      label: Text(s, style: TextStyle(fontSize: 10, color: selected ? Colors.black : Color(0xFFC5A059))),
      selected: selected,
      onSelected: (val) => setStateInternal(() => species = s),
      selectedColor: Color(0xFFC5A059),
    );
  }

  Widget _row(String l, String v) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey)), Text(v, style: const TextStyle(fontSize: 10, color: Colors.cyan))]);

  Widget _catTab(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 10)), selected: active, onSelected: (s) => setState(() => activeCategory = c), selectedColor: const Color(0xFFC5A059));
  }

  Widget _buildBuyerInterface() { return const Center(child: Text("MARKETPLACE ACTIVE")); }
  Widget _buildCEOOversight() { return const Center(child: Text("CEO OVERSIGHT ACTIVE")); }
}
