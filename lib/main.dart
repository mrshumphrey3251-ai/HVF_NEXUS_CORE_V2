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
  runApp(const MaterialApp(home: HVFMasterGate(), debugShowCheckedModeBanner: false));
}

class HVFMasterGate extends StatefulWidget {
  const HVFMasterGate({super.key});
  @override
  State<HVFMasterGate> createState() => _HVFMasterGateState();
}

class _HVFMasterGateState extends State<HVFMasterGate> {
  String view = "GATE";
  String? buyerSession;
  String statusMsg = "READY"; 
  final _db = FirebaseFirestore.instance;

  void _auth(String target, String pin) {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(controller: c, obscureText: true, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () { 
            if (c.text == pin) { setState(() { view = target; statusMsg = "AUTHORIZED"; }); Navigator.pop(context); } 
            else { Navigator.pop(context); }
          }, child: const Text("ACCESS", style: TextStyle(color: Colors.green))),
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
        leading: view != "GATE" ? IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; buyerSession = null; statusMsg = "READY"; })) : null,
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    if (view == "PRODUCER") return _producer();
    if (view == "BUYER") return _buyer();
    if (view == "CEO") return _ceo();
    return _gate();
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.shield, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _btn("CEO COMMAND", () => _auth("CEO", "1978")),
      _btn("PRODUCER DECK", () => _auth("PRODUCER", "2026")),
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
        Text("STATUS: $statusMsg", style: TextStyle(color: statusMsg.contains("FAIL") ? Colors.red : Colors.green, fontSize: 10)),
        TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
        TextField(controller: v, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VITALS")),
        TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE")),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () async {
          if (n.text.isNotEmpty) {
            try {
              await _db.collection('enterprise_ledger').add({
                'name': n.text, 
                'vital': v.text, 
                'price': p.text, 
                'status': 'AVAILABLE',
                'timestamp': FieldValue.serverTimestamp()
              });
              setState(() => statusMsg = "UPLINK SUCCESS");
              n.clear(); v.clear(); p.clear();
            } catch (e) {
              setState(() => statusMsg = "UPLINK FAIL: $e");
            }
          }
        }, child: const Text("UPLINK"))
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('enterprise_ledger').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(children: snap.data!.docs.map((d) => ListTile(
            title: Text(d['name'] ?? "Asset", style: const TextStyle(color: Colors.white)),
            subtitle: Text(d['status'] ?? "", style: const TextStyle(color: Colors.white24)),
          )).toList());
        },
      ))
    ]);
  }

  Widget _buyer() {
    final b = TextEditingController();
    if (buyerSession == null) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("AUTHORIZE BUYER", style: TextStyle(color: Color(0xFFC5A059))),
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
            subtitle: Text("\$${d['price']}"),
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
