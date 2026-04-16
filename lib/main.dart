import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: HVFLaunchWrapper(), debugShowCheckedModeBanner: false));
}

class HVFLaunchWrapper extends StatelessWidget {
  const HVFLaunchWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAPLSeGUyBXWHUDzGDTPULGnFs11EbPpO0",
          authDomain: "hvf-nexus.firebaseapp.com",
          projectId: "hvf-nexus",
          storageBucket: "hvf-nexus.firebasestorage.app",
          messagingSenderId: "892263251736",
          appId: "1:892263251736:web:899cc6ab03f6f5e9d8286d",
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Scaffold(body: Center(child: Text("CONNECTION ERROR: ${snapshot.error}", style: const TextStyle(color: Colors.red))));
        if (snapshot.connectionState == ConnectionState.done) return const HVFNexusFinal();
        return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Color(0xFFC5A059))));
      },
    );
  }
}

class HVFNexusFinal extends StatefulWidget {
  const HVFNexusFinal({super.key});
  @override
  State<HVFNexusFinal> createState() => _HVFNexusFinalState();
}

class _HVFNexusFinalState extends State<HVFNexusFinal> {
  String view = "GATE";
  String? buyerSession;
  final _db = FirebaseFirestore.instance;

  void _authorize(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () { if (c.text == pin) { setState(() => view = target); Navigator.pop(context); } }, child: const Text("ACCESS", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        actions: [if(view != "GATE") IconButton(icon: const Icon(Icons.power_settings_new, color: Colors.red), onPressed: () => setState(() => view = "GATE"))],
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "PRODUCER": return _producer();
      case "BUYER": return _buyer();
      case "CEO": return _ceo();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.shield, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _btn("CEO COMMAND", () => _authorize("CEO", "1978")),
      _btn("PRODUCER DECK", () => _authorize("PRODUCER", "2026")),
      _btn("BUYER MARKET", () => setState(() => view = "BUYER")),
    ]));
  }

  Widget _btn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(280, 60)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold))
    ),
  );

  Widget _producer() {
    final n = TextEditingController(), v = TextEditingController(), p = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Column(children: [
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE")),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {
          _db.collection('enterprise_ledger').add({'name': n.text, 'vital': v.text, 'price': p.text, 'status': 'AVAILABLE'});
          n.clear(); v.clear(); p.clear();
        }, child: const Text("UPLINK"))
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const SizedBox();
          return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)))).toList());
        },
      ))
    ]);
  }

  Widget _buyer() {
    final b = TextEditingController();
    if (buyerSession == null) return Center(child: Column(children: [
      const SizedBox(height: 50),
      const Text("ENTER BUYER ID", style: TextStyle(color: Colors.white)),
      SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
      ElevatedButton(onPressed: () => setState(() => buyerSession = b.text), child: const Text("ACCESS"))
    ]));
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: [
          ListTile(title: Text("BUYER: $buyerSession", style: const TextStyle(color: Colors.green))),
          ...snap.data!.docs.map((d) => ListTile(
            title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)),
            subtitle: Text("PRICE: \$${d['price']}"),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'CLAIMED', 'buyer': buyerSession}), child: const Text("SECURE")),
          )).toList()
        ]);
      },
    );
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)),
          subtitle: Text("STATUS: ${d['status']}"),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()),
        )).toList());
      },
    );
  }
}
