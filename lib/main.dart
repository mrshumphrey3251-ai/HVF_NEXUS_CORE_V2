import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V115.5 - SECURE SHIELD
// FOCUS: MORTALITY INSURANCE & REPLACEMENT LOGIC
// AUTHORIZED: JEFFERY DONNELL HUMPHREY

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
  runApp(const HVFApp());
}

class HVFApp extends StatelessWidget {
  const HVFApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, fontFamily: 'Courier'),
      home: const HVFShell(),
    );
  }
}

class HVFShell extends StatefulWidget {
  const HVFShell({super.key});
  @override
  State<HVFShell> createState() => _HVFShellState();
}

class _HVFShellState extends State<HVFShell> {
  String? role;
  String? userID;
  bool insuranceOptIn = false;

  @override
  Widget build(BuildContext context) {
    if (role == null) return _buildSovereignGate();
    if (userID == null) return _buildIdentityOnboarding();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFC5A059)), onPressed: () => setState(() { role = null; userID = null; })),
        title: Text(":: $role PORTAL ::", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 11)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSovereignGate() {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.shield, color: Color(0xFFC5A059), size: 60),
        const SizedBox(height: 20),
        const Text("HVF NEXUS CORE V115", style: TextStyle(color: Color(0xFFC5A059), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 4)),
        const SizedBox(height: 40),
        _gateBtn("CEO OVERSIGHT", "CEO"),
        _gateBtn("PRODUCER/AGENT", "PRODUCER"),
        _gateBtn("BUYER/CLIENT", "BUYER"),
      ])),
    );
  }

  Widget _gateBtn(String l, String r) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFC5A059), width: 2), minimumSize: const Size(300, 60)),
      onPressed: () => setState(() => role = r), child: Text(l, style: const TextStyle(color: Color(0xFFC5A059))),
    ));
  }

  Widget _buildIdentityOnboarding() {
    final idController = TextEditingController();
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(40), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("IDENTITY VERIFICATION", style: TextStyle(color: Color(0xFFC5A059))),
        const SizedBox(height: 20),
        TextField(controller: idController, decoration: const InputDecoration(labelText: "NAME / ENTITY ID")),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () => setState(() => userID = idController.text), child: const Text("ACCESS")),
      ])),
    );
  }

  Widget _buildBody() {
    if (role == "PRODUCER") return const Center(child: Text("PRODUCER TOOLS LOCKED"));
    if (role == "BUYER") return _buildBuyerCheckout();
    return _buildCEOOversight();
  }

  // --- BUYER: NOW WITH MORTALITY INSURANCE TOGGLE ---
  Widget _buildBuyerCheckout() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').where('status', isEqualTo: 'AVAILABLE').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          double insCost = data['species'] == "CATTLE" ? 10.0 : 5.0;
          
          return Card(color: const Color(0xFF1A1A1A), margin: const EdgeInsets.all(10), child: Column(children: [
            ListTile(
              title: Text(data['name'], style: const TextStyle(color: Color(0xFFC5A059), fontWeight: FontWeight.bold)),
              subtitle: Text("FMV: \$${(data['value'] ?? 0).toStringAsFixed(2)}"),
            ),
            CheckboxListTile(
              title: const Text("ADD MORTALITY INSURANCE", style: TextStyle(fontSize: 10)),
              subtitle: Text("PROTECT FULL FMV FOR \$${insCost.toStringAsFixed(2)}/MO", style: const TextStyle(fontSize: 8, color: Colors.cyan)),
              value: insuranceOptIn,
              onChanged: (val) => setState(() => insuranceOptIn = val!),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  await snapshot.data!.docs[i].reference.update({
                    'status': 'STEWARDSHIP',
                    'buyer': userID,
                    'insured': insuranceOptIn,
                    'ins_premium': insuranceOptIn ? insCost : 0.0
                  });
                },
                child: const Text("SECURE & PROTECT"),
              ),
            )
          ]));
        });
      },
    );
  }

  Widget _buildCEOOversight() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, i) {
          final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
          bool insured = data['insured'] ?? false;
          return ListTile(
            leading: Icon(Icons.verified_user, color: insured ? Colors.cyan : Colors.grey),
            title: Text(data['name']),
            subtitle: Text("OWNER: ${data['buyer'] ?? 'PENDING'} | INSURED: ${insured ? 'YES' : 'NO'}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => snapshot.data!.docs[i].reference.delete()),
          );
        });
      },
    );
  }
}
