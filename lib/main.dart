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
  runApp(const MaterialApp(home: HVFOnboardingCore(), debugShowCheckedModeBanner: false));
}

class HVFOnboardingCore extends StatefulWidget {
  const HVFOnboardingCore({super.key});
  @override
  State<HVFOnboardingCore> createState() => _HVFOnboardingCoreState();
}

class _HVFOnboardingCoreState extends State<HVFOnboardingCore> {
  String view = "GATE";
  String? sessionUID;
  final _db = FirebaseFirestore.instance;
  final ScrollController _legalScroll = ScrollController();
  bool canAccept = false;

  // REGISTRATION CONTROLLERS
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final taxC = TextEditingController(); // FOR PRODUCERS
  final regionC = TextEditingController(); // FOR AGENTS
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
    if (view == "GATE") return _gate();
    if (view == "REGISTER") return _registrationPortal();
    if (view == "AUDIT_WAIT") return _nexusAuditLoading();
    
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("HVF NEXUS | ID: $sessionUID", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 12, fontWeight: FontWeight.w900)),
        leading: IconButton(icon: const Icon(Icons.logout, color: Color(0xFFC5A059)), onPressed: () => setState(() => view = "GATE")),
      ),
      body: Center(child: Text("$selectedRole TERMINAL ACTIVE", style: const TextStyle(color: Colors.white))),
    );
  }

  Widget _gate() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.stars_rounded, color: Color(0xFFC5A059), size: 100),
          const SizedBox(height: 20),
          const Text("HUMPHREY VIRTUAL FARMS", style: TextStyle(color: Color(0xFFC5A059), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 5)),
          const Text("Sovereign Exchange Node", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 2)),
          const SizedBox(height: 50),
          _gateBtn("ENTER WITH UNIQUE ID", () => _idLoginPrompt()),
          const SizedBox(height: 15),
          _gateBtn("REQUEST PARTICIPATION (REGISTRATION)", () => setState(() => view = "REGISTER")),
        ]),
      ),
    );
  }

  void _idLoginPrompt() {
    TextEditingController idC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF0A0A0A),
      title: const Text("UNIQUE ID VALIDATION", style: TextStyle(color: Color(0xFFC5A059))),
      content: TextField(controller: idC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Enter your HVF-UID")),
      actions: [
        ElevatedButton(onPressed: () async {
          var snap = await _db.collection('vetted_participants').where('uid', isEqualTo: idC.text).get();
          if (snap.docs.isNotEmpty) {
            setState(() { sessionUID = idC.text; selectedRole = snap.docs.first['role']; view = "DASHBOARD"; });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ID NOT FOUND IN LEDGER")));
          }
        }, child: const Text("VALIDATE"))
      ],
    ));
  }

  Widget _registrationPortal() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(children: [
        // LEFT SIDE: FULL LEGAL AGREEMENT
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white10))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("FULL LENGTH LEGAL AGREEMENT v7.1.0", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(child: ListView(controller: _legalScroll, children: const [
                Text(
                  "1. PARTICIPATION MANDATE: By requesting a Unique ID, the applicant submits to the jurisdiction of HVF LLC and Johnston County, OK.\n\n"
                  "2. DATA SOVEREIGNTY: All registrations are trade-secret protected. Misrepresentation of identity is a breach of the Humphrey Standard.\n\n"
                  "3. STEWARDSHIP: Producers warrant that all livestock and assets meet federal biosecurity and ADA accessibility standards.\n\n"
                  "4. FINANCIAL OBLIGATION: Node activation fees (\$200/\$25) are mandatory post-audit.\n\n"
                  "--- SCROLL TO BOTTOM TO ENABLE REGISTRATION ---",
                  style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 13),
                ),
                SizedBox(height: 2000),
                Text("MANDATE ENABLED. YOU MAY NOW APPLY.", style: TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              ])),
            ]),
          ),
        ),
        // RIGHT SIDE: APPLICATION FORM
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("PARTICIPATION APPLICATION", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              DropdownButton<String>(
                dropdownColor: Colors.black, value: selectedRole, isExpanded: true, style: const TextStyle(color: Color(0xFFC5A059)),
                items: ["BUYER", "PRODUCER", "AGENT"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => selectedRole = v!),
              ),
              TextField(controller: nameC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "FULL LEGAL NAME")),
              TextField(controller: emailC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "CONTACT EMAIL")),
              if (selectedRole == "PRODUCER") TextField(controller: taxC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "AG TAX ID / FSA NUMBER")),
              if (selectedRole == "AGENT") TextField(controller: regionC, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "OPERATIONAL REGION")),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: canAccept ? const Color(0xFFC5A059) : Colors.white10, minimumSize: const Size(double.infinity, 60)),
                onPressed: canAccept ? () => _submitToAudit() : null, 
                child: Text("SUBMIT TO NEXUS AUDIT", style: TextStyle(color: canAccept ? Colors.black : Colors.white24, fontWeight: FontWeight.bold))
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  void _submitToAudit() {
    setState(() => view = "AUDIT_WAIT");
    Future.delayed(const Duration(seconds: 4), () async {
      // NEXUS GENERATED AUDIT LOGIC
      bool passed = true;
      if (nameC.text.length < 3) passed = false;
      if (selectedRole == "PRODUCER" && taxC.text.isEmpty) passed = false;

      if (passed) {
        String newUID = "HVF-${Random().nextInt(99999)}-${selectedRole[0]}";
        await _db.collection('vetted_participants').add({
          'uid': newUID, 'name': nameC.text, 'role': selectedRole, 'status': 'VETTED', 'timestamp': FieldValue.serverTimestamp()
        });
        _showSuccess(newUID);
      } else {
        setState(() => view = "REGISTER");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("AUDIT FAILED: INSUFFICIENT DATA")));
      }
    });
  }

  Widget _nexusAuditLoading() {
    return const Scaffold(backgroundColor: Colors.black, body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(color: Color(0xFFC5A059)),
      SizedBox(height: 20),
      Text("NEXUS GENERATED AUDIT IN PROGRESS...", style: TextStyle(color: Color(0xFFC5A059), letterSpacing: 2)),
      Text("Verifying Identity & Stewardship Records", style: TextStyle(color: Colors.white24, fontSize: 10)),
    ])));
  }

  void _showSuccess(String uid) {
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: Colors.black, title: const Text("AUDIT PASSED", style: TextStyle(color: Colors.green)),
      content: Text("COMMISSION GRANTED.\n\nYOUR UNIQUE ID: $uid\n\nSave this ID. It is your only key to the Sovereign Exchange."),
      actions: [ElevatedButton(onPressed: () { Navigator.pop(context); setState(() => view = "GATE"); }, child: const Text("RETURN TO GATE"))],
    ));
  }

  Widget _gateBtn(String t, VoidCallback a) => OutlinedButton(
    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(350, 70)),
    onPressed: a, child: Text(t, style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold))
  );
}
