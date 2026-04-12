import 'package:flutter/material.dart';

// HVF NEXUS CORE V18.0 - THE SME SEAL & CERTIFICATION BUILD
// FEATURE: INTERACTIVE SEALING / DIGITAL CERTIFICATE GENERATION
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF000000); 
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 5)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildLargeHeader("COMMAND CORE"),
              _buildBigButton(context, "SME ADMIN & SEAL", Icons.gavel_rounded, SMEAdminPortal()),
              _buildBigButton(context, "AGENCY DASHBOARD", Icons.groups_3, const PlaceholderScreen("AGENCY")),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, const PlaceholderScreen("FINANCIALS")),
              const SizedBox(height: 40),
              const Text("AUTHORITY STATUS: SEAL READY", 
                style: TextStyle(color: gold, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      color: gold,
      child: Center(
        child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 26)),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold, width: 4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: gold, size: 40),
              const SizedBox(width: 25),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SME ADMIN: THE SEALING STATION ---
class SMEAdminPortal extends StatefulWidget {
  @override
  _SMEAdminPortalState createState() => _SMEAdminPortalState();
}

class _SMEAdminPortalState extends State<SMEAdminPortal> {
  bool isSealed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("SME SEAL STATION", style: TextStyle(color: gold, fontWeight: FontWeight.bold)), backgroundColor: cardGray),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: isSealed ? _buildDigitalCertificate() : _buildAuditChecklist(),
        ),
      ),
    );
  }

  Widget _buildAuditChecklist() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("UNIT #044: BLACK ANGUS", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 40),
        const Icon(Icons.fact_check, color: gold, size: 80),
        const SizedBox(height: 40),
        const Text("READY FOR CEO AUTHORIZATION", style: TextStyle(color: gold, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 60),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 100), shape: const RoundedRectangleBorder()),
          onPressed: () => setState(() => isSealed = true),
          child: const Text("APPLY SME SEAL", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }

  Widget _buildDigitalCertificate() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(border: Border.all(color: gold, width: 10), color: cardGray),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("HVF CERTIFIED", style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 3)),
          const Divider(color: gold, thickness: 3, height: 40),
          const Icon(Icons.verified, color: Colors.green, size: 100),
          const SizedBox(height: 30),
          const Text("UNIT #044", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("SME GRADE: SUPERIOR", style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          const Text("AUTHORIZED BY", style: TextStyle(color: Colors.white38, fontSize: 12)),
          const Text("JEFFERY D. HUMPHREY", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () => setState(() => isSealed = false),
            style: OutlinedButton.styleFrom(side: const BorderSide(color: gold)),
            child: const Text("RESET AUDIT", style: TextStyle(color: gold)),
          )
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: Text(title, style: const TextStyle(color: gold))), body: Center(child: Text("$title SECURE", style: const TextStyle(color: Colors.white, fontSize: 30))));
  }
}
