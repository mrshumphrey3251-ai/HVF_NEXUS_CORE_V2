Timport 'package:flutter/material.dart';

// HVF NEXUS CORE V55.1 - WEB-STABILIZED DEMO
// FIX: REMOVED ASSET-DEPENDENT FONTS & REDUNDANT STACK OVERLAYS
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC5A059)),
    ),
    home: const HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color certificateGold = Color(0xFFD4AF37);

// --- 1. THE CRISP SIGN-IN ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
            const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
            const Text("SOVEREIGN ENTRANCE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            const SizedBox(width: 400, child: TextField(decoration: InputDecoration(labelText: "BUYER ID", border: OutlineInputBorder()))),
            const SizedBox(height: 40),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerLegalGate())),
                child: const Text("INITIALIZE SESSION", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerDashboard(isGuest: true))),
              child: const Text("SKIP TO PREVIEW", style: TextStyle(color: Colors.grey)),
            ),
          ]),
        ),
      ),
    );
  }
}

// --- 2. THE LEGAL GATE ---
class BuyerLegalGate extends StatelessWidget {
  const BuyerLegalGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MASTER AGREEMENT"), surfaceTintColor: Colors.white),
      body: Column(children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Text(
              "HVF SOVEREIGN BUYER TERMS & CONDITIONS\n\n"
              "Article I: SME Standards\nThe Buyer acknowledges that all livestock available through the Nexus is graded under strict SME protocols. The 'Superior' grade represents the pinnacle of genetic standards...\n\n"
              "Article II: 90/10 Protocol\nFacilitating direct 90% payout to Producers...\n\n"
              "Article III: Digital Signature\nThis document constitutes a binding agreement between the entity and Humphrey Virtual Farms LLC.",
              style: TextStyle(height: 1.6, fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            const SizedBox(width: 400, child: TextField(decoration: InputDecoration(labelText: "DIGITAL SIGNATURE", border: UnderlineInputBorder()))),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BuyerDashboard(isGuest: false))),
                child: const Text("EXECUTE & ENTER", style: TextStyle(color: goldAccent)),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}

// --- 3. THE WARM WATERMARKED DASHBOARD ---
class BuyerDashboard extends StatelessWidget {
  final bool isGuest;
  const BuyerDashboard({super.key, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: Text(isGuest ? "GUEST PREVIEW" : "BUYER COMMAND", style: const TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
              Tab(text: "SUPPORT", icon: Icon(Icons.handshake)),
              Tab(text: "LEGAL", icon: Icon(Icons.gavel)),
            ],
          ),
        ),
        body: Stack(children: [
          const Center(child: Opacity(opacity: 0.05, child: Icon(Icons.shield_rounded, size: 300, color: goldAccent))),
          TabBarView(children: [
            _MarketplaceTab(isGuest: isGuest),
            _MyAssetsTab(isGuest: isGuest),
            const _SupportTab(),
            const Center(child: Text("LEGAL ARCHIVE SECURE")),
          ]),
        ]),
      ),
    );
  }
}

// --- TAB SUB-VIEWS ---
class _MarketplaceTab extends StatelessWidget {
  final bool isGuest;
  const _MarketplaceTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("AVAILABLE SME-GRADE ASSETS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildAssetCard(context, "ANGUS #044", "\$2,695.00"),
        _buildAssetCard(context, "HEREFORD #102", "\$2,310.00"),
      ],
    );
  }

  Widget _buildAssetCard(BuildContext context, String title, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
          onPressed: isGuest ? null : () => _showStripe(context, title, price),
          child: Text(isGuest ? "SIGN IN" : "ACQUIRE", style: const TextStyle(color: goldAccent)),
        ),
      ),
    );
  }

  void _showStripe(BuildContext context, String name, String price) {
    showModalBottomSheet(context: context, builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.security, color: Colors.blue, size: 40),
        Text("STRIPE SETTLEMENT: $price", style: const TextStyle(fontWeight: FontWeight.bold)),
        const TextField(decoration: InputDecoration(labelText: "CARD NUMBER")),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 50)),
          onPressed: () => Navigator.pop(context),
          child: const Text("CONFIRM PURCHASE", style: TextStyle(color: goldAccent)),
        )
      ]),
    ));
  }
}

class _MyAssetsTab extends StatelessWidget {
  final bool isGuest;
  const _MyAssetsTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    if (isGuest) return const Center(child: Text("SIGN IN TO VIEW ASSETS"));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("MY SECURED ASSETS", style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(
          title: const Text("ANGUS UNIT #044"),
          trailing: const Icon(Icons.verified_user, color: goldAccent),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateView(assetID: "#044"))),
        )
      ],
    );
  }
}

class CertificateView extends StatelessWidget {
  final String assetID;
  const CertificateView({super.key, required this.assetID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: const Color(0xFFFFFDF7), border: Border.all(color: certificateGold, width: 8)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("HVF - EST. 1880", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent, fontSize: 20)),
            const Divider(color: goldAccent),
            const Text("CERTIFICATE OF LINEAGE", style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("ASSET: $assetID", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("PRODUCER", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Icon(Icons.shield, color: certificateGold, size: 40),
              Text("CEO J. HUMPHREY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _SupportTab extends StatelessWidget {
  const _SupportTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        Text("SOVEREIGN FLEXIBILITY", style: TextStyle(fontWeight: FontWeight.bold)),
        Card(child: ListTile(leading: Icon(Icons.calendar_month, color: goldAccent), title: Text("Negotiate Payment Date"))),
        Card(child: ListTile(leading: Icon(Icons.timer, color: goldAccent), title: Text("Request 14-Day Extension"))),
      ],
    );
  }
}his is the HVF Nexus Sovereign Core V55.0. I have unified every component we have built into a single, seamless "Force to be Reckoned With" demonstration.

This build allows you to walk your cousin through the entire ecosystem:

The Entry: The Crisp Humphrey Crest Gate.

The Choice: Selecting the Buyer path.

The Legal: The full-scroll Master Agreement with Digital Signature.

The Experience: The Warm, Watermarked Dashboard.

The Transaction: The Stripe-ready Acquisition flow.

The Result: The SME Certificate of Lineage with your Executive Seal.

HVF NEXUS CORE V55.0 - THE UNIFIED BUYER DEMO
Action: 1. Open lib/main.dart.
2. Select All and DELETE.
3. Paste this Complete Demonstration block.

Dart
import 'package:flutter/material.dart';

// HVF NEXUS CORE V55.0 - THE UNIFIED BUYER DEMO
// INTEGRATED: SIGN-IN, LEGAL GATE, WARM DASHBOARD, STRIPE FLOW, & CERTIFICATE VAULT
// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.light, primaryColor: const Color(0xFFC5A059)),
    home: const HVFCrestSignIn(),
  ));
}

const Color goldAccent = Color(0xFFC5A059); 
const Color deepBlack = Color(0xFF1A1A1A);
const Color warmBeige = Color(0xFFF9F6F0);
const Color certificateGold = Color(0xFFD4AF37);

// --- 1. THE CRISP SIGN-IN (BEGINNING) ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
          const Text("SOVEREIGN ENTRANCE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const TextField(decoration: InputDecoration(labelText: "BUYER ID", border: OutlineInputBorder())),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 70)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerLegalGate())),
            child: const Text("INITIALIZE SESSION", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 60), side: const BorderSide(color: goldAccent)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerDashboard(isGuest: true))),
            child: const Text("SKIP TO PREVIEW", style: TextStyle(color: deepBlack)),
          ),
        ]),
      ),
    );
  }
}

// --- 2. THE LEGAL GATE ---
class BuyerLegalGate extends StatelessWidget {
  const BuyerLegalGate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MASTER AGREEMENT"), backgroundColor: Colors.white, elevation: 0),
      body: Column(children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Text(
              "HVF SOVEREIGN BUYER TERMS & CONDITIONS\n\n"
              "Article I: SME Standards\nThe Buyer acknowledges that all livestock available through the Nexus is graded under strict SME protocols. The 'Superior' grade represents the pinnacle of genetic standards...\n\n"
              "Article II: 90/10 Protocol\nFacilitating direct 90% payout to Producers...\n\n"
              "Article III: Digital Signature\nThis document constitutes a binding agreement between the entity and Humphrey Virtual Farms LLC.",
              style: TextStyle(height: 1.6),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            const TextField(decoration: InputDecoration(labelText: "DIGITAL SIGNATURE", border: UnderlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BuyerDashboard(isGuest: false))),
              child: const Text("EXECUTE & ENTER", style: TextStyle(color: goldAccent)),
            ),
          ]),
        )
      ]),
    );
  }
}

// --- 3. THE WARM WATERMARKED DASHBOARD ---
class BuyerDashboard extends StatelessWidget {
  final bool isGuest;
  const BuyerDashboard({super.key, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          title: Text(isGuest ? "GUEST PREVIEW" : "BUYER COMMAND", style: const TextStyle(color: deepBlack, fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: goldAccent,
            indicatorColor: goldAccent,
            tabs: [
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
              Tab(text: "SUPPORT", icon: Icon(Icons.handshake)),
              Tab(text: "LEGAL", icon: Icon(Icons.gavel)),
            ],
          ),
        ),
        body: Stack(children: [
          Center(child: Opacity(opacity: 0.05, child: Icon(Icons.shield_rounded, size: 300, color: goldAccent))),
          TabBarView(children: [
            _MarketplaceTab(isGuest: isGuest),
            _MyAssetsTab(isGuest: isGuest),
            const _SupportTab(),
            const Center(child: Text("LEGAL ARCHIVE SECURE")),
          ]),
        ]),
      ),
    );
  }
}

// --- 4. THE TRANSACTIONAL MARKETPLACE ---
class _MarketplaceTab extends StatelessWidget {
  final bool isGuest;
  const _MarketplaceTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("AVAILABLE SME-GRADE ASSETS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildAssetCard(context, "ANGUS #044", "\$2,695.00"),
        _buildAssetCard(context, "HEREFORD #102", "\$2,310.00"),
      ],
    );
  }

  Widget _buildAssetCard(BuildContext context, String title, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
          onPressed: isGuest ? null : () => _showStripe(context, title, price),
          child: Text(isGuest ? "SIGN IN" : "ACQUIRE", style: const TextStyle(color: goldAccent)),
        ),
      ),
    );
  }

  void _showStripe(BuildContext context, String name, String price) {
    showModalBottomSheet(context: context, builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.security, color: Colors.blue, size: 40),
        Text("STRIPE SETTLEMENT: $price"),
        const TextField(decoration: InputDecoration(labelText: "CARD NUMBER")),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 50)),
          onPressed: () => Navigator.pop(context),
          child: const Text("CONFIRM PURCHASE", style: TextStyle(color: goldAccent)),
        )
      ]),
    ));
  }
}

// --- 5. THE SECURE VAULT & CERTIFICATE ---
class _MyAssetsTab extends StatelessWidget {
  final bool isGuest;
  const _MyAssetsTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    if (isGuest) return const Center(child: Text("SIGN IN TO VIEW ASSETS"));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("MY SECURED ASSETS", style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(
          title: const Text("ANGUS UNIT #044"),
          trailing: const Icon(Icons.verified_user, color: goldAccent),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateView(assetID: "#044"))),
        )
      ],
    );
  }
}

class CertificateView extends StatelessWidget {
  final String assetID;
  const CertificateView({super.key, required this.assetID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: const Color(0xFFFFFDF7), border: Border.all(color: certificateGold, width: 8)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text("HVF - EST. 1880", style: TextStyle(fontWeight: FontWeight.w900, color: goldAccent)),
            const Divider(color: goldAccent),
            const Text("CERTIFICATE OF LINEAGE", style: TextStyle(letterSpacing: 4)),
            const SizedBox(height: 20),
            Text("ASSET: $assetID", style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("SME GRADE: SUPERIOR", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("PRODUCER", style: TextStyle(fontSize: 8)),
              Icon(Icons.shield, color: certificateGold),
              Text("CEO J. HUMPHREY", style: TextStyle(fontSize: 8)),
            ]),
          ]),
        ),
      ),
    );
  }
}

// --- 6. RETENTION & SUPPORT ---
class _SupportTab extends StatelessWidget {
  const _SupportTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        Text("SOVEREIGN FLEXIBILITY", style: TextStyle(fontWeight: FontWeight.bold)),
        Card(child: ListTile(leading: Icon(Icons.calendar_month, color: goldAccent), title: Text("Negotiate Payment Date"))),
        Card(child: ListTile(leading: Icon(Icons.timer, color: goldAccent), title: Text("Request 14-Day Extension"))),
      ],
    );
  }
}
