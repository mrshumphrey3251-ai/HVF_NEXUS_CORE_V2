import 'package:flutter/material.dart';

// HVF NEXUS CORE V59.0 - THE COMMAND DESK ACTIVATION
// FEATURE: CEO NOTIFICATION HUB & SME APPROVAL QUEUE
// STATUS: DOMINANT UNIFIED BUILD (STABILIZED)
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

// --- 2. THE ROLE FORK (EXPANDED FOR CEO) ---
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            _roleCard(context, "CEO COMMAND DESK", Icons.admin_panel_settings, const CEODashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerDashboard()),
            const SizedBox(height: 20),
            _roleCard(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerDashboard()),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Widget target) {
    return SizedBox(width: 350, child: Card(color: warmBeige, child: ListTile(
      leading: Icon(icon, color: goldAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
    )));
  }
}

// --- 3. THE CEO COMMAND DESK (NEW) ---
class CEODashboard extends StatelessWidget {
  const CEODashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: deepBlack, title: const Text("CEO COMMAND", style: TextStyle(color: goldAccent)), iconTheme: const IconThemeData(color: goldAccent)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("PENDING SME ACTIONS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 20),
          _notifCard(context, "NEW ASSET INDUCTION", "Producer: Unit #77 - Pending DNA Verification", Icons.biotech),
          _notifCard(context, "EXTENSION REQUEST", "Buyer: ID-404 - Requesting 14-Day Grace", Icons.timer),
          const Divider(color: goldAccent, height: 40),
          const Text("SYSTEM HEALTH", style: TextStyle(color: Colors.white70, fontSize: 12)),
          const ListTile(title: Text("Stripe API Connection", style: TextStyle(color: Colors.white)), trailing: Icon(Icons.check_circle, color: Colors.green, size: 16)),
        ],
      ),
    );
  }

  Widget _notifCard(BuildContext context, String title, String sub, IconData icon) {
    return Card(
      color: const Color(0xFF2A2A2A),
      child: ListTile(
        leading: Icon(icon, color: goldAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        trailing: const Icon(Icons.arrow_forward_ios, color: goldAccent, size: 14),
        onTap: () {},
      ),
    );
  }
}

// --- 4. PRODUCER CONSOLE (RESTORED & FUNCTIONAL) ---
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
          const Text("ASSET INDUCTION", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent)),
          Card(child: ListTile(
            leading: const Icon(Icons.add_a_photo, color: goldAccent),
            title: const Text("UPLOAD NEW ASSET", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AssetInductionScreen())),
          )),
          const Divider(height: 40),
          const Text("LICENSE STATUS: ACTIVE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AssetInductionScreen extends StatelessWidget {
  const AssetInductionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ASSET INDUCTION")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: "BREED", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "DNA TAG ID", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
            onPressed: () => Navigator.pop(context),
            child: const Text("SUBMIT FOR CEO REVIEW", style: TextStyle(color: goldAccent)),
          ),
        ]),
      ),
    );
  }
}

// --- 5. BUYER VAULT (RESTORED & FUNCTIONAL) ---
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
          title: const Text("BUYER VAULT"),
          bottom: const TabBar(labelColor: goldAccent, indicatorColor: goldAccent, tabs: [
            Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
            Tab(text: "MY ASSETS", icon: Icon(Icons.lock)),
          ]),
        ),
        body: const TabBarView(children: [
          _MarketplaceView(),
          _AssetsView(),
        ]),
      ),
    );
  }
}

class _MarketplaceView extends StatelessWidget {
  const _MarketplaceView();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(child: ListTile(
          title: const Text("ANGUS #044", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent)),
          trailing: const Text("\$2,695.00", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        )),
      ],
    );
  }
}

class _AssetsView extends StatelessWidget {
  const _AssetsView();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          tileColor: Colors.white,
          title: const Text("ANGUS UNIT #044"),
          trailing: const Icon(Icons.verified_user, color: goldAccent),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateView())),
        ),
      ],
    );
  }
}

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
          child: const Column(mainAxisSize: MainAxisSize.min, children: [
            Text("HVF - EST. 1880", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent, fontSize: 20)),
            Divider(color: goldAccent),
            Text("CERTIFICATE OF LINEAGE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("PRODUCER", style: TextStyle(fontSize: 10)),
              Icon(Icons.shield, color: goldAccent, size: 40),
              Text("CEO J. HUMPHREY", style: TextStyle(fontSize: 10)),
            ]),
          ]),
        ),
      ),
    );
  }
}
