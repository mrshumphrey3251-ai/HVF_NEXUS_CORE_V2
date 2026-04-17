// V14.3.0: THE INDUSTRIAL UPLINK BUILD
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
  runApp(const MaterialApp(home: HVFIndustrialStack(), debugShowCheckedModeBanner: false));
}

class HVFIndustrialStack extends StatefulWidget {
  const HVFIndustrialStack({super.key});
  @override
  State<HVFIndustrialStack> createState() => _HVFIndustrialStackState();
}

class _HVFIndustrialStackState extends State<HVFIndustrialStack> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;

  // Asset Controllers
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final fsaC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
        actions: const [Center(child: Text("5 USC 552(B)(4) ACTIVE   ", style: TextStyle(color: Colors.red, fontSize: 8)))],
        leading: IconButton(icon: const Icon(Icons.logout), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; })),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    switch (view) {
      case "CEO": return _ceo();
      case "PRODUCER": return _producerUplink();
      case "BUYER": return _buyerMarket();
      case "REGISTER": return _register();
      default: return _gate();
    }
  }

  // --- THE GATE ---
  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5)),
      const SizedBox(height: 40),
      _btn("EXECUTIVE COMMAND", () => _pinAuth()),
      _btn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      _btn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- THE PRODUCER UPLINK (THE MISSING LINK) ---
  Widget _producerUplink() {
    return SingleChildScrollView(padding: const EdgeInsets.all(30), child: Column(children: [
      const Text("INDUSTRIAL ASSET UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      _field(nameC, "ASSET NAME / UNIT ID"),
      _field(priceC, "VALUATION (\$)"),
      _field(fsaC, "FSA FARM NUMBER"),
      const SizedBox(height: 30),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 60)),
        onPressed: () async {
          await _db.collection('sovereign_ledger').add({
            'name': nameC.text, 'price': priceC.text, 'fsa': fsaC.text,
            'status': 'PENDING_SORTER', 'producer': sessionUID,
            'timestamp': FieldValue.serverTimestamp()
          });
          nameC.clear(); priceC.clear(); fsaC.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPLINK SECURED: AWAITING CEO AUDIT")));
        }, 
        child: const Text("UPLINK TO SOVEREIGN LEDGER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      )
    ]));
  }

  // --- THE BUYER MARKET ---
  Widget _buyerMarket() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(padding: const EdgeInsets.all(20), children: snap.data!.docs.map((d) => Card(
          color: const Color(0xFF0D0D0D),
          child: ListTile(
            title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
            subtitle: Text("\$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
            trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")),
          ),
        )).toList());
      },
    );
  }

  // --- CEO ---
  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? 'ASSET', style: const TextStyle(color: Colors.white)),
          subtitle: Text("FSA: ${d['fsa']}"),
          trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  // --- HELPERS & AUTH ---
  void _pinAuth() {
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("CEO ACCESS"),
      content: TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (p.text == "1978") { Navigator.pop(context); setState(() { view = "CEO"; activeRole = "CEO"; }); } }, child: const Text("ENTER"))],
    ));
  }

  void _loginDialog() {
    TextEditingController u = TextEditingController();
    TextEditingController p = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("VALIDATE"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: u, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")),
        TextField(controller: p, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN")),
      ]),
      actions: [ElevatedButton(onPressed: () async {
        var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: u.text).get();
        if (snap.docs.isNotEmpty && snap.docs.first['pin'] == p.text) {
          Navigator.pop(context);
          setState(() { sessionUID = u.text; activeRole = snap.docs.first['role']; view = activeRole; });
        }
      }, child: const Text("LOGIN"))],
    ));
  }

  Widget _register() {
    final n = TextEditingController();
    String role = "PRODUCER";
    return Center(child: Column(children: [
      DropdownButton<String>(value: role, dropdownColor: Colors.black, items: ["PRODUCER", "BUYER"].map((e)=>DropdownMenuItem(value:e, child:Text(e, style:const TextStyle(color:Colors.white)))).toList(), onChanged: (v)=>setState(()=>role=v!)),
      TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "NAME")),
      ElevatedButton(onPressed: () async {
        String uid = "HVF-${Random().nextInt(9999)}";
        String pin = "1234";
        await _db.collection('vetted_participants').add({'name': n.text, 'uid': uid, 'pin': pin, 'role': role});
        setState(() => view = "GATE");
      }, child: const Text("REGISTER"))
    ]));
  }

  Widget _field(TextEditingController c, String l) => Padding(padding: const EdgeInsets.only(bottom: 15), child: TextField(controller: c, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white38))));
  Widget _btn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059)), minimumSize: const Size(350, 60)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059)))));
}
