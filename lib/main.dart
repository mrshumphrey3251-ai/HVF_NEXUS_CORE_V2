import 'package:flutter/material.dart';

// HVF NEXUS CORE V28.0 - THE REVENUE FIRST BUILD
// FOCUS: CAPITAL GENERATION VIA PRODUCER/BUYER TRANSACTIONS
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
              _buildLargeHeader("REVENUE ACTIVATION"),
              _buildBigButton(context, "MARKETPLACE: BUY/SELL", Icons.swap_horizontal_circle, BuySellHub()),
              _buildBigButton(context, "PRODUCER ENROLLMENT", Icons.person_add_alt_1, EnrollmentPortal()),
              _buildBigButton(context, "BUYER SUBSCRIPTION", Icons.star_border, BuyerPortal()),
              _buildBigButton(context, "Sovereign Share (10%)", Icons.account_balance_wallet, FinancialCommand()),
              const SizedBox(height: 40),
              const Text("GOAL: \$500,000 SEED CAPITAL", 
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
          decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 3), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent, size: 30), const SizedBox(width: 20), Text(label, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 18))]),
        ),
      ),
    );
  }
}

// --- SECTOR 1: BUY & SELL HUB ---
class BuySellHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("MARKETPLACE", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("LIVE TRANSACTIONS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
        const Divider(color: goldAccent, thickness: 2),
        _buildAssetCard("ANGUS #044", "\$2,450", "Verified SME Grade"),
        _buildAssetCard("ANGUS #091", "\$2,100", "Verified SME Grade"),
      ]),
    );
  }

  Widget _buildAssetCard(String unit, String price, String grade) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      color: lightGray,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(unit, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text(grade, style: const TextStyle(color: goldAccent))]),
        Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.green)),
      ]),
    );
  }
}

// --- SECTOR 2: PRODUCER ENROLLMENT ---
class EnrollmentPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("PRODUCER LICENSING", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text("PRODUCER ACCESS: \$200/MO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 20),
          const Text("LICENSING TERMS:", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("• Unlimited Asset Listings\n• SME 'Superior' Certification Path\n• 90% Direct Settlement Guarantee", textAlign: TextAlign.center),
          const Spacer(),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 80)), onPressed: () {}, child: const Text("ENROLL PRODUCER", style: TextStyle(color: goldAccent, fontSize: 20))),
        ]),
      ),
    );
  }
}

// --- SECTOR 3: BUYER PORTAL ---
class BuyerPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER SUBSCRIPTION", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text("BUYER ACCESS: \$25/MO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: goldAccent)),
          const SizedBox(height: 20),
          const Text("Benefits Include Exclusive Access to SME 'Superior' Grade local livestock and direct-to-farm pricing.", textAlign: TextAlign.center),
          const Spacer(),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: goldAccent, minimumSize: const Size(double.infinity, 80)), onPressed: () {}, child: const Text("ACTIVATE SUBSCRIPTION", style: TextStyle(color: pureWhite, fontSize: 20))),
        ]),
      ),
    );
  }
}

// --- SECTOR 4: FINANCIAL COMMAND ---
class FinancialCommand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("REVENUE TRACKER", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("PLATFORM ACCRUAL (10%)", style: TextStyle(fontWeight: FontWeight.bold)),
        const Text("\$50,000", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: goldAccent)),
        const Text("CURRENT SEED CAPITAL PROGRESS", style: TextStyle(color: Colors.black38)),
        const Padding(
          padding: EdgeInsets.all(40),
          child: LinearProgressIndicator(value: 0.1, backgroundColor: lightGray, color: goldAccent, minHeight: 15),
        ),
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
