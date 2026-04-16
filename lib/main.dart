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
        title: Text("HVF NEXUS :: $view", style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
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
      const SizedBox(height: 40),
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
      // ENTRY FORM SECTION
      Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111111),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_tab("LIVESTOCK"), _tab("CROPS"), _tab("FLEET")]),
          TextField(controller: name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME", labelStyle: TextStyle(color: Colors.white54))),
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
      const Divider(color: Color(0xFFC5A059), thickness: 2),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text("MY CURRENT ONLINE INVENTORY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      // FARMER'S VIEW SECTION
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
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
                  subtitle: Text("SECTOR: ${doc['sector']} | VITAL: ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
                  trailing: (doc['media'] != null && doc['media'] != "") 
                    ? IconButton(icon: const Icon(Icons.link, color: Colors.cyanAccent), onPressed: () => js.context.callMethod('open', [doc['media']])) 
                    : null,
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget _tab(String s) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ChoiceChip(label: Text(s), selected: sector == s, onSelected: (b) => setState(() => sector = s), selectedColor: const Color(0xFFC5A059)),
  );

  Widget _buyer() {
    return StreamBuilder<QuerySnapshot>(
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
                subtitle: Text("${doc['sector']} | ${doc['vital']}", style: const TextStyle(color: Colors.white38)),
                trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => snap.data!.docs[i].reference.update({'status': 'CLAIMED'}), child: const Text("SECURE")),
              ),
            );
          },
        );
      },
    );
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
              title: Text(doc['name'] ?? "", style: const TextStyle(color: Colors.white)),
              subtitle: Text("STATUS: ${doc['status']}", style: TextStyle(color: doc['status'] == 'CLAIMED' ? Colors.green : Colors.orange)),
              trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snap.data!.docs[i].reference.delete()),
            );
          },
        );
      },
    );
  }
}
