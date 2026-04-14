import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

// HVF NEXUS CORE V115.0 - MULTI-COMMODITY & DIRECT MEDIA
// FOCUS: PIGS, CHICKENS, & LOCAL STORAGE UPLINK
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

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;
  String activeCategory = "LIVESTOCK";
  String species = "CATTLE"; // Default
  String? uploadedMediaUrl;

  // SOVEREIGN PRICING MATRICES
  Map<String, double> regionalAvg = {"CATTLE": 1.85, "PIGS": 0.75, "CHICKENS": 1.50};
  Map<String, double> dressingPct = {"CATTLE": 0.62, "PIGS": 0.74, "CHICKENS": 0.75};

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
          DropdownButton<String>(
            value: species, dropdownColor: Colors.black, isExpanded: true,
            items: ["CATTLE", "PIGS", "CHICKENS"].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: Color(0xFFC5A059))))).toList(),
            onChanged: (v) => setInternalState(() => species = v!),
          ),
        const SizedBox(height: 20),
        TextField(controller: n, decoration: const InputDecoration(labelText: "ASSET NAME / TAG")),
        TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "LIVE WEIGHT (LBS)"), onChanged: (v) => setInternalState((){})),
        const SizedBox(height: 20),
        
        // DIRECT UPLOAD MOCK (Triggers Browser File Picker)
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red), minimumSize: Size(double.infinity, 50)),
          icon: Icon(Icons.camera_alt, color: Colors.red),
          label: Text("UPLOAD PHOTO/VIDEO PROOF", style: TextStyle(color: Colors.red)),
          onPressed: () => _handleFileUpload(),
        ),
        
        const SizedBox(height: 20),
        if (weight > 0) Container(padding: const EdgeInsets.all(15), color: Colors.white10, child: Column(children: [
          _row("EST. HANGING WT:", "${(weight * (dressingPct[species] ?? 0.62)).toStringAsFixed(1)} LBS"),
          _row("SOVEREIGN FMV (+15%):", "\$${fmv.toStringAsFixed(2)}"),
        ])),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC5A059), minimumSize: Size(double.infinity, 60)),
          onPressed: () async {
            await FirebaseFirestore.instance.collection('enterprise_ledger').add({
              'name': n.text, 'vital1': w.text, 'species': species, 'category': activeCategory,
              'value': fmv, 'status': 'AVAILABLE', 'source': userID, 'timestamp': FieldValue.serverTimestamp(),
            });
            n.clear(); w.clear();
          },
          child: const Text("UPLINK TO EXCHANGE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ])));
    });
  }

  void _handleFileUpload() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*,video/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // In a full production build, this pushes to Firebase Storage.
      // For now, we are triggering the success UI.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("MEDIA READY FOR UPLINK")));
    });
  }

  Widget _row(String l, String v) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 10, color: Colors.grey)), Text(v, style: TextStyle(fontSize: 10, color: Colors.cyan))]);

  Widget _catTab(String c) {
    bool active = activeCategory == c;
    return ChoiceChip(label: Text(c, style: TextStyle(fontSize: 10)), selected: active, onSelected: (s) => setState(() => activeCategory = c), selectedColor: Color(0xFFC5A059));
  }
}
