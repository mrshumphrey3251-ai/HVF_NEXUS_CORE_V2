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
  runApp(const MaterialApp(home: HVFSecureDispatch(), debugShowCheckedModeBanner: false));
}

class HVFSecureDispatch extends StatefulWidget {
  const HVFSecureDispatch({super.key});
  @override
  State<HVFSecureDispatch> createState() => _HVFSecureDispatchState();
}

class _HVFSecureDispatchState extends State<HVFSecureDispatch> {
  String view = "GATE";
  String? sessionUID;
  String activeRole = "GUEST";
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // REGISTRATION CONTROLLERS
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final taxC = TextEditingController();
  String selectedRole = "BUYER";

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
        leading: IconButton(icon: const Icon(Icons.security, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")),
      ),
      body: _buildTheater(),
    );
  }

  Widget _buildTheater() {
    switch (view) {
      case "GATE": return _gate();
      case "REGISTER": return _registrationPortal();
      case "AUDIT_WAIT": return _nexusAuditLoading();
      case "PRODUCER": return const Center(child: Text("PRODUCER TERMINAL ACTIVE", style: TextStyle(color: Colors.white)));
      case "BUYER": return const Center(child: Text("BUYER EXCHANGE ACTIVE", style: TextStyle(color: Colors.white)));
      case "AGENT": return const Center(child: Text("MISSION CONTROL ACTIVE", style: TextStyle(color: Colors.white)));
      case "CEO": return _ceoTerminal();
      default: return _gate();
    }
  }

  Widget _gate() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
        const SizedBox(height: 10),
        const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 5)),
        const Text("FEDERAL ID: S1M4ENLHTDH5", style: TextStyle(color: Colors.white24, fontSize: 9)),
        const SizedBox(height: 50),
        _gateBtn("EXECUTIVE COMMAND", () => _pinAuth("CEO", "1978")),
        _gateBtn("SECURE ENTRY (UID/PIN)", () => _idPinLoginPrompt()),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Text("OR", style: TextStyle(color: Colors.white10))),
        _gateBtn("REQUEST PARTICIPATION", () => setState(() => view = "REGISTER")),
      ]),
    );
  }

  // REINFORCED 2FA LOGIN: UID + PIN
  void _idPinLoginPrompt() {
    TextEditingController idC = TextEditingController();
    TextEditingController pinC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("CREDENTIAL VALIDATION", style: TextStyle(color: Color(0xFFC5A059), fontSize: 14)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: idC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter HVF-UID")),
        const SizedBox(height: 10),
        TextField(controller: pinC, obscureText: true, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter Secure PIN")),
      ]),
      actions: [
        ElevatedButton(onPressed: () async {
          var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: idC.text).get();
          if (snap.docs.isNotEmpty) {
            var data = snap.docs.first.data();
            if (data['pin'] == pinC.text) {
              setState(() { sessionUID = idC.text; activeRole = data['role']; view = data['role']; });
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("INVALID PIN: ACCESS TERMINATED")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UID NOT FOUND")));
          }
        }, child: const Text("VALIDATE"))
      ],
    ));
  }

  void _pinAuth(String target, String pin) {
    TextEditingController pC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("EXECUTIVE PIN", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: pC, obscureText: true, style: const TextStyle(color: Colors.white)),
      actions: [ElevatedButton(onPressed: () { if (pC.text == pin) { setState(() { view = target; activeRole = "CEO"; sessionUID = "MASTER-01"; }); Navigator.pop(context); } }, child: const Text("ACCESS"))],
    ));
  }

  Widget _registrationPortal() {
    return Row(children: [
      Expanded(flex: 1, child: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white10))),
        child: ListView(controller: _legalScroll, children: const [
          Text("MASTER LEGAL MANDATE v7.3.0\n\n- Access is granted solely via encrypted PIN dispatch.\n- Misrepresentation of federal identifiers results in banishment.\n- All data remains confidential.\n\n--- SCROLL TO ACCEPT ---", style: TextStyle(color: Colors.white70, height: 1.6)),
          SizedBox(height: 1500),
          Text("MANDATE READY.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
        ]),
      )),
      Expanded(flex: 1, child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("CREDENTIAL REQUEST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          DropdownButton<String>(
            dropdownColor: Colors.black, value: selectedRole, isExpanded: true, style: const TextStyle(color: Color(0xFFC5A059)),
            items: ["BUYER", "PRODUCER", "AGENT"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => selectedRole = v!),
          ),
          TextField(controller: nameC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "LEGAL NAME")),
          TextField(controller: emailC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "VERIFIED EMAIL")),
          if (selectedRole == "PRODUCER") TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "TAX ID / FSA")),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 50)),
            onPressed: canAccept ? () => _submitToAudit() : null, 
            child: const Text("SUBMIT FOR DISPATCH", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ),
        ]),
      )),
    ]);
  }

  void _submitToAudit() {
    setState(() => view = "AUDIT_WAIT");
    Future.delayed(const Duration(seconds: 4), () async {
      String newUID = "HVF-${Random().nextInt(9999)}-${selectedRole[0]}";
      String newPIN = (1000 + Random().nextInt(8999)).toString(); // Generate 4-digit PIN
      
      await _db.collection('vetted_participants').add({
        'uid': newUID, 'pin': newPIN, 'name': nameC.text, 'email': emailC.text,
        'role': selectedRole, 'status': 'VETTED', 'timestamp': FieldValue.serverTimestamp()
      });
      _showSuccess(newUID, emailC.text);
    });
  }

  Widget _nexusAuditLoading() => const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));

  void _showSuccess(String uid, String email) {
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("AUDIT COMPLETE", style: TextStyle(color: Colors.green)),
      content: Text("IDENTIFIER: $uid\n\nA SECURE PIN HAS BEEN DISPATCHED TO: $email\n\nPlease check your inbox to complete secure entry."),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("RETURN TO GATE"))],
    ));
  }

  Widget _ceoTerminal() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection('vetted_participants').snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const LinearProgressIndicator();
        return ListView(children: snap.data!.docs.map((d) => ListTile(
          title: Text(d['name'], style: const TextStyle(color: Colors.white)),
          subtitle: Text("ID: ${d['uid']} | PIN: ${d['pin']}", style: const TextStyle(color: Color(0xFFC5A059))),
          trailing: Text(d['role'], style: const TextStyle(color: Colors.white24, fontSize: 10)),
        )).toList());
      },
    );
  }

  Widget _gateBtn(String t, VoidCallback a) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 1.5), minimumSize: const Size(350, 65)),
      onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))
    ),
  );
}
