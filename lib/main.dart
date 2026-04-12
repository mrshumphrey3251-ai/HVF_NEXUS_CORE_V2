import 'package:flutter/material.dart';

// HVF NEXUS CORE V25.1 - THE CAPITAL INTEGRITY BUILD
// FIXED: DOLLAR SIGN ESCAPING / CONST CONSTRUCTOR PURGE
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light),
    home: HVFCommandDashboard(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color lightGray = Color(0xFFF5F5F5);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pureWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 30, letterSpacing: 4)),
          backgroundColor: pureWhite,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLargeHeader("EXECUTIVE SUMMARY"),
              _buildBigButton(context, "INVESTOR PORTAL", Icons.monetization_on, InvestorPortal()),
              _buildBigButton(context, "SME PRIVATE CHANNEL", Icons.security, SMEDirectPortal()),
              _buildBigButton(context, "VIRTUAL STOCKYARD", Icons.agriculture, PlaceholderScreen("STOCKYARD")),
              _buildBigButton(context, "SITE MAP & INFRA", Icons.map, PlaceholderScreen("SITE MAP")),
              const SizedBox(height: 40),
              // ESCAPED DOLLAR SIGN FOR COMPILER SAFETY
              const Text("SEED ROUND: ACTIVE (\$500,000)", 
                style: TextStyle(color: goldAccent, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: lightGray,
      child: Center(
        child: Text(title, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 22)),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: pureWhite, 
            border: Border.all(color: goldAccent, width: 3),
            boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: goldAccent, size: 30),
              const SizedBox(width: 20),
              Text(label, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- INVESTOR HUB ($500K SEED ROUND) ---
class InvestorPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("INVESTOR HUB", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(25), children: [
        const Text("SEED ROUND FUNDING", style: TextStyle(color: deepBlack, fontSize: 24, fontWeight: FontWeight.w900)),
        const Text("TARGET: \$500,000", style: TextStyle(color: goldAccent, fontSize: 32, fontWeight: FontWeight.w900)),
        const SizedBox(height: 20),
        _buildInfoCard("USE OF FUNDS", "• Finalize 200-Unit Slab Road Infrastructure\n• 40-City Promotional Activation\n• Nexus Core V2 Server Hardening"),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
          onPressed: () {},
          child: const Text("REQUEST PITCH DECK", style: TextStyle(color: goldAccent, fontSize: 18, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }

  Widget _buildInfoCard(String label, String content) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      color: lightGray,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
        const SizedBox(height: 10),
        Text(content, style: const TextStyle(color: deepBlack, fontSize: 15, height: 1.4)),
      ]),
    );
  }
}

// --- SME PRIVATE CHANNEL ---
class SMEDirectPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SME DIRECT", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.security, color: goldAccent, size: 80),
          const SizedBox(height: 20),
          const Text("SECURE CEO LINE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          const Text("Authorized VIP Access Only", style: TextStyle(color: Colors.black45)),
          const SizedBox(height: 40),
          _buildContactRow(Icons.phone, "PRIORITY VOICE"),
          _buildContactRow(Icons.message, "ENCRYPTED TEXT"),
        ]),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: goldAccent.withOpacity(0.3))),
      child: Row(children: [
        Icon(icon, color: goldAccent),
        const SizedBox(width: 20),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ]),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  PlaceholderScreen(this.t, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite, 
      appBar: AppBar(title: Text(t, style: const TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: Center(child: Text("$t SECURE", style: const TextStyle(color: deepBlack, fontSize: 30))),
    );
  }
}
