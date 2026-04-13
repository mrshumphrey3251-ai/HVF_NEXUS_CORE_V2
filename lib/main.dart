import 'package:flutter/material.dart';

// HVF NEXUS CORE V66.0 - THE SOVEREIGN SUPPORT BUILD
// FEATURE: BUYER EXTENSION REQUESTS & CEO WAIVER AUTHORITY
// STATUS: DOMINANT UNIFIED BUILD | RELATIONSHIP-BASED ECONOMY
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

// --- 3. THE CEO COMMAND DESK (LIVE QUEUE) ---
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
          const Text("PENDING ACTIONS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 20),
          _queueItem(context, "GRACE PERIOD REQUEST", "Buyer: J. Doe | Asset: Angus-V88 | Reason: Medical", Icons.hourglass_top, true),
          _queueItem(context, "ASSET INDUCTION", "Producer: S. Smith | DNA: Verified", Icons.verified_user, false),
        ],
      ),
    );
  }

  Widget _queueItem(BuildContext context, String title, String sub, IconData icon, bool isUrgent) {
    return Card(
      color: isUrgent ? const Color(0xFF332211) : const Color(0xFF1E1E1E),
      child: ListTile(
        leading: Icon(icon, color: isUrgent ? Colors.orange : goldAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        onTap: () => _showExecutiveDecision(context, title),
      ),
    );
  }

  void _showExecutiveDecision(BuildContext context, String title) {
    showModalBottomSheet(backgroundColor: deepBlack, context: context, builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("CEO WAIVER AUTHORITY", style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900, minimumSize: const Size(double.infinity, 50)),
          onPressed: () => Navigator.pop(context),
          child: const Text("APPROVE 14-DAY WAIVER", style: TextStyle(color: Colors.white)),
        ),
      ]),
    ));
  }
}

// --- 4. BUYER DASHBOARD (WITH SUPPORT TRIGGER) ---
class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("BUYER VAULT")),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("MY SECURED ASSETS", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Card(child: ListTile(
          title: const Text("ANGUS UNIT #V88"),
          subtitle: const Text("Status: Installment Pending", style: TextStyle(color: Colors.red, fontSize: 10)),
          trailing: OutlinedButton(
            onPressed: () => _showExtensionForm(context),
            child: const Text("REQUEST GRACE", style: TextStyle(fontSize: 10, color: Colors.brown)),
          ),
        )),
      ]),
    );
  }

  void _showExtensionForm(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("SOVEREIGN SUPPORT"),
      content: const Text("Request a 14-day payment extension for CEO review?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("SUBMIT REQUEST")),
      ],
    ));
  }
}

// --- 5. PRODUCER CONSOLE (RE-HARDENED) ---
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBeige,
      appBar: AppBar(backgroundColor: warmBeige, title: const Text("PRODUCER COMMAND")),
      body: const Center(child: Text("Induction Engine Active")),
    );
  }
}
