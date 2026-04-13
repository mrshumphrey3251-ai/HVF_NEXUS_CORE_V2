import 'package:flutter/material.dart';

// HVF NEXUS CORE V51.0 - THE BUYER EXPERIENCE & SOVEREIGN RELATIONSHIP
// FEATURE: FULL LEGAL SCROLL, WATERMARKED "WARM" UI, MULTI-TAB RELATIONSHIP MGMT
// FOCUS: TRANSITION FROM CRISP COMMAND TO INCLUSIVE LEGACY
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFC5A059)),
    home: const HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color pureWhite = Color(0xFFFFFFFF);
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0); // For the "Warm" inclusive transition

// --- STAGE 1: PLAIN CRISP SIGN-IN ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
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
          const TextField(decoration: InputDecoration(labelText: "BUYER ID", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerLegalGate())),
            child: const Text("INITIALIZE SESSION", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 2: FULL LEGAL DOCUMENT GATE ---
class BuyerLegalGate extends StatelessWidget {
  const BuyerLegalGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(title: const Text("BUYER MASTER AGREEMENT"), backgroundColor: pureWhite, elevation: 0),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("HVF SOVEREIGN BUYER TERMS & CONDITIONS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              const SizedBox(height: 20),
              const Text(
                "Article I: SME Standards Acknowledgment\nThe Buyer acknowledges that all livestock available through the Humphrey Virtual Farms Nexus is graded under strict SME (Subject Matter Expert) protocols. The 'Superior' grade represents the pinnacle of genetic and physical health standards...\n\n"
                "Article II: The 90/10 Protocol\nBuyer understands that their purchase facilitates a direct 90% payout to the Producer, maintaining the economic sovereignty of the farming community...\n\n"
                "Article III: Subscription Liability\nThe \$25/mo fee covers the digital vault, lineage tracking, and real-time sponsorship access. Non-payment results in vault suspension...",
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: 40),
              const Divider(thickness: 2),
              const Text("DIGITAL SIGNATURE", style: TextStyle(fontWeight: FontWeight.bold)),
              const TextField(decoration: InputDecoration(hintText: "Enter Full Legal Name", border: UnderlineInputBorder())),
              const SizedBox(height: 20),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BuyerMainDashboard())),
            child: const Text("EXECUTE & ENTER VAULT", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
        )
      ]),
    );
  }
}

// --- STAGE 3: WARM INCLUSIVE DASHBOARD (WATERMARKED) ---
class BuyerMainDashboard extends StatelessWidget {
  const BuyerMainDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          elevation: 0,
          title: const Text("BUYER COMMAND", style: TextStyle(color: deepBlack, fontWeight: FontWeight.w900)),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: goldAccent,
            unselectedLabelColor: Colors.black54,
            indicatorColor: goldAccent,
            tabs: [
              Tab(text: "LEGAL & CONCERNS", icon: Icon(Icons.gavel)),
              Tab(text: "SME STANDARDS", icon: Icon(Icons.verified)),
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY ASSETS", icon: Icon(Icons.inventory)),
            ],
          ),
        ),
        body: Stack(
          children: [
            // THE CRISP HUMPHREY CREST WATERMARK
            Center(
              child: Opacity(
                opacity: 0.05,
                child: Icon(Icons.shield_rounded, size: MediaQuery.of(context).size.width * 0.8, color: goldAccent),
              ),
            ),
            // THE TAB CONTENT
            const TabBarView(
              children: [
                _LegalAndConcernsTab(),
                _SMEStandardsTab(),
                _MarketplaceTab(),
                _MyAssetsTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- TAB SUB-VIEWS ---

class _LegalAndConcernsTab extends StatelessWidget {
  const _LegalAndConcernsTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("LEGAL DOCUMENTS & RECOURSE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const ListTile(leading: Icon(Icons.file_copy, color: goldAccent), title: Text("View Signed Master Agreement")),
        const ListTile(leading: Icon(Icons.privacy_tip, color: goldAccent), title: Text("Privacy & Sovereignty Policy")),
        const Divider(),
        const Text("FILE CONCERNS / COMPLAINTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const TextField(maxLines: 4, decoration: InputDecoration(hintText: "Enter your concern for SME Review...", border: OutlineInputBorder())),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: deepBlack), child: const Text("SUBMIT TO CEO", style: TextStyle(color: goldAccent))),
      ],
    );
  }
}

class _SMEStandardsTab extends StatelessWidget {
  const _SMEStandardsTab();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("PRODUCER EXCELLENCE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Text("Acknowledging the exceptional standards upheld by the Producer. Every animal under the HVF banner meets the following:"),
        ListTile(leading: Icon(Icons.check, color: Colors.green), title: Text("Full Lineage DNA Verification")),
        ListTile(leading: Icon(Icons.check, color: Colors.green), title: Text("Sustainable Ranching Protocols")),
        ListTile(leading: Icon(Icons.check, color: Colors.green), title: Text("SME-Grade Health Certifications")),
      ]),
    );
  }
}

class _MarketplaceTab extends StatelessWidget {
  const _MarketplaceTab();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("ANIMALS AVAILABLE FOR SPONSORSHIP OR PURCHASE", style: TextStyle(fontWeight: FontWeight.bold)));
  }
}

class _MyAssetsTab extends StatelessWidget {
  const _MyAssetsTab();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("VIEW MY ANIMALS / VAULT", style: TextStyle(fontWeight: FontWeight.bold)));
  }
}
