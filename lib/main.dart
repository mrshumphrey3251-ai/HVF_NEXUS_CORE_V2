import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  runApp(const MaterialApp(home: HVFNexusCore(), debugShowCheckedModeBanner: false));
}

class HVFNexusCore extends StatefulWidget {
  const HVFNexusCore({super.key});
  @override
  State<HVFNexusCore> createState() => _HVFNexusCoreState();
}

class _HVFNexusCoreState extends State<HVFNexusCore> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  String? buyerId;
  final _db = FirebaseFirestore.instance;

  void _pinEntry(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
          TextButton(onPressed: () {
            if (c.text == pin) { setState(() => view = target); Navigator.pop(context); }
          }, child: const Text("ENTER")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("HVF NEXUS", style: TextStyle(color: Color(0xFFC5A059)))),
      body: _activeTheater(),
      bottomNavigationBar: view == "GATE" ? null : BottomAppBar(color: const Color(0xFF111111), child: IconButton(icon: const Icon(Icons.lock, color: Colors.red), onPressed: () => setState(() => view = "GATE"))),
    );
  }

  Widget _activeTheater() {
    if (view == "PRODUCER") return _producer();
    if (view == "BUYER") return _buyer();
    if (view == "CEO") return _ceo();
    if (view == "LOGISTICS") return _logistics();
    return _gate();
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 40),
      _gBtn("CEO OVERSIGHT", () => _pinEntry("CEO", "1978")),
      _gBtn("PRODUCER DECK", () => _pinEntry("PRODUCER", "2026")),
      _gBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
      GestureDetector(onLongPress: () => _pinEntry("LOGISTICS", "1776"), child: Container(height: 50, width: 200, color: Colors.transparent)),
    ]));
  }

  Widget _gBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(250, 50)), onPressed: a, child: Text(t, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
  );

  Widget _producer() {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController(), l = TextEditingController();
    return Column(children: [
      Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FMV")),
        TextField(controller: l, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "GPS")),
        ElevatedButton(onPressed: () {
          _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'loc': l.text, 'status': 'AVAILABLE', 'sector': sector});
          n.clear(); v.clear(); p.clear(); l.clear();
        }, child: const Text("UPLINK"))
      ]))
    ]);
  }

  Widget _buyer() {
    final b = TextEditingController();
    if (buyerId == null) return Center(child: Column(children: [
      TextField(controller: b, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "BUYER ID")),
      ElevatedButton(onPressed: () => setState(() => buyerId = b.text), child: const Text("LOGIN"))
    ]));
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("FMV: \$${d['price']}"),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'CLAIMED', 'owner': buyerId}), child: const Text("SECURE")),
        )).toList());
      }
    );
  }

  Widget _logistics() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'CLAIMED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("OWNER: ${d['owner']} | GPS: ${d['loc']}"),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'DONE'}), child: const Text("DELIVERED")),
        )).toList());
      }
    );
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("STATUS: ${d['status']}"),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
        )).toList());
      }
    );
  }
}
