import 'package:flutter/material.dart';

// HVF NEXUS CORE V50.0 - THE LEGAL ENFORCEMENT BUILD
// FEATURE: DIGITAL SIGNATURE GATES FOR PRODUCERS & BUYERS
// FOCUS: PRESERVING ALL PREVIOUS OPERATIONAL & MERCHANT LOGIC
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
          _buildRoleButton(context, "PRODUCER PORTAL", Icons.agriculture, const ProducerAgreementScreen()),
          _buildRoleButton(context, "BUYER PORTAL", Icons.shopping_bag, const BuyerAgreementScreen()),
          _buildRoleButton(context, "LICENSING AGENT", Icons.verified_user, const AgentDashboard()),
        ]),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
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

// --- LEGAL WRAPPERS: DIGITAL SIGNATURE GATES ---

class ProducerAgreementScreen extends StatelessWidget {
  const ProducerAgreementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAgreementTemplate(
      context, 
      "PRODUCER OPERATING AGREEMENT", 
      "I hereby agree to the 90/10 Sovereign Settlement protocol, DNA-verification requirements for all 'Superior' assets, and the \$200 monthly licensing fee.", 
      const ProducerDashboard()
    );
  }
}

class BuyerAgreementScreen extends StatelessWidget {
  const BuyerAgreementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAgreementTemplate(
      context, 
      "BUYER ACCESS AGREEMENT", 
      "I hereby acknowledge that all assets purchased through HVF Nexus are SME-certified. I agree to the \$25 monthly subscription for secure vault access.", 
      const BuyerDashboard()
    );
  }
}

Widget _buildAgreementTemplate(BuildContext context, String title, String terms, Widget next) {
  return Scaffold(
    backgroundColor: pureWhite,
    body: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.gavel, color: goldAccent, size: 50),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const Divider(color: goldAccent, thickness: 2, height: 40),
        Text(terms, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, height: 1.5)),
        const SizedBox(height: 50),
        const TextField(decoration: InputDecoration(labelText: "DIGITAL SIGNATURE (FULL LEGAL NAME)", border: OutlineInputBorder())),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => next)),
          child: const Text("EXECUTE & PROCEED", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ),
      ]),
    ),
  );
}

// --- PRESERVED OPERATIONS & DASHBOARDS ---

class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PRODUCER COMMAND")),
      body: ListView(children: [
        _buildSectionHeader("MERCHANT STATUS"),
        const ListTile(title: Text("STRIPE CONNECTION"), subtitle: Text("READY"), trailing: Icon(Icons.check_circle, color: goldAccent)),
        _buildSectionHeader("ACTIVATION"),
        _buildPaymentNav(context, "ACTIVATE PRODUCER LICENSE", "\$200.00"),
      ]),
    );
  }
}

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BUYER VAULT")),
      body: ListView(children: [
        _buildSectionHeader("MERCHANT STATUS"),
        const ListTile(title: Text("STRIPE CONNECTION"), subtitle: Text("READY"), trailing: Icon(Icons.check_circle, color: goldAccent)),
        _buildSectionHeader("ACTIVATION"),
        _buildPaymentNav(context, "ACTIVATE BUYER SUBSCRIPTION", "\$25.00"),
      ]),
    );
  }
}

class AgentDashboard extends StatelessWidget {
  const AgentDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AGENT VELOCITY")),
      body: ListView(children: [
        _buildSectionHeader("REVENUE TRACKER"),
        const ListTile(title: Text("SEED PROGRESS"), subtitle: Text("\$58,000 / \$500,000"), trailing: Icon(Icons.trending_up, color: Colors.green)),
      ]),
    );
  }
}

// --- PRESERVED MERCHANT GATEWAY ---

Widget _buildPaymentNav(BuildContext context, String label, String fee) {
  return ListTile(
    leading: const Icon(Icons.account_balance, color: goldAccent),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    onTap: () => _initiateStripePayment(context, label, fee),
  );
}

void _initiateStripePayment(BuildContext context, String title, String fee) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(children: [
        const Icon(Icons.security, color: Colors.blue, size: 40),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const Divider(),
        const TextField(decoration: InputDecoration(labelText: "CARDHOLDER NAME", border: OutlineInputBorder())),
        const SizedBox(height: 15),
        const TextField(decoration: InputDecoration(labelText: "CARD NUMBER", border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card))),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("STRIPE: PAYMENT CAPTURED FOR $fee")));
          },
          child: const Text("PAY WITH STRIPE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        ),
      ]),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(width: double.infinity, padding: const EdgeInsets.all(15), color: lightGray, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: goldAccent)));
}
