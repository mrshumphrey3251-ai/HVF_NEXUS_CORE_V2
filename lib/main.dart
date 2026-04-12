import 'package:flutter/material.dart';

// HVF NEXUS CORE V26.0 - THE DEEP DENSITY BUILD
// FEATURE: INTEGRATED SITE SPECS / BIO-ASSET DNA / CAPEX LEDGER
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
              _buildLargeHeader("SOVEREIGN COMMAND CENTER"),
              _buildBigButton(context, "SLAB ROAD MASTER PLAN", Icons.architecture, SlabRoadPlan()),
              _buildBigButton(context, "BIO-ASSET LEDGER (DNA)", Icons.analytics, BioAssetLedger()),
              _buildBigButton(context, "CAPEX & SEED FUNDING", Icons.account_balance, CapExLedger()),
              _buildBigButton(context, "SME PRIVATE CHANNEL", Icons.security, const PlaceholderScreen("SECURE")),
              const SizedBox(height: 40),
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
        child: Container(height: 85, decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 3), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent, size: 30), const SizedBox(width: 20), Text(label, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 18))]),
        ),
      ),
    );
  }
}

// --- SECTOR 1: SLAB ROAD MASTER PLAN ---
class SlabRoadPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("SLAB ROAD SPECS", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("200-ACRE FLAGSHIP", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
        _buildSpecRow("RESIDENTIAL", "200 UNITS (VETERAN FOCUS)"),
        _buildSpecRow("HYDROLOGY", "25-ACRE ENGINEERED LAKE"),
        _buildSpecRow("POWER", "94.2 kW HELIOGRID ARRAY"),
        _buildSpecRow("TRANSIT", "AUTONOMOUS PATHWAY V1"),
        const SizedBox(height: 20),
        const Text("This blueprint establishes the 'Bona Fide' agricultural status required for Johnston County zoning.", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
      ]),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
      ]),
    );
  }
}

// --- SECTOR 2: BIO-ASSET LEDGER ---
class BioAssetLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BIO-ASSET DNA", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _buildBioCard("ANGUS UNIT #044", "AGE: 24 MO | WT: 1250 LBS", "DNA: VERIFIED | GRADE: SUPERIOR"),
        _buildBioCard("ANGUS UNIT #091", "AGE: 18 MO | WT: 1050 LBS", "DNA: PENDING | GRADE: AWAITING SME"),
      ]),
    );
  }

  Widget _buildBioCard(String id, String specs, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      color: lightGray,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(id, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        Text(specs, style: const TextStyle(color: Colors.black54)),
        const Divider(color: goldAccent),
        Text(status, style: const TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

// --- SECTOR 3: CAPEX LEDGER ---
class CapExLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("CAPEX LEDGER", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("SEED ROUND ALLOCATION (\$500,000)", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const SizedBox(height: 20),
        _buildExpense("INFRASTRUCTURE", "\$250,000", "LAKE & POWER"),
        _buildExpense("40-CITY TOUR", "\$150,000", "AGENCY ACTIVATION"),
        _buildExpense("NEXUS HARDENING", "\$100,000", "SERVER & IP"),
        const Divider(color: deepBlack, thickness: 3),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("TOTAL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
          Text("\$500,000", style: TextStyle(color: goldAccent, fontWeight: FontWeight.w900, fontSize: 22)),
        ]),
      ]),
    );
  }

  Widget _buildExpense(String label, String amount, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(sub, style: const TextStyle(fontSize: 12, color: Colors.black38)),
        ]),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
      ]),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  PlaceholderScreen(this.t, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: Text(t, style: const TextStyle(color: deepBlack)), backgroundColor: pureWhite), body: Center(child: Text("$t SECURE", style: const TextStyle(fontSize: 30))));
  }
}
