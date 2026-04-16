import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:js' as js;

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
  runApp(const MaterialApp(home: HVFMasterControl(), debugShowCheckedModeBanner: false));
}

class HVFMasterControl extends StatefulWidget {
  const HVFMasterControl({super.key});
  @override
  State<HVFMasterControl> createState() => _HVFMasterControlState();
}

class _HVFMasterControlState extends State<HVFMasterControl> {
  String view = "GATE";
  String sector = "LIVESTOCK";
  String? currentBuyerId; 
  final _db = FirebaseFirestore.instance;

  IconData _getSectorIcon(String? s) {
    switch (s) {
      case "LIVESTOCK": return Icons.pets;
      case "CROPS": return Icons.eco;
      case "FLEET": return Icons.agriculture;
      default: return Icons.inventory;
    }
  }

  Color _getSectorColor(String? s) {
    switch (s) {
      case "LIVESTOCK": return const Color(0xFFC5A059);
      case "CROPS": return Colors.greenAccent;
      case "FLEET": return Colors.blueAccent;
      default: return Colors.white;
    }
  }

  void _challengePin(String targetView, String correctPin) {
    TextEditingController pinCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text("AUTHORIZE: $targetView", style: const TextStyle(color: Color(0xFFC5A059))),
        content: TextField(
          controller: pinCtrl,
          obscureText: true,
          style: const TextStyle(color: Colors.white, fontSize: 30),
          decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC5A059)))),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.red))),
          TextButton(
            onPressed: () {
              if (pinCtrl.text == correctPin) {
                setState(() => view = targetView);
                Navigator.pop(context);
              }
            },
            child: const Text("ACCESS", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      bottomNavigationBar: view == "GATE" ? null : BottomAppBar(
        color: const Color(0xFF111111),
        child: TextButton.icon(
          onPressed: () => setState(() => view = "GATE"),
          icon: const Icon(Icons.lock_outline, color: Colors.red),
          label: const Text("LOCK & EXIT", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: _buildCurrentTheater(),
    );
  }

  Widget _buildCurrentTheater() {
    switch (view) {
      case "PRODUCER": return _producer();
      case "BUYER": return _buyer();
      case "CEO": return _ceo();
      case "LOGISTICS": return _logistics();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 80),
      const SizedBox(height: 30),
      _gateBtn("CEO OVERSIGHT", () => _challengePin("CEO", "1978")),
      _gateBtn("PRODUCER DECK", () => _challengePin("PRODUCER", "2026")),
      _gateBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
      const SizedBox(height: 40),
      GestureDetector(
        onLongPress: () => _challengePin("LOGISTICS", "1776"),
        child: Container(height: 20, width: 100, color: Colors.transparent),
      )
    ]));
  }

  Widget _gateBtn(String l, VoidCallback act) => Padding(
    padding: const EdgeInsets.all(8),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(280, 60)),
      onPressed: act,
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _producer() {
    final name = TextEditingController();
    final data = TextEditingController();
    final price = TextEditingController();
    final loc = TextEditingController();
    final url = TextEditingController();
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111111),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ChoiceChip(label: const Text("LIVESTOCK"), selected: sector == "LIVESTOCK", onSelected: (b) => setState(() => sector = "LIVESTOCK")),
            const SizedBox(width: 5),
            ChoiceChip(label: const Text("CROPS"), selected: sector == "CROPS", onSelected: (b) => setState(() => sector = "CROPS")),
            const SizedBox(width: 5),
            ChoiceChip(label: const Text("FLEET"), selected: sector == "FLEET", onSelected: (b) => setState(() => sector = "FLEET"))
          ]),
          TextField(controller: name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET #")),
          TextField(controller: data, style: const TextStyle(color: Colors.greenAccent), decoration: const InputDecoration(labelText: "VITALS")),
          TextField(controller: price, style: const TextStyle(color: Colors.yellowAccent), decoration: const InputDecoration(labelText: "FMV")),
          TextField(controller: loc, style: const TextStyle(color: Colors.orange), decoration: const InputDecoration(labelText: "GPS (Internal)")),
          TextField(controller: url, style: const TextStyle(color: Colors.cyanAccent), decoration: const InputDecoration(labelText: "MEDIA URL")),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () async {
              if (name.text.isEmpty) return;
              await _db.collection('enterprise_ledger').add({
                'name': name.text, 'vital': data.text, 'price': double.tryParse(price.text) ?? 0.0, 'location': loc.text,
                'media': url.text, 'sector': sector, 'timestamp': FieldValue.serverTimestamp(), 'status': 'AVAILABLE'
              });
              name.clear(); data.clear(); price.clear(); loc.clear(); url.clear();
            },
            child: const Text("UPLINK ASSET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                return ListTile(title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)));
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget _buyer() {
    final idCtrl = TextEditingController();
    return Column(children: [
      if (currentBuyerId == null) Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF1A1A1A),
        child: Column(children: [
          const Text("AUTHORIZE BUYER IDENTITY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextField(controller: idCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ENTER BUYER NAME OR ID")),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () => setState(() => currentBuyerId = idCtrl.text), child: const Text("ACCESS VAULT")),
        ]),
      ) else Column(children: [
        Container(
          width: double.infinity,
          color: Colors.green.withOpacity(0.1),
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text("VAULT: $currentBuyerId", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            StreamBuilder<QuerySnapshot>(
              stream: _db.collection('enterprise_ledger').where('buyer_id', isEqualTo: currentBuyerId).snapshots(),
              builder: (context, snap) {
                if (!snap.hasData || snap.data!.docs.isEmpty) return const Text("NO SECURED ASSETS", style: TextStyle(color: Colors.white24));
                return Column(children: snap.data!.docs.map((d) => ListTile(dense: true, title: Text(d['name'] ?? "", style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.verified, color: Colors.green))).toList());
              },
            ),
            TextButton(onPressed: () => setState(() => currentBuyerId = null), child: const Text("LOGOUT", style: TextStyle(color: Colors.red))),
          ]),
        ),
        const Divider(color: Color(0xFFC5A059)),
      ]),
      if (currentBuyerId != null) Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                return Card(
                  color: const Color(0xFF1A1A1A),
                  child: ListTile(
                    title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("FMV: \$${doc['price']}"),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () => snap.data!.docs[i].reference.update({'status': 'CLAIMED', 'buyer_id': currentBuyerId}),
                      child: const Text("SECURE"),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget _logistics() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'CLAIMED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, i) {
            final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
            return Card(
              color: const Color(0xFF0D0D1F),
              child: ListTile(
                title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
                subtitle: Text("FOR: ${doc['buyer_id']}\nLOC: ${doc['location']}"),
                trailing: ElevatedButton(onPressed: () => snap.data!.docs[i].reference.update({'status': 'COMPLETED'}), child: const Text("DONE")),
              ),
            );
          },
        );
      },
    );
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        double total = 0;
        for (var doc in snap.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          if (data['status'] == 'AVAILABLE') total += (data['price'] ?? 0).toDouble();
        }
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF111111), child: Center(child: Text("TOTAL FMV: \$${total.toStringAsFixed(2)}", style: const TextStyle(color: Colors.orange, fontSize: 18)))),
          Expanded(
            child: ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
                  subtitle: Text("STATUS: ${doc['status']} | OWNER: ${doc['buyer_id'] ?? 'NONE'}"),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
                );
              },
            );
          },
        );
      },
    );
  }
}
