import 'package:flutter/material.dart';

// HVF NEXUS CORE V56.2 - THE SEAMLESS DEMO INTEGRATION
// FEATURE: UNIFIED BUYER MARKETPLACE & PRODUCER MANAGEMENT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color certificateGold = Color(0xFFD4AF37);

// --- 1. THE SOVEREIGN ENTRANCE ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
                const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: 4)),
                const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, letterSpacing: 2)),
                const SizedBox(height: 50),
                const TextField(decoration: InputDecoration(labelText: "ACCESS ID", border: OutlineInputBorder())),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen())),
                  child: const Text("INITIALIZE SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. THE ROLE FORK ---
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SELECT PORTAL"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            _roleCard(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerDashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerDashboard()),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Widget target) {
    return SizedBox(
      width: 350,
      child: Card(
        color: warmBeige,
        child: ListTile(
          leading: Icon(icon, color: goldAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        ),
      ),
    );
  }
}

// --- 3. THE BUYER VAULT (INTEGRATED) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: const Text("BUYER COMMAND", style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: goldAccent,
            indicatorColor: goldAccent,
            tabs: [
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _BuyerMarketplace(),
            _BuyerVault(),
          ],
        ),
      ),
    );
  }
}

class _BuyerMarketplace extends StatelessWidget {
  const _BuyerMarketplace();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("AVAILABLE SME-GRADE ASSETS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _assetCard(context, "ANGUS #044", "\$2,695.00"),
        _assetCard(context, "HEREFORD #102", "\$2,310.00"),
      ],
    );
  }

  Widget _assetCard(BuildContext context, String name, String price) {
    return Card(
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent)),
        trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      ),
    );
  }
}

class _BuyerVault extends StatelessWidget {
  const _BuyerVault();
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

// --- 4. THE PRODUCER CONSOLE (PRESERVED) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER COMMAND")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("ASSET MANAGEMENT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          _actionTile("UPLOAD NEW ASSET", Icons.add_a_photo),
          _actionTile("SME GRADING STATUS", Icons.analytics),
          const Divider(height: 40),
          const Text("LICENSE: ACTIVE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _actionTile(String label, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: goldAccent),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
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
          decoration: BoxDecoration(color: const Color(0xFFFFFDF7), border: Border.all(color: certificateGold, width: 8)),
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
                  Icon(Icons.shield, color: certificateGold, size: 40),
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
