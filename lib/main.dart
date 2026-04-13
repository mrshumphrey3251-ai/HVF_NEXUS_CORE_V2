import 'package:flutter/material.dart';

// HVF NEXUS CORE V41.0 - THE PROPRIETARY SETTLEMENT BUILD
// UPDATED: INTERNALIZED 90/10 LOGIC (HIDDEN FROM BUYER)
// FEATURE: SOVEREIGN GUARANTEE & SIMPLIFIED CHECKOUT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

// --- STAGE 1: THE HUMPHREY CREST ---
class HVFCrestSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_rounded, size: 100, color: goldAccent), 
          const SizedBox(height: 20),
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
          const Text("COMMAND ACCESS", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          const TextField(decoration: InputDecoration(labelText: "CEO ACCESS KEY", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoleSelectionScreen())),
            child: const Text("INITIALIZE SYSTEM", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 2: ROLE SELECTION ---
class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SELECT COMMAND ROLE"), backgroundColor: pureWhite, elevation: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, BuyerDashboard()),
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, const PlaceholderScreen("PRODUCER CONSOLE")),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, const PlaceholderScreen("AGENT CONSOLE")),
        ]),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExecutiveSummaryGate(title: title, target: target))),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: lightGray, border: Border.all(color: goldAccent, width: 2)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: goldAccent, size: 30),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}

// --- STAGE 3: EXECUTIVE BRIEFING ---
class ExecutiveSummaryGate extends StatelessWidget {
  final String title;
  final Widget target;
  ExecutiveSummaryGate({required this.title, required this.target});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.description, color: goldAccent, size: 50),
          Text("$title BRIEFING", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Divider(color: goldAccent, thickness: 2, height: 40),
          const Text(
            "Accessing the Sovereign Marketplace requires acknowledgment of HVF Superior Grading standards and secure DNA-verification protocols.",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => target)),
            child: const Text("AUTHORIZE & PROCEED", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 4: THE BUYER EXPERIENCE ---
class BuyerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER VAULT"), backgroundColor: pureWhite, elevation: 0, iconTheme: const IconThemeData(color: deepBlack)),
      body: ListView(children: [
        _buildSectionHeader("SUPERIOR MARKETPLACE"),
        _buildMarketItem(context, "ANGUS UNIT #044", "\$2,695.00", "DNA VERIFIED | SUPERIOR"),
        _buildMarketItem(context, "HEREFORD UNIT #102", "\$2,310.00", "SME GRADE: SUPERIOR"),
      ]),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
  }

  Widget _buildMarketItem(BuildContext context, String name, String price, String status) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: goldAccent, width: 2)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        Text(status, style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold, fontSize: 12)),
        const Divider(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
            onPressed: () => _showCheckoutSheet(context, name, price),
            child: const Text("ACQUIRE ASSET", style: TextStyle(color: goldAccent)),
          )
        ]),
      ]),
    );
  }

  void _showCheckoutSheet(BuildContext context, String name, String price) {
    showModalBottomSheet(context: context, builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      height: 350,
      child: Column(children: [
        const Text("SECURE ACQUISITION", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const SizedBox(height: 10),
        Text("ASSET: $name", style: const TextStyle(color: Colors.black54)),
        const Divider(),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total Purchase Price"), Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
        const SizedBox(height: 10),
        const Text("Price includes DNA-Verification and Sovereign Guarantee.", style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: goldAccent, minimumSize: const Size(double.infinity, 60)),
          onPressed: () => Navigator.pop(context),
          child: const Text("CONFIRM SETTLEMENT", style: TextStyle(color: pureWhite, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        const Icon(Icons.lock_outline, size: 14, color: Colors.black26),
      ]),
    ));
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
