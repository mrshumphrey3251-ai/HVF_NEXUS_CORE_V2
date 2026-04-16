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
  final _db = FirebaseFirestore.instance;
  List<String> securedIds = [];

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
          keyboardType: TextInputType.number,
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ACCESS DENIED")));
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
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.security, color: Color(0xFFC5A059), size: 100),
      const SizedBox(height: 50),
      _gateBtn("CEO OVERSIGHT", () => _challengePin("CEO", "1978")),
      _gateBtn("PRODUCER DECK", () => _challengePin("PRODUCER", "2026")),
      _gateBtn("BUYER MARKET", () => setState(() => view = "BUYER")),
    ]));
  }

  Widget _gateBtn(String l, VoidCallback act) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 3), minimumSize: const Size(300, 75)),
      onPressed: act,
      child: Text(l, style: const TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _producer() {
    final name = TextEditingController();
    final data = TextEditingController();
    final url = TextEditingController();
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111111),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET")
          ]),
          TextField(controller: name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET / LOT #")),
          TextField(controller: data, style: const TextStyle(color: Colors.greenAccent), decoration: const InputDecoration(labelText: "VITAL DATA")),
          TextField(controller: url, style: const TextStyle(color: Colors.cyanAccent), decoration: const InputDecoration(labelText: "MEDIA URL")),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () async {
              if (name.text.isEmpty) return;
              await _db.collection('enterprise_ledger').add({
                'name': name.text, 'vital': data.text, 'media': url.text, 'sector': sector, 'timestamp': FieldValue.serverTimestamp(), 'status': 'AVAILABLE'
              });
              name.clear(); data.clear(); url.clear();
            },
            child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
      const Divider(color: Color(0xFFC5A059)),
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                return ListTile(
                  leading: Icon(_getSectorIcon(doc['sector']), color: _getSectorColor(doc['sector'])),
                  title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
                  subtitle: Text("${doc['sector']} | ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget _tab(String s) => ChoiceChip(label: Text(s), selected: sector == s, onSelected: (b) => setState(() => sector = s));

  Widget _buyer() {
    return Column(children: [
      // --- SECTION 1: THE BUYER VAULT (SECURED) ---
      Container(
        width: double.infinity,
        color: Colors.green.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.verified_user, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text("MY SECURED ASSET VAULT", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ]),
          const Text("CONFIRMED PURCHASES READY FOR LOGISTICS", style: TextStyle(color: Colors.green, fontSize: 10)),
          if (securedIds.isEmpty) const Padding(
            padding: EdgeInsets.all(20),
            child: Text("NO ASSETS SECURED YET", style: TextStyle(color: Colors.white24, fontSize: 12)),
          ),
          ...securedIds.map((id) => FutureBuilder<DocumentSnapshot>(
            future: _db.collection('enterprise_ledger').doc(id).get(),
            builder: (context, snap) {
              if (!snap.hasData) return const SizedBox();
              final data = snap.data!.data() as Map<String, dynamic>;
              return Card(
                color: const Color(0xFF0D1F0D),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ExpansionTile(
                  leading: Icon(_getSectorIcon(data['sector']), color: Colors.green),
                  title: Text(data['name'] ?? "SECURED", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("VITAL DATA: ${data['vital']}", style: const TextStyle(color: Colors.greenAccent, fontSize: 16)),
                        if (data['media'] != null && data['media'] != "") 
                          TextButton(onPressed: () => js.context.callMethod('open', [data['media']]), child: const Text("VIEW FINAL PROOF", style: TextStyle(color: Colors.cyanAccent))),
                      ]),
                    )
                  ],
                ),
              );
            },
          )).toList(),
        ]),
      ),

      // --- SOVEREIGN DIVIDER ---
      Container(
        height: 40,
        width: double.infinity,
        color: const Color(0xFF111111),
        child: const Center(
          child: Text("AVAILABLE ENTERPRISE MARKETPLACE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 2)),
        ),
      ),

      // --- SECTION 2: OPEN MARKETPLACE (AVAILABLE) ---
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _db.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                final docId = snap.data!.docs[i].id;
                Color sColor = _getSectorColor(doc['sector']);
                return Card(
                  color: const Color(0xFF1A1A1A),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ExpansionTile(
                    leading: Icon(_getSectorIcon(doc['sector']), color: sColor),
                    title: Text(doc['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(doc['sector'] ?? "", style: TextStyle(color: sColor.withOpacity(0.7), fontSize: 12)),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.black54,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("VITAL DATA: ${doc['vital']}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                          const SizedBox(height: 15),
                          Row(children: [
                            if (doc['media'] != null && doc['media'] != "") 
                              Expanded(child: OutlinedButton(onPressed: () => js.context.callMethod('open', [doc['media']]), child: const Text("VIEW PROOF"), style: OutlinedButton.styleFrom(foregroundColor: Colors.cyanAccent, side: const BorderSide(color: Colors.cyanAccent)))),
                            const SizedBox(width: 10),
                            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {
                              snap.data!.docs[i].reference.update({'status': 'CLAIMED'});
                              setState(() => securedIds.add(docId));
                            }, child: const Text("SECURE"))),
                          ])
                        ]),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget _ceo() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('enterprise_ledger').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, i) {
            final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
            return ListTile(
              leading: Icon(_getSectorIcon(doc['sector']), color: _getSectorColor(doc['sector'])),
              title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
              subtitle: Text("STATUS: ${doc['status']}"),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
            );
          },
        );
      },
    );
  }
}
