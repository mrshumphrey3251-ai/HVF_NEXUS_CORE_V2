// HVF NEXUS MASTER V1.0 - SOVEREIGN DEPLOYMENT
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  runApp(const MaterialApp(home: HVFMasterSystem(), debugShowCheckedModeBanner: false));
}

class HVFMasterSystem extends StatefulWidget {
  const HVFMasterSystem({super.key});
  @override
  State<HVFMasterSystem> createState() => _HVFMasterSystemState();
}

class _HVFMasterSystemState extends State<HVFMasterSystem> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Controllers
  final nC = TextEditingController();
  final pC = TextEditingController();
  final fC = TextEditingController();
  final lC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        title: Text("HUMPHREY VIRTUAL FARMS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
        actions: const [Center(child: Text("5 USC 552(B)(4) SECURED   ", style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)))],
      ),
      body: _buildOperationalView(),
      bottomNavigationBar: view == "GATE" ? null : Container(
        color: Colors.black,
        padding: const EdgeInsets.all(10),
        child: const Text("MATTHEW 25:41–46 (KJV)", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFC5A059), fontSize: 9, fontStyle: FontStyle.italic)),
      ),
    );
  }

  Widget _buildOperationalView() {
    switch (view) {
      case "CEO": return _ceoDashboard();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerVault();
      case "REGISTER": return _onboarding();
      default: return _gate();
    }
  }

  // --- THE COMMAND GATE ---
  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 120),
      const Text("HVF NEXUS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 12)),
      const SizedBox(height: 60),
      _cmdBtn("EXECUTIVE COMMAND", () => _ceoAuth()),
      _cmdBtn("SECURE ENTRY", () => _login()),
      _cmdBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- PRODUCER TERMINAL ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(35), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 30),
      _input(nC, "ASSET NAME"),
      _input(pC, "VALUATION (\$)"),
      _input(fC, "FSA FARM NUMBER"),
      _input(lC, "MEDIA LINK (PHOTO/DOC)"),
      const SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 65)),
        onPressed: () {
          _db.collection('sovereign_ledger').add({
            'name': nC.text, 'price': pC.text, 'fsa': fC.text, 'media': lC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID, 'timestamp': FieldValue.serverTimestamp()
          });
          nC.clear(); pC.clear(); fC.clear(); lC.clear();
        },
        child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )
    ]));
  }

  // --- BUYER VAULT ---
  Widget _buyerVault() {
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), labelColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY ASSETS")]),
      Expanded(child: TabBarView(children: [
        _stream('LIVE'),
        _stream('SECURED', isPersonal: true),
      ])),
    ]));
  }

  Widget _stream(String stat, {bool isPersonal = false}) {
    Query q = _db.collection('sovereign_ledger').where('status', isEqualTo: stat);
    if (isPersonal) q = q.where('buyer_id', isEqualTo: sessionUID);
    return StreamBuilder<QuerySnapshot>(
      stream: q.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.white10), borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("VALUE: \$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
            trailing: stat == 'LIVE' 
              ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")) 
              : const Icon(Icons.verified, color: Colors.green),
          ),
        )).toList());
      },
    );
  }

  // --- CEO DASHBOARD ---
  Widget _ceoDashboard() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) => ListTile(
          tileColor: const Color(0xFF0D0D0D),
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa']} | Media: ${d['media']}"),
          trailing: IconButton(icon: const Icon(Icons.check_circle_outline, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  // --- ONBOARDING ---
  Widget _onboarding() {
    final t = TextEditingController();
    String r = "PRODUCER";
    return Center(child: Container(width: 350, padding: const EdgeInsets.all(25), decoration: BoxDecoration(border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(10)), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text("REQUEST COMMISSION", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      DropdownButton<String>(value: r, dropdownColor: Colors.black, isExpanded: true, items: ["PRODUCER", "BUYER"].map((e)=>DropdownMenuItem(value:e, child:Text(e, style:const TextStyle(color:Colors.white)))).toList(), onChanged: (v)=>setState(()=>r=v!)),
      _input(t, "FULL NAME"),
      ElevatedButton(onPressed: () async {
        String uid = "HVF-${Random().nextInt(9999)}";
        await _db.collection('vetted_participants').add({'name': t.text, 'uid': uid, 'pin': "1234", 'role': r});
        setState(() => view = "GATE");
      }, child: const Text("GENERATE CREDENTIALS"))
    ])));
  }

  // --- LOGIC ---
  void _ceoAuth() {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("EXECUTIVE ACCESS", style: TextStyle(color: Color(0xFFC5A059))), content: TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white)), actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = "CEO"; activeRole = "CEO"; }); } }, child: const Text("ACCESS"))]));
  }

  void _login() {
    TextEditingController u = TextEditingController();
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Colors.black, title: const Text("SECURE VALIDATION"), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: u, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")), TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN"))]), actions: [ElevatedButton(onPressed: () async {
      var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get();
      if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) {
        Navigator.pop(context);
        setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; });
      }
    }, child: const Text("ENTER"))]));
  }

  Widget _input(TextEditingController c, String l) => Padding(padding: const EdgeInsets.only(bottom: 15), child: TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white38), enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)))));
  Widget _cmdBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, letterSpacing: 2))));
}
