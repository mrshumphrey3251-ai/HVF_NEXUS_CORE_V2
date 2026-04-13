import 'package:flutter/material.dart';

// HVF NEXUS CORE V56.0 - THE UNIFIED COMMAND BUILD
// INTEGRATED: BUYER VAULT & PRODUCER CONSOLE WITH LEGAL GATES
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

// --- 1. THE SOVEREIGN ENTRANCE ---
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
              const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, letterSpacing: 2)),
              const SizedBox(height: 50),
              const TextField(decoration: InputDecoration(labelText: "ACCESS ID", border: OutlineInputBorder())),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen())),
                child: const Text("INITIALIZE SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              ),
            ],
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
      appBar: AppBar(title: const Text("SELECT PORTAL")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _roleCard(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerDashboard()),
          const SizedBox(height: 20),
          _roleCard(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerDashboard()),
        ]),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Widget target) {
    return SizedBox(
      width: 350,
      child: ListTile(
        tileColor: warmBeige,
        leading: Icon(icon, color: goldAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      ),
    );
  }
}

// --- 3. THE PRODUCER CONSOLE ---
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
          _actionTile("90/10 REVENUE SETTLEMENTS", Icons.account_balance_wallet),
          const Divider(height: 40),
          const Text("LICENSE STATUS", style: TextStyle(fontWeight: FontWeight.bold)),
          const ListTile(
            title: Text("Producer License ($200/mo)"),
            subtitle: Text("Status: ACTIVE"),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
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

// --- 4. THE BUYER DASHBOARD (PRESERVED) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.lock, size: 50, color: goldAccent),
          const Text("BUYER ASSETS SECURE", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("RETURN TO COMMAND"),
          )
        ]),
      ),
    );
  }
}
