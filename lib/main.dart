import 'package:flutter/material.dart';

// HVF NEXUS CORE V43.1 - THE PRODUCER COMMAND MASTER
// FEATURE: ASSET UPLOAD, SME GRADING TRACKER, & LICENSE ACTIVATION
// FOCUS: INVENTORY ACQUISITION & PRODUCER ONBOARDING
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
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, ProducerDashboard()),
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, const PlaceholderScreen("BUYER VAULT")),
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
            "Accessing the Producer Command Console requires a valid \$200/mo License and adherence to SME Superior Grading standards.",
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

// --- STAGE 4: THE PRODUCER COMMAND CONSOLE ---
class ProducerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("PRODUCER CONSOLE"), backgroundColor: pureWhite, elevation: 0, iconTheme: const IconThemeData(color: deepBlack)),
      body: ListView(children: [
        _buildSectionHeader("ASSET MANAGEMENT"),
        _buildActionTile(context, "UPLOAD NEW ASSET", Icons.add_a_photo, AssetUploadScreen()),
        _buildActionTile(context, "MY INVENTORY (GRADING STATUS)", Icons.analytics, InventoryScreen()),
        _buildSectionHeader("FINANCIALS"),
        _buildActionTile(context, "LICENSE ACTIVATION (\$200)", Icons.credit_card, LicensePaymentScreen()),
        _buildActionTile(context, "SALES LEDGER", Icons.account_balance_wallet, const PlaceholderScreen("SALES")),
      ]),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
  }

  Widget _buildActionTile(BuildContext context, String label, IconData icon, Widget target) {
    return ListTile(
      leading: Icon(icon, color: goldAccent),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
    );
  }
}

// --- PRODUCER SUB-SCREENS ---

class AssetUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NEW ASSET UPLOAD")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          Container(
            height: 200, width: double.infinity, color: lightGray,
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, size: 50, color: goldAccent), Text("TAP TO UPLOAD PICS/VIDEO")]),
          ),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: "ANIMAL ID / BREED", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(decoration: InputDecoration(labelText: "AGE / WEIGHT ESTIMATE", border: OutlineInputBorder())),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.pop(context), 
            child: const Text("SUBMIT FOR SME GRADING", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MY INVENTORY")),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _buildInventoryItem("ANGUS #044", "STATUS: SUPERIOR", Colors.green),
        _buildInventoryItem("HEREFORD #102", "STATUS: PENDING GRADING", goldAccent),
        _buildInventoryItem("ANGUS #091", "STATUS: MEDIA REQUIRED", Colors.red),
      ]),
    );
  }

  Widget _buildInventoryItem(String id, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.info_outline),
      ),
    );
  }
}

class LicensePaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ACTIVATE LICENSE")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          const Text("PRODUCER LICENSE: \$200.00/MO", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 40),
          const TextField(decoration: InputDecoration(labelText: "CARD NUMBER", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const Row(children: [
            Expanded(child: TextField(decoration: InputDecoration(labelText: "EXP", border: OutlineInputBorder()))),
            SizedBox(width: 10),
            Expanded(child: TextField(decoration: InputDecoration(labelText: "CVV", border: OutlineInputBorder()))),
          ]),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
            onPressed: () => Navigator.pop(context), 
            child: const Text("AUTHORIZE \$200 ACTIVATION", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  const PlaceholderScreen(this.t, {super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text("$t SECURE")));
}
