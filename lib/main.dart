import 'package:flutter/material.dart';

// HVF NEXUS CORE V52.0 - BUYER ACCESS, WINDOW SHOPPING, & RETENTION
// FEATURE: SKIP SIGN-IN (VIEW ONLY), ACCOUNT CREATION, PAYMENT EXTENSION REQUESTS
// FOCUS: BUILDING DESIRE BEFORE PAYWALL & SOVEREIGN FLEXIBILITY
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
const Color warmBeige = Color(0xFFF9F6F0);

// --- STAGE 1: ENHANCED BUYER SIGN-IN GATE ---
class HVFCrestSignIn extends StatelessWidget {
  const HVFCrestSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 60),
          const Icon(Icons.shield_rounded, size: 80, color: goldAccent), 
          const Text("HVF NEXUS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, letterSpacing: 6)),
          const Text("BUYER ENTRANCE", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const TextField(decoration: InputDecoration(labelText: "EMAIL / BUYER ID", border: OutlineInputBorder())),
          const SizedBox(height: 15),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: "PASSWORD", border: OutlineInputBorder())),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: deepBlack, minimumSize: const Size(double.infinity, 60)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerMainDashboard(isGuest: false))),
            child: const Text("SIGN IN", style: TextStyle(color: goldAccent, fontWeight: FontWeight.bold)),
          ),
          TextButton(onPressed: () {}, child: const Text("CREATE SOVEREIGN ACCOUNT", style: TextStyle(color: Colors.black))),
          const Divider(height: 50),
          // THE "WINDOW SHOPPING" OPTION
          OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 60), side: const BorderSide(color: goldAccent)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerMainDashboard(isGuest: true))),
            child: const Text("SKIP SIGN-IN (VIEW ONLY)", style: TextStyle(color: deepBlack, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }
}

// --- STAGE 2: THE DASHBOARD (NOW WITH GUEST LOGIC & RETENTION) ---
class BuyerMainDashboard extends StatelessWidget {
  final bool isGuest;
  const BuyerMainDashboard({super.key, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: warmBeige,
        appBar: AppBar(
          backgroundColor: warmBeige,
          elevation: 0,
          title: Text(isGuest ? "HVF PREVIEW MODE" : "BUYER COMMAND", style: const TextStyle(color: deepBlack, fontWeight: FontWeight.w900)),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: goldAccent,
            indicatorColor: goldAccent,
            tabs: [
              Tab(text: "MARKETPLACE", icon: Icon(Icons.shopping_cart)),
              Tab(text: "MY VAULT", icon: Icon(Icons.lock)),
              Tab(text: "SOVEREIGN SUPPORT", icon: Icon(Icons.handshake)),
              Tab(text: "LEGAL", icon: Icon(Icons.gavel)),
            ],
          ),
        ),
        body: Stack(
          children: [
            Center(child: Opacity(opacity: 0.05, child: Icon(Icons.shield_rounded, size: 300, color: goldAccent))),
            TabBarView(
              children: [
                _MarketplaceTab(isGuest: isGuest),
                _MyVaultTab(isGuest: isGuest),
                _SupportTab(isGuest: isGuest),
                const _LegalTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- TAB 1: MARKETPLACE (WINDOW SHOPPING MODE) ---
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
        _buildAssetCard(context, "ANGUS #044", "SUPERIOR", isGuest),
        _buildAssetCard(context, "HEREFORD #102", "SUPERIOR", isGuest),
      ],
    );
  }

  Widget _buildAssetCard(BuildContext context, String title, String grade, bool guest) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("GRADE: $grade", style: const TextStyle(color: goldAccent)),
        trailing: ElevatedButton(
          onPressed: guest ? null : () {}, // DISABLED FOR GUESTS
          style: ElevatedButton.styleFrom(backgroundColor: deepBlack),
          child: Text(guest ? "SIGN IN TO BUY" : "ACQUIRE", style: const TextStyle(color: goldAccent)),
        ),
      ),
    );
  }
}

// --- TAB 2: MY VAULT ---
class _MyVaultTab extends StatelessWidget {
  final bool isGuest;
  const _MyVaultTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isGuest 
        ? const Text("Sign In to view your secured assets.", style: TextStyle(fontStyle: FontStyle.italic))
        : const Text("YOUR SECURED ASSETS ARE READY", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

// --- TAB 3: SOVEREIGN SUPPORT (NEGOTIATION & EXTENSIONS) ---
class _SupportTab extends StatelessWidget {
  final bool isGuest;
  const _SupportTab({required this.isGuest});
  @override
  Widget build(BuildContext context) {
    if (isGuest) return const Center(child: Text("Guest mode: Support unavailable."));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("PAYMENT & RETENTION SOVEREIGNTY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        const Card(
          child: ListTile(
            leading: Icon(Icons.calendar_month, color: goldAccent),
            title: Text("Negotiate Payment Date"),
            subtitle: Text("Request a permanent shift in your billing cycle."),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.timer, color: goldAccent),
            title: Text("Request 14-Day Extension"),
            subtitle: Text("Apply for a temporary grace period."),
          ),
        ),
        const SizedBox(height: 30),
        const Text("FILE CONCERNS TO CEO", style: TextStyle(fontWeight: FontWeight.bold)),
        const TextField(maxLines: 3, decoration: InputDecoration(hintText: "Direct line to SME Review...", border: OutlineInputBorder())),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: deepBlack), child: const Text("SUBMIT", style: TextStyle(color: goldAccent))),
      ],
    );
  }
}

class _LegalTab extends StatelessWidget {
  const _LegalTab();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("FULL LEGAL ARCHIVE"));
  }
}
