import 'package:flutter/material.dart';

// HVF NEXUS CORE V12.3 - THE DEFINITIVE CLEAN BUILD
// RESOLVED: MULTIPLE DECLARATIONS & CURRENCY STRING ERRORS
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HVFCommandDashboard(),
  ));
}

const Color gold = Color(0xFFFFD700);
const Color bgBlack = Color(0xFF0A0A0A);
const Color cardGray = Color(0xFF1A1A1A);

class HVFCommandDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, letterSpacing: 4)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceLockBanner(),
              const SizedBox(height: 30),
              _buildSovereignButton(context, "SME RAPID AUDIT", Icons.fact_check, SMEAdminPortal()),
              const SizedBox(height: 15),
              _buildSovereignButton(context, "VIRTUAL STOCKYARD", Icons.account_balance, LivestockMarketplace()),
              const SizedBox(height: 15),
              _buildSovereignButton(context, "FINANCIAL AUDIT", Icons.analytics, AuditLedger()),
              const SizedBox(height: 40),
              const Text("90/10 REVENUE ARCHITECTURE: ACTIVE", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const Text("DATA TRANSPARENCY: ABSOLUTE", 
                style: TextStyle(color: Colors.white24, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceLockBanner() {
    return Container(
      width: double.infinity,
      color: gold.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Text("LEGACY LOCK: \$25 BUYER / \$200 PRODUCER", 
          style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSovereignButton(BuildContext context, String label, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: cardGray, 
          foregroundColor: gold, 
          minimumSize: const Size(double.infinity, 80),
          side: const BorderSide(color: gold, width: 1),
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
    );
  }
}

// --- SME RAPID AUDIT ---
class SMEAdminPortal extends StatefulWidget {
  @override
  _SMEAdminPortalState createState() => _SMEAdminPortalState();
}

class _SMEAdminPortalState extends State<SMEAdminPortal> {
  bool isSuperior = false;
  bool isCalm = false;
  bool isPrime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("RAPID AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("UNIT #091 INSPECTION", style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(color: gold, height: 30),
            SwitchListTile(
              title: const Text("SUPERIOR FRAME", style: TextStyle(color: Colors.white)),
              value: isSuperior,
              activeColor: gold,
              onChanged: (v) => setState(() => isSuperior = v),
            ),
            SwitchListTile(
              title: const Text("CALM TEMPERAMENT", style: TextStyle(color: Colors.white)),
              value: isCalm,
              activeColor: gold,
              onChanged: (v) => setState(() => isCalm = v),
            ),
            SwitchListTile(
              title: const Text("HVF PRIME STATUS", style: TextStyle(color: Colors.white)),
              value: isPrime,
              activeColor: gold,
              onChanged: (v) => setState(() => isPrime = v),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 60)),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SME SEAL AUTHORIZED")));
              },
              child: const Text("AUTHORIZE & SEAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

// --- VIRTUAL STOCKYARD ---
class LivestockMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold.withOpacity(0.2))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("BLACK ANGUS UNIT #001", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Weight: 1,450 lbs", style: TextStyle(color: Colors.white70)),
                Divider(color: Colors.white10, height: 20),
                Text("SME SEAL ACTIVE: TOTAL DISCLOSURE GUARANTEED", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("DIET: Grass Fed / HEALTH: All Vax Current", style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- AUDIT LEDGER ---
class AuditLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIAL AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("SOVEREIGN REVENUE DATA SECURE", style: TextStyle(color: Colors.white))),
    );
  }
}
