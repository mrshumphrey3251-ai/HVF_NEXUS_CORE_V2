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
  runApp(const MaterialApp(home: HVFIroncladDeployment(), debugShowCheckedModeBanner: false));
}

class HVFIroncladDeployment extends StatefulWidget {
  const HVFIroncladDeployment({super.key});
  @override
  State<HVFIroncladDeployment> createState() => _HVFIroncladDeploymentState();
}

class _HVFIroncladDeploymentState extends State<HVFIroncladDeployment> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // SYSTEM CONTROLLERS
  final nC = TextEditingController();
  final pC = TextEditingController();
  final dC = TextEditingController();
  final fsaC = TextEditingController();
  final taxC = TextEditingController();
  final yrC = TextEditingController(); // Years in Op
  final cityC = TextEditingController();
  final statsC = TextEditingController();
  final goalC = TextEditingController();
  bool isAda = false;
  bool isBio = false;

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
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: view == "GATE" ? null : AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | $activeRole | $sessionUID", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 10, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.shield, color: Color(0xFFC5A059)), onPressed: () => setState(() { view = "GATE"; activeRole = "GUEST"; sessionUID = null; })),
        actions: const [Center(child: Text("STATUTORY PROTECTION ACTIVE   ", style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold)))],
      ),
      body: _buildActiveTheater(),
    );
  }

  Widget _buildActiveTheater() {
    switch (view) {
      case "REGISTER": return _jurisdictionalOnboarding();
      case "CEO": return _ceoTerminal();
      case "PRODUCER": return _producerTerminal();
      case "BUYER": return _buyerTerminal();
      case "AGENT": return _agentTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
      const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 5)),
      const SizedBox(height: 50),
      _gateBtn("EXECUTIVE COMMAND", () => _pinAuth()),
      _gateBtn("SECURE ENTRY (UID/PIN)", () => _loginDialog()),
      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
      _gateBtn("REQUEST COMMISSION", () => setState(() => view = "REGISTER")),
    ]));
  }

  // --- REGISTRATION: THE LEGAL FIREWALL ---
  Widget _jurisdictionalOnboarding() {
    return Row(children: [
      Expanded(child: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white10))),
        child: ListView(controller: _legalScroll, children: const [
          Text("MASTER SERVICE AGREEMENT v11.0.0\n\n"
          "ARTICLE I: SOVEREIGNTY\nAll data is Proprietary/Trade Secret under 5 U.S.C. § 552(b)(4).\n\n"
          "ARTICLE II: STEWARDSHIP\nProducers warrant 100% ADA compliance. Minimum 24 months operational history required.\n\n"
          "--- SCROLL TO BOTTOM TO UNLOCK APPLICATION ---", style: TextStyle(color: Colors.white70, height: 1.6)),
          SizedBox(height: 1500),
          Text("MANDATE READY.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        ]),
      )),
      Expanded(child: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(children: [
            const Text("PARTICIPANT COMMISSION REQUEST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "LEGAL NAME")),
            TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "TAX ID / SSN")),
            TextField(controller: yrC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "YEARS IN OPERATION")),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 50)),
              onPressed: canAccept ? () => _submitAudit() : null, 
              child: const Text("SUBMIT TO AUDIT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
            ),
          ]),
        ),
      )),
    ]);
  }

  void _submitAudit() async {
    String role = "PRODUCER"; // Logic for role selection can be added
    String uid = "HVF-${Random().nextInt(9999)}-X";
    String pin = (1000 + Random().nextInt(8999)).toString();
    await _db.collection('vetted_participants').add({'name': nC.text, 'uid': uid, 'pin': pin, 'role': role, 'yrs': yrC.text});
    _showSuccess(uid, pin);
  }

  void _showSuccess(String u, String p) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("AUDIT PASSED", style: TextStyle(color: Colors.green)),
      content: Text("UID: $u\nPIN: $p\n\nKeep these secure. Credentials dispatched to ledger."),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("DONE"))],
    ));
  }

  // --- TERMINALS ---
  Widget _producerTerminal() {
    return SingleChildScrollView(padding: const EdgeInsets.all(25), child: Column(children: [
      const Text("INDUSTRIAL UPLINK", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
      TextField(controller: nC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "ASSET NAME")),
      TextField(controller: pC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: r"VALUATION ($)")),
      TextField(controller: dC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "PEDIGREE")),
      TextField(controller: fsaC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FSA NUMBER")),
      CheckboxListTile(title: const Text("ADA COMPLIANT", style: TextStyle(color: Colors.white70)), value: isAda, onChanged: (v)=>setState(()=>isAda=v!), activeColor: const Color(0xFFC5A059)),
      ElevatedButton(onPressed: () {
        _db.collection('sovereign_ledger').add({'name': nC.text, 'price': pC.text, 'details': dC.text, 'fsa': fsaC.text, 'status': 'PENDING_SORTER', 'producer': sessionUID});
        nC.clear(); pC.clear(); dC.clear(); fsaC.clear();
      }, child: const Text("UPLINK"))
    ]));
  }

  Widget _buyerTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'LIVE').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("\$${d['price']}", style: const TextStyle(color: Color(0xFFC5A059))),
          trailing: ElevatedButton(onPressed: () => d.reference.update({'status': 'SECURED', 'buyer_id': sessionUID}), child: const Text("SECURE")),
        )).toList());
      },
    );
  }

  Widget _agentTerminal() {
    return Column(children: [
      Container(padding: const EdgeInsets.all(30), color: const Color(0xFF0A0A0A), width: double.infinity, child: Column(children: [
        const Text("ESTIMATED RESIDUALS (10%)", style: TextStyle(color: Colors.white38, fontSize: 10)),
        const Text("\$0.00", style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)),
      ])),
      const Expanded(child: Center(child: Text("TOUR TICKER ACTIVE", style: TextStyle(color: Colors.white10)))),
    ]);
  }

  Widget _ceoTerminal() {
    return DefaultTabController(length: 3, child: Column(children: [
      const TabBar(indicatorColor: Color(0xFFC5A059), tabs: [Tab(text: "ASSETS"), Tab(text: "TOUR"), Tab(text: "LEDGER")]),
      Expanded(child: TabBarView(children: [
        _ceoAssetReview(),
        _ceoTourReview(),
        _ceoLidView(),
      ])),
    ]));
  }

  Widget _ceoAssetReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('sovereign_ledger').where('status', isEqualTo: 'PENDING_SORTER').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          trailing: IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => d.reference.update({'status': 'LIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoTourReview() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('tour_calendar').where('status', isEqualTo: 'PROPOSED').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['city'], style: const TextStyle(color: Colors.white)),
          trailing: IconButton(icon: const Icon(Icons.bolt, color: Colors.green), onPressed: () => d.reference.update({'status': 'ACTIVE'})),
        )).toList());
      },
    );
  }

  Widget _ceoLidView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'] ?? "USER", style: const TextStyle(color: Colors.white)),
          subtitle: Text("UID: ${d['uid']} | PIN: ${d['pin']}"),
        )).toList());
      },
    );
  }

  // --- HELPERS ---
  void _pinAuth() {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CEO ACCESS"),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == "1978") { setState(() { view = "CEO"; activeRole = "CEO"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  void _loginDialog() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("VALIDATE"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: idC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "UID")),
        TextField(controller: pinC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "PIN")),
      ]),
      actions: [ElevatedButton(onPressed: () async {
        var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: idC.text).get();
        if (snap.docs.isNotEmpty && snap.docs.first['pin'] == pinC.text) {
          setState(() { sessionUID = idC.text; activeRole = snap.docs.first['role']; view = activeRole; });
          Navigator.pop(context);
        }
      }, child: const Text("LOGIN"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(padding: const EdgeInsets.all(8), child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)), onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))));
}
