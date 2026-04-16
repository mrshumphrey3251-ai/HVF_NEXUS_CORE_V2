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
    final price = TextEditingController();
    final url = TextEditingController();
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111111),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET")]),
          TextField(controller: name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET / LOT #")),
          TextField(controller: data, style: const TextStyle(color: Colors.greenAccent), decoration: const InputDecoration(labelText: "VITAL DATA")),
          TextField(controller: price, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.yellowAccent), decoration: const InputDecoration(labelText: "FMV VALUE")),
          TextField(controller: url, style: const TextStyle(color: Colors.cyanAccent), decoration: const InputDecoration(labelText: "MEDIA URL")),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), minimumSize: const Size(double.infinity, 50)),
            onPressed: () async {
              if (name.text.isEmpty || double.tryParse(price.text) == null || double.parse(price.text) <= 0) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("INVALID FMV: ASSET NOT UPLINKED")));
                 return;
              }
              await _db.collection('enterprise_ledger').add({
                'name': name.text, 
                'vital': data.text, 
                'price': double.parse(price.text), 
                'media': url.text, 
                'sector': sector, 
                'timestamp': FieldValue.serverTimestamp(), 
                'status': 'AVAILABLE' // INSTANT MARKET ENTRY
              });
              name.clear(); data.clear(); price.clear(); url.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green, content: Text("ASSET LIVE IN MARKETPLACE")));
            },
            child: const Text("UPLINK TO MARKET", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
      const Divider(color: Color(0xFFC5A059)),
      const Padding(padding: EdgeInsets.all(8), child: Text("FARMER'S CURRENT ACTIVE LISTINGS", style: TextStyle(color: Colors.white38, fontSize: 10))),
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
                  subtitle: Text("FMV: \$${doc['price']} | DATA: ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
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
      Container(width: double.infinity, color: Colors.green.withOpacity(0.1), padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.verified_user, color: Colors.green, size: 20), SizedBox(width: 8), Text("MY SECURED ASSETS", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))]),
        ...securedIds.map((id) => FutureBuilder<DocumentSnapshot>(
          future: _db.collection('enterprise_ledger').doc(id).get(),
          builder: (context, snap) {
            if (!snap.hasData) return const SizedBox();
            final data = snap.data!.data() as Map<String, dynamic>;
            return Card(color: const Color(0xFF0D1F0D), margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4), child: ListTile(leading: const Icon(Icons.verified, color: Colors.green), title: Text(data['name'] ?? ""), subtitle: Text("PURCHASE FMV: \$${data['price']}")));
          },
        )).toList(),
      ])),
      Container(height: 40, width: double.infinity, color: const Color(0xFF111111), child: const Center(child: Text("AVAILABLE MARKETPLACE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold, fontSize: 14)))),
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
                    title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("FMV: \$${doc['price']}", style: TextStyle(color: sColor, fontWeight: FontWeight.bold)),
                    children: [
                      Container(padding: const EdgeInsets.all(15), color: Colors.black54, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("FMV: \$${doc['price']}", style: const TextStyle(color: Colors.yellowAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("VITAL DATA: ${doc['vital']}", style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 15),
                        Row(children: [
                          if (doc['media'] != null && doc['media'] != "") Expanded(child: OutlinedButton(onPressed: () => js.context.callMethod('open', [doc['media']]), child: const Text("VIEW PROOF"))),
                          const SizedBox(width: 10),
                          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {
                            snap.data!.docs[i].reference.update({'status': 'CLAIMED'});
                            setState(() => securedIds.add(docId));
                          }, child: const Text("SECURE"))),
                        ])
                      ])),
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
      stream: _db.collection('enterprise_ledger').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        double totalAvailable = 0;
        double totalClaimed = 0;
        for (var doc in snap.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          double p = (data['price'] ?? 0).toDouble();
          if (data['status'] == 'AVAILABLE') totalAvailable += p;
          if (data['status'] == 'CLAIMED') totalClaimed += p;
        }
        return Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF111111),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _finStat("TOTAL FMV INVENTORY", totalAvailable, Colors.orange),
              _finStat("TOTAL FMV LIQUIDATED", totalClaimed, Colors.green),
            ]),
          ),
          const Divider(color: Color(0xFFC5A059), thickness: 2),
          Expanded(
            child: ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (context, i) {
                final doc = snap.data!.docs[i].data() as Map<String, dynamic>;
                final Color statusColor = doc['status'] == 'CLAIMED' ? Colors.green : Colors.orange;
                return Card(
                  color: const Color(0xFF1A1A1A),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ExpansionTile(
                    leading: Icon(_getSectorIcon(doc['sector']), color: _getSectorColor(doc['sector'])),
                    title: Text(doc['name'] ?? "ASSET", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("FMV: \$${doc['price']} | STATUS: ${doc['status']}", style: TextStyle(color: statusColor, fontSize: 12)),
                    trailing: IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
                    children: [
                      Container(padding: const EdgeInsets.all(15), width: double.infinity, color: Colors.black, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text("FINANCIAL AUDIT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
                        Text("ASSET FMV: \$${doc['price']}", style: const TextStyle(color: Colors.yellowAccent)),
                        Text("VITAL DATA: ${doc['vital']}", style: const TextStyle(color: Colors.white70)),
                      ])),
                    ],
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }

  Widget _finStat(String label, double val, Color color) => Column(children: [
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
    Text("\$${val.toStringAsFixed(2)}", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
  ]);
}
