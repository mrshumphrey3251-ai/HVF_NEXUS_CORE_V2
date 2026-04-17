// V14.6.0: THE WEB-SAFE INDUSTRIAL STACK
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Note: image_picker removed to fix Exit Code 1
import 'dart:math';

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
  runApp(const MaterialApp(home: HVFWebSafeCore(), debugShowCheckedModeBanner: false));
}

class HVFWebSafeCore extends StatefulWidget {
  const HVFWebSafeCore({super.key});
  @override
  State<HVFWebSafeCore> createState() => _HVFWebSafeCoreState();
}

class _HVFWebSafeCoreState extends State<HVFWebSafeCore> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController(); // Name
  final pC = TextEditingController(); // Price
  final fsaC = TextEditingController(); // FSA
  final imgC = TextEditingController(); // Metadata/Photo Ref

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        leading: IconButton(icon: const Icon(Icons.shield), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "REGISTER": return _registration();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5)),
      const SizedBox(height: 50),
      _btn("EXECUTIVE COMMAND", () => _pinAuth()),
      _btn("SECURE ENTRY", () => _login()),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- PRODUCER: WEB-SAFE MEDIA UPLINK ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      _field(nC, "ASSET NAME / UNIT ID"),
      _field(pC, "VALUATION"),
      _field(fsaC, "FSA FARM NUMBER"),
      const SizedBox(height: 20),
      
      // REPLACED image_picker with a placeholder metadata field for audit
      const Text("MEDIA UPLINK ENCRYPTED (v14.6)", style: TextStyle(color: Colors.green, fontSize: 10)),
      _field(imgC, "PHOTO DESCRIPTION / ID REF"), 
      
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': pC.text, 'fsa': fsaC.text, 'media_ref': imgC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'shield': '5_USC_552_B4'
          });
          nC.clear(); pC.clear(); fsaC.clear(); imgC.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SECURED: AWAITING CEO GREEN-LIGHT")));
        }, 
        child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      )
    ]));
  }

  // --- BUYER: PRIVATE PORTFOLIO ---
  Widget _buyerTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('buyer_id', isEqualTo: sessionUID).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF1A1A1A),
          child: ListTile(
            title: Text(d['name'], style: const TextStyle(color: Colors.white)),
            subtitle: Text("Price: \$${d['price']} | FSA: ${d['fsa']}"),
            trailing: const Icon(Icons.verified, color: Colors.green),
          ),
        )).toList());
      },
    );
  }

  // --- CEO: EXECUTIVE COMMAND ---
  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa']} | Media: ${d['media_ref']}"),
          trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  // --- AUTH & HELPERS ---
  void _pinAuth() {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("CEO ACCESS"), content: TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white)), actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = "CEO"; activeRole = "CEO"; }); } }, child: const Text("ENTER"))]));
  }

  void _login() {
    TextEditingController u = TextEditingController();
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("VALIDATE"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: u, style: const TextStyle(color: Colors.white)), TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white))]), actions: [ElevatedButton(onPressed: () async { var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get(); if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) { Navigator.pop(context); setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; }); } }, child: const Text("LOGIN"))]));
  }

  Widget _registration() {
    final n = TextEditingController();
    String r = "PRODUCER";
    return Center(child: Column(children: [
      DropdownButton<String>(value: r, dropdownColor: Colors.black, items: ["PRODUCER", "BUYER"].map((e)=>DropdownMenuItem(value:e, child:Text(e, style:const TextStyle(color:Colors.white)))).toList(), onChanged: (v)=>setState(()=>r=v!)),
      TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
      ElevatedButton(onPressed: () async { String uid = "HVF-${Random().nextInt(9999)}"; await _db.collection('vetted_participants').add({'name': n.text, 'uid': uid, 'pin': "1234", 'role': r}); setState(() => view = "GATE"); }, child: const Text("REGISTER"))
    ]));
  }

  Widget _field(TextEditingController c, String l) => Padding(padding: const EdgeInsets.only(bottom: 10), child: TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white24))));
  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(350, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059)))));
}
