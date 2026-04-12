import 'package:flutter/material.dart';

// HVF NEXUS CORE V12.2 - THE CLEAN SLATE BUILD
// RESOLVED: DUPLICATE DECLARATIONS & STRING ESCAPING
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
            color: cardGray,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("BLACK ANGUS UNIT #001", style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Weight: 1,450 lbs", style: TextStyle(color: Colors.white70)),
                Divider(color: Colors.white10),
                Text("SME SEAL ACTIVE: TOTAL DISCLOSURE GUARANTEED", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuditLedger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("FINANCIAL AUDIT", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: const Center(child: Text("SOVEREIGN DATA SECURE", style: TextStyle(color: Colors.white))),
    );
  }
}import 'package:flutter/material.dart';

// HVF NEXUS CORE V12.1 - THE SUPERIOR COMMAND BUILD
// FEATURE: ESCAPED CURRENCY / RAPID SME AUDIT / TOTAL DISCLOSURE
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
              _buildSovereignButton(context, "FINANCIAL AUDIT", Icons.analytics, const Scaffold()),
              const SizedBox(height: 40),
              const Text("90/10 REVENUE ARCHITECTURE: ACTIVE", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
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
        // FIXED: Escaped the $ sign with a backslash to prevent build failure
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

// --- SME RAPID AUDIT PORTAL ---
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
            _buildToggle("SUPERIOR FRAME", isSuperior, (v) => setState(() => isSuperior = v)),
            _buildToggle("CALM TEMPERAMENT", isCalm, (v) => setState(() => isCalm = v)),
            _buildToggle("HVF PRIME STATUS", isPrime, (v) => setState(() => isPrime = v)),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SME SEAL AUTHORIZED - DISCLOSURE GENERATED")));
              },
              child: const Text("AUTHORIZE & SEAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      value: value,
      activeColor: gold,
      onChanged: onChanged,
    );
  }
}

// --- VIRTUAL STOCKYARD / MARKETPLACE ---
class LivestockMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildAssetCard("BLACK ANGUS UNIT #001", "Weight: 1,450 lbs"),
        ],
      ),
    );
  }

  Widget _buildAssetCard(String title, String weight) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardGray, border: Border.all(color: gold.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
          Text(weight, style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white10, height: 20),
          const Text("TOTAL DISCLOSURE: SME SEAL ACTIVE", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("DIET: Grass Fed / HEALTH: All Vax Current", style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
}import 'package:flutter/material.dart';

// HVF NEXUS CORE V12.0 - THE RAPID AUDIT BUILD
// FEATURE: SME COMMAND TOGGLES / AUTOMATED DISCLOSURE
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
          title: const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, letterSpacing: 4)),
          backgroundColor: cardGray,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSovereignButton(context, "SME RAPID AUDIT", Icons.fact_check, SMEAdminPortal()),
              const SizedBox(height: 20),
              _buildSovereignButton(context, "VIRTUAL STOCKYARD", Icons.account_balance, LivestockMarketplace()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSovereignButton(BuildContext context, String label, IconData icon, Widget target) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: cardGray, 
        foregroundColor: gold, 
        minimumSize: const Size(300, 80),
        side: const BorderSide(color: gold)
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

// --- NEW: THE RAPID AUDIT PORTAL ---
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
            const Divider(color: gold),
            SwitchListTile(
              title: const Text("SUPERIOR FRAME", style: TextStyle(color: Colors.white)),
              value: isSuperior,
              activeColor: gold,
              onChanged: (bool value) => setState(() => isSuperior = value),
            ),
            SwitchListTile(
              title: const Text("CALM TEMPERAMENT", style: TextStyle(color: Colors.white)),
              value: isCalm,
              activeColor: gold,
              onChanged: (bool value) => setState(() => isCalm = value),
            ),
            SwitchListTile(
              title: const Text("HVF PRIME STATUS", style: TextStyle(color: Colors.white)),
              value: isPrime,
              activeColor: gold,
              onChanged: (bool value) => setState(() => isPrime = value),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 60)),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SME SEAL AUTHORIZED - DISCLOSURE GENERATED")));
              },
              child: const Text("AUTHORIZE & SEAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

class LivestockMarketplace extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(backgroundColor: bgBlack, appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray)); } }import 'package:flutter/material.dart';

// HVF NEXUS CORE V11.0 - THE TOTAL TRANSPARENCY BUILD
// FEATURE: DEEP-DETAIL DISCLOSURE / SME VERIFIED SPECS
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
        appBar: _buildHeader(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceLockBanner(),
              const SizedBox(height: 20),
              _buildTile(context, "VIRTUAL STOCKYARD", Icons.account_balance, LivestockMarketplace()),
              _buildTile(context, "SME ADMIN PORTAL", Icons.verified_user_sharp, const Scaffold()),
              _buildTile(context, "FINANCIAL AUDIT", Icons.analytics, const Scaffold()),
              const SizedBox(height: 40),
              const Text("DATA TRANSPARENCY: ABSOLUTE", 
                style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _buildHeader() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cardGray,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HVF NEXUS", style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 4)),
              const Text("SOVEREIGN TRANSPARENCY ENGINE", style: TextStyle(color: Colors.white54, fontSize: 10)),
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
        child: Text("LEGACY LOCK: $25 BUYER ACCESS ACTIVE", style: TextStyle(color: gold, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, Widget target) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
        tileColor: cardGray,
        leading: Icon(icon, color: gold),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        shape: Border.all(color: gold.withOpacity(0.3)),
      ),
    );
  }
}

class LivestockMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(title: const Text("STOCKYARD", style: TextStyle(color: gold)), backgroundColor: cardGray),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildAssetCard(context, "BLACK ANGUS UNIT #001", "Weight: 1,450 lbs", "SME VERIFIED"),
        ],
      ),
    );
  }

  Widget _buildAssetCard(BuildContext context, String title, String weight, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: cardGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
              const Icon(Icons.verified, color: Colors.green, size: 20),
            ],
          ),
          Text(weight, style: const TextStyle(color: Colors.white70)),
          const Divider(color: Colors.white10, height: 30),
          const Text("TOTAL DISCLOSURE LEDGER:", style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildInfoRow("LINEAGE:", "Purebred / Certified"),
          _buildInfoRow("DIET:", "Non-GMO Grass Fed"),
          _buildInfoRow("HEALTH:", "All Vax Current / Nexus Logged"),
          _buildInfoRow("SME NOTES:", "Superior Frame / Calm Temperament"),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {}, 
            child: const Text("SECURE UNIT (\$200/MO PRODUCER LINKED)", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
