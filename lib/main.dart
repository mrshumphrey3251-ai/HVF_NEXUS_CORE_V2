import 'package:flutter/material.dart';

// HVF NEXUS CORE V27.1 - THE REVENUE ENGINE FINALIZED
// FIXED: REMOVED ALL INVALID CONST CONSTRUCTORS
// FEATURE: BUY/SELL HUB / SOVEREIGN SETTLEMENT LOGIC
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
              _buildLargeHeader("MARKET OPERATIONS"),
              _buildBigButton(context, "BUY & SELL HUB", Icons.swap_horizontal_circle, BuySellHub()),
              _buildBigButton(context, "SLAB ROAD MASTER PLAN", Icons.architecture, PlaceholderScreen("SITE PLAN")),
              _buildBigButton(context, "BIO-ASSET LEDGER", Icons.analytics, PlaceholderScreen("BIO-DATA")),
              _buildBigButton(context, "FINANCIAL COMMAND", Icons.payments, PlaceholderScreen("FINANCE")),
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
        child: Container(
          height: 85,
          decoration: BoxDecoration(color: pureWhite, border: Border.all(color: goldAccent, width: 3), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: goldAccent, size: 30), const SizedBox(width: 20), Text(label, style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900, fontSize: 18))]),
        ),
      ),
    );
  }
}

class BuySellHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUY / SELL HUB", style: TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack), elevation: 0),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text("ACTIVE MARKET LISTINGS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
        const SizedBox(height: 10),
        _buildTradeCard("ANGUS UNIT #044", "OFFER: \$2,450", "SELLER: SMITH FARMS", true),
        _buildTradeCard("ANGUS UNIT #102", "OFFER: \$2,100", "SELLER: DOE RANCH", false),
        const SizedBox(height: 30),
        const Text("SETTLEMENT LOGIC (90/10)", style: TextStyle(fontWeight: FontWeight.bold, color: goldAccent)),
        Container(
          padding: const EdgeInsets.all(20),
          color: lightGray,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Producer Share (90%)"), const Text("\$2,205.00", style: TextStyle(fontWeight: FontWeight.bold))]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("HVF Platform (10%)"), Text("\$245.00", style: const TextStyle(fontWeight: FontWeight.bold, color: goldAccent))]),
          ]),
        ),
      ]),
    );
  }

  Widget _buildTradeCard(String unit, String price, String seller, bool isSMEVerified) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: isSMEVerified ? goldAccent : Colors.grey.shade300, width: 2)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(unit, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
          if (isSMEVerified) const Icon(Icons.verified, color: goldAccent),
        ]),
        Text(seller, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.green)),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
            child: const Text("EXECUTE BUY", style: TextStyle(color: goldAccent)),
          )
        ]),
      ]),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String t;
  PlaceholderScreen(this.t, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: pureWhite, appBar: AppBar(title: Text(t, style: const TextStyle(color: deepBlack)), backgroundColor: pureWhite, iconTheme: const IconThemeData(color: deepBlack)), body: Center(child: Text("$t SECURE", style: const TextStyle(fontSize: 30))));
  }
}
