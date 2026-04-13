import 'package:flutter/material.dart';

// HVF NEXUS CORE V55.2 - THE FAIL-SAFE WEB BUILD
// FIX: REMOVED ALL CUSTOM COMPONENT LAYERING TO CLEAR DART2JS ERRORS
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);

// --- 1. THE CRISP SIGN-IN ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
              const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: 4)),
              const Text("SOVEREIGN ENTRANCE", style: TextStyle(color: goldAccent, letterSpacing: 2)),
              const SizedBox(height: 50),
              const TextField(decoration: InputDecoration(labelText: "BUYER ID", border: OutlineInputBorder())),
              const SizedBox(height: 20),
              const TextField(obscureText: true, decoration: InputDecoration(labelText: "PASSWORD", border: OutlineInputBorder())),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerDashboard())),
                child: const Text("INITIALIZE COMMAND", style: TextStyle(color: goldAccent)),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: () {}, child: const Text("SKIP TO PREVIEW", style: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. THE BUYER DASHBOARD (WARM TRANSITION) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F6F0), // Warm Beige
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F6F0),
          title: const Text("BUYER COMMAND", style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: goldAccent,
            indicatorColor: goldAccent,
            tabs: [
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
              Tab(text: "SUPPORT", icon: Icon(Icons.handshake)),
              Tab(text: "LEGAL", icon: Icon(Icons.gavel)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MarketplaceTab(),
            VaultTab(),
            Center(child: Text("Sovereign Support Active")),
            Center(child: Text("Legal Archive Secure")),
          ],
        ),
      ),
    );
  }
}

// --- TAB VIEWS ---
class MarketplaceTab extends StatelessWidget {
  const MarketplaceTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("SME-GRADE ASSETS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        _assetCard(context, "ANGUS #044"),
        _assetCard(context, "HEREFORD #102"),
      ],
    );
  }

  Widget _assetCard(BuildContext context, String name) {
    return Card(
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("GRADE: SUPERIOR", style: TextStyle(color: goldAccent)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
          onPressed: () {},
          child: const Text("ACQUIRE", style: TextStyle(color: goldAccent)),
        ),
      ),
    );
  }
}

class VaultTab extends StatelessWidget {
  const VaultTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("MY SECURED ASSETS", style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(
          title: const Text("ANGUS UNIT #044"),
          trailing: const Icon(Icons.verified_user, color: goldAccent),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateView())),
        ),
      ],
    );
  }
}

// --- THE CERTIFICATE (SME SEAL) ---
class CertificateView extends StatelessWidget {
  const CertificateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF7),
            border: Border.all(color: goldAccent, width: 8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("HVF - EST. 1880", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent, fontSize: 20)),
              const Divider(color: goldAccent),
              const Text("CERTIFICATE OF LINEAGE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("ASSET: ANGUS #044", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("PRODUCER", style: TextStyle(fontSize: 10)),
                  Icon(Icons.shield, color: goldAccent, size: 40),
                  Text("CEO J. HUMPHREY", style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
