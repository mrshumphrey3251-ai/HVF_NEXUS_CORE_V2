import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HVF NEXUS CORE V118.6 - THE BUYER MARKETPLACE
// FOCUS: STEP 4 - OPENING THE EXCHANGE TO THE DISCIPLINED BUYER
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
      appId: "1:892263251736:web:899cc6ab03f6f5e9d82899",
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
      home: const BuyerMarketplace(),
    );
  }
}

class BuyerMarketplace extends StatefulWidget {
  const BuyerMarketplace({super.key});
  @override
  State<BuyerMarketplace> createState() => _BuyerMarketplaceState();
}

class _BuyerMarketplaceState extends State<BuyerMarketplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text(":: HVF GLOBAL EXCHANGE ::", style: TextStyle(color: Color(0xFFC5A059), fontSize: 10, letterSpacing: 2)),
        actions: const [Icon(Icons.shopping_cart_outlined, color: Color(0xFFC5A059), size: 16), SizedBox(width: 15)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('enterprise_ledger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFC5A059)));
          
          return Column(children: [
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: const Color(0xFF111111),
              child: const Text("AVAILABLE DE-RISKED INVENTORY", textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: Colors.grey, letterSpacing: 2)),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final d = snapshot.data!.docs[i].data() as Map<String, dynamic>;
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      border: Border.all(color: Colors.white10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Icon(d['category'] == "FLEET" ? Icons.settings : Icons.pets, color: const Color(0xFFC5A059), size: 14),
                        const Icon(Icons.verified_user, color: Colors.cyan, size: 12),
                      ]),
                      const Spacer(),
                      Text(d['name'] ?? "ASSET", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("${d['type']} | ${d['vital']} ${d['category'] == 'FLEET' ? 'HRS' : 'LBS'}", style: const TextStyle(fontSize: 7, color: Colors.grey)),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC5A059),
                          minimumSize: const Size(double.infinity, 30),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                        ),
                        onPressed: () => _showAssetDetails(d),
                        child: const Text("SECURE ASSET", style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ]);
        },
      ),
    );
  }

  void _showAssetDetails(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("ASSET_ID: ${data['name']}", style: const TextStyle(color: Color(0xFFC5A059), fontSize: 14)),
          const Divider(color: Colors.white10),
          const SizedBox(height: 10),
          _detailRow("SME_CERTIFICATION", "100% VERIFIED", Colors.green),
          _detailRow("HVF_SHIELD_STATUS", "UNDERWRITTEN", Colors.cyan),
          _detailRow("SOURCE_NODE", data['source'] ?? "MASTER_GRID", Colors.grey),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
            onPressed: () => Navigator.pop(context),
            child: const Text("EXECUTE TRANSACTION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }

  Widget _detailRow(String l, String v, Color c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      Text(v, style: TextStyle(fontSize: 8, color: c, fontWeight: FontWeight.bold)),
    ]),
  );
}
