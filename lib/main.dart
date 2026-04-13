import 'package:flutter/material.dart';

// HVF NEXUS CORE V64.0 - THE APPROVAL FEEDBACK LOOP
// FEATURE: CEO CERTIFIED BADGING & LIVE STATUS UPDATES
// STATUS: DOMINANT UNIFIED BUILD | EXECUTIVE STABILIZATION
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

// --- 3. THE CEO COMMAND DESK ---
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
          _actionCard(context, "INDUCTION: #ANGUS-V77", "Producer: S. Smith | DNA: Verified", Icons.verified_user),
          _actionCard(context, "INDUCTION: #BISON-K02", "Producer: R. Carter | DNA: Pending", Icons.pending),
        ],
      ),
    );
  }

  Widget _actionCard(BuildContext context, String title, String sub, IconData icon) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: ListTile(
        leading: Icon(icon, color: goldAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        onTap: () => _showApprovalSequence(context, title),
      ),
    );
  }

  void _showApprovalSequence(BuildContext context, String title) {
    showModalBottomSheet(
      backgroundColor: deepBlack,
      context: context, 
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.shield, color: goldAccent, size: 50),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ASSET CERTIFIED AS SUPERIOR - MARKETPLACE UPDATED")));
            },
            child: const Text("CERTIFY & PUBLISH", style: TextStyle(color: Colors.white)),
          ),
        ]),
      ),
    );
  }
}

// --- 4. THE BUYER DASHBOARD (WITH CERTIFIED BADGING) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("SME CERTIFIED MARKETPLACE", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _marketTile("ANGUS #044", "\$2,695.00"),
          _marketTile("HEREFORD #102", "\$2,310.00"),
        ],
      ),
    );
  }

  Widget _marketTile(String name, String price) {
    return Card(
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(children: [
          const Icon(Icons.verified, color: goldAccent, size: 14),
          const SizedBox(width: 5),
          const Text("CEO CERTIFIED: SUPERIOR", style: TextStyle(color: goldAccent, fontSize: 10, fontWeight: FontWeight.bold)),
        ]),
        trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      ),
    );
  }
}

// --- 5. THE PRODUCER CONSOLE ---
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
            leading: const Icon(Icons.cloud_upload, color: goldAccent),
            title: const Text("UPLOAD NEW ASSET"),
          )),
        ],
      ),
    );
  }
}
