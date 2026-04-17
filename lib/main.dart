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
  runApp(const MaterialApp(home: HVFVaultCore(), debugShowCheckedModeBanner: false));
}

class HVFVaultCore extends StatefulWidget {
  const HVFVaultCore({super.key});
  @override
  State<HVFVaultCore> createState() => _HVFVaultCoreState();
}

class _HVFVaultCoreState extends State<HVFVaultCore> {
  bool hasAcceptedTerms = false;
  String view = "GATE";
  String? buyerID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;
  
  String assetCategory = "LIVESTOCK";
  String selectedState = "OK";
  String mediaStatus = "NO MEDIA ATTACHED";
  final List<String> states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];

  @override
  void initState() {
    super.initState();
    _legalScroll.addListener(() {
      if (_legalScroll.position.pixels >= _legalScroll.position.maxScrollExtent - 20) {
        if (!canAccept) setState(() => canAccept = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasAcceptedTerms) return _marshalFederalGate();
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
        title: const Text("HVF NEXUS CORE", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.w900, letterSpacing: 4)),
        // PERSISTENT RETURN BUTTON
        leading: view != "GATE" ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFC5A059)), 
          onPressed: () => setState(() => view = "GATE")
        ) : null,
        actions: [
          if(view != "GATE") TextButton(
            onPressed: () => setState(() => view = "GATE"),
            child: const Text("EXIT", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: _buildInterface(),
    );
  }

  Widget _marshalFederalGate() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 80),
          const SizedBox(height: 10),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const Text("UEI: S1M4ENLHTDH5 | CAGE: REGISTERED", style: TextStyle(color: Colors.white38, fontSize: 10, fontFamily: 'Courier')),
          const SizedBox(height: 20),
          Expanded(child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.2))),
            child: ListView(controller: _legalScroll, children: const [
              Text("MASTER SERVICE AGREEMENT v5.7.0\n\n"
              "ARTICLE I: PROPRIETARY ASSETS\nAll data is Personal and Confidential. Protected under Federal Patent Law.\n\n"
              "ARTICLE II: MEDIA PROOF\nProducers must uplink digital proof (Photos/Video) to the Sovereign Ledger to verify asset health.\n\n"
              "ARTICLE III: LOGISTICS\nMandatory State/City Node selection for interstate compliance.\n\n"
              "--- SCROLL FULLY TO EXECUTE MANDATE ---", 
              style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.8, fontFamily: 'Courier')),
              SizedBox(height: 1800),
              Text("MANDATE READY.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
            ]),
          )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: canAccept ? () => setState(() => hasAcceptedTerms = true) : null,
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 60), shape: const BeveledRectangleBorder()),
            child: const Text("EXECUTE MANDATE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }

  Widget _buildInterface() {
    switch (view) {
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
      _gateBtn("PRODUCER UPLINK", () => _pinAuth("PRODUCER", "2026")),
      _gateBtn("BUYER EXCHANGE", () => setState(() => view = "BUYER")),
    ]));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pinController = TextEditingController();
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF111111),
      title: Text("AUTHORIZE: $target", style: const TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pinController, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter PIN")),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.white24))),
        ElevatedButton(onPressed: () {
          if (pinController.text == pin) {
            setState(() => view = target);
            Navigator.pop(context);
          }
        }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)), child: const Text("ACCESS", style: TextStyle(color: Colors.black))),
      ],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.all(10),
    child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 70), shape: const BeveledRectangleBorder()), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))),
  );

  Widget _producerTerminal() {
    final n = TextEditingController(), city = TextEditingController(), p = TextEditingController(), a = TextEditingController(), d = TextEditingController();
    return Column(children: [
      Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), child: Column(children: [
        Row(children: [
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: assetCategory, isExpanded: true, style: const TextStyle(color: Colors.white),
            items: ["LIVESTOCK", "EQUIPMENT", "LAND", "SERVICE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => assetCategory = v!),
          )),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: n, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME"))),
        ]),
        Row(children: [
          Expanded(flex: 2, child: TextField(controller: city, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CITY"))),
          const SizedBox(width: 10),
          Expanded(child: DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedState, isExpanded: true, style: const TextStyle(color: Colors.white),
            items: states.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => selectedState = v!),
          )),
        ]),
        TextField(controller: d, maxLines: 2, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "HEALTH & PEDIGREE DETAILS")),
        Row(children: [
          Expanded(child: TextField(controller: p, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PRICE"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: a, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AGENT CODE"))),
        ]),
        const SizedBox(height: 15),
        // MEDIA UPLINK SIMULATOR
        Row(children: [
          Expanded(child: OutlinedButton.icon(
            onPressed: () => setState(() => mediaStatus = "MEDIA_HASH_${Random().nextInt(999999)}_VERIFIED"), 
            icon: const Icon(Icons.camera_enhance, color: Color(0xFFC5A059)), 
            label: Text(mediaStatus == "NO MEDIA ATTACHED" ? "ATTACH PROOF" : "ATTACHED", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10))
          )),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059)),
            onPressed: () {
              if (n.text.isNotEmpty && city.text.isNotEmpty) {
                _db.collection('sovereign_ledger').add({
                  'category': assetCategory, 'name': n.text, 'location': "${city.text}, $selectedState", 
                  'price': double.tryParse(p.text) ?? 0, 'agent': a.text, 'details': d.text,
                  'media': mediaStatus, 'status': 'LIVE', 'timestamp': FieldValue.serverTimestamp()
                });
                n.clear(); city.clear(); p.clear(); a.clear(); d.clear();
                setState(() => mediaStatus = "NO MEDIA ATTACHED");
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET VAULTED")));
              }
            }, 
            child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          )),
        ]),
      ])),
      Expanded(child: _ledgerFeed(true, "ALL"))
    ]);
  }

  Widget _buyerTerminal() {
    if (buyerID == null) {
      final b = TextEditingController();
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.analytics_outlined, color: Color(0xFFC5A059), size: 50),
        const SizedBox(height: 20),
        SizedBox(width: 250, child: TextField(controller: b, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center, decoration: const InputDecoration(hintText: "ENTER FULL NAME"))),
        const SizedBox(height: 20),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5A059), shape: const BeveledRectangleBorder()), onPressed: () {
          if (b.text.isNotEmpty) setState(() => buyerID = b.text);
        }, child: const Text("INITIALIZE PORTFOLIO", style: TextStyle(color: Colors.black)))
      ]));
    }
    return DefaultTabController(length: 2, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "MARKET"), Tab(text: "MY ASSETS")]),
      Expanded(child: TabBarView(children: [_ledgerFeed(false, "LIVE"), _ledgerFeed(false, "SECURED")])),
    ]));
  }

  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').snapshots(),
      builder: (context, snap) {
        double total = 0;
        if (snap.hasData) for (var d in snap.data!.docs) total += (d['price'] as num).toDouble();
        return Column(children: [
          Container(padding: const EdgeInsets.all(20), color: const Color(0xFF0A0A0A), width: double.infinity, child: Column(children: [
            const Text("COMMAND OVERWATCH", style: TextStyle(color: Colors.white38, fontSize: 10)),
            Text("TOTAL AUM: \$${total.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
          Expanded(child: _ledgerFeed(true, "ALL"))
        ]);
      }
    );
  }

  Widget _ledgerFeed(bool isAdmin, String filter) {
    Query query = _db.collection('sovereign_ledger');
    if (filter == "LIVE") query = query.where('status', isEqualTo: 'LIVE');
    if (filter == "SECURED") query = query.where('status', isEqualTo: 'SECURED').where('buyer', isEqualTo: buyerID);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty) return const Center(child: Text("LEDGER EMPTY", style: TextStyle(color: Colors.white10)));
        return ListView(padding: const EdgeInsets.all(15), children: snap.data!.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          bool live = data['status'] == 'LIVE';
          return Card(color: const Color(0xFF0D0D0D), child: ListTile(
            title: Text("${data['name']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${data['location']} | \$${data['price']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10)),
              if(data['details'] != null) Text("DETAILS: ${data['details']}", style: const TextStyle(color: Colors.white38, fontSize: 9)),
              Text("MEDIA: ${data['media']}", style: const TextStyle(color: Colors.cyanAccent, fontSize: 8)),
            ]),
            trailing: isAdmin ? IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => d.reference.delete()) 
            : (live ? ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer': buyerID}), child: const Text("SECURE")) : const Icon(Icons.verified, color: Colors.green)),
          ));
        }).toList());
      },
    );
  }
}
