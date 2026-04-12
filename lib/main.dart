// AUTHORIZED: CEO JEFFERY DONNELL HUMPHREY

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'HVF NEXUS CORE',
    home: HVFCommandDashboard(),
  ));
}

// --- SCREEN 1: THE COMMAND CENTER ---
class HVFCommandDashboard extends StatefulWidget {
  const HVFCommandDashboard({super.key});

  @override
  State<HVFCommandDashboard> createState() => _HVFCommandDashboardState();
}

class _HVFCommandDashboardState extends State<HVFCommandDashboard> {
  final TextEditingController _agentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SME FIX: Wrap in SafeArea to prevent hardware overlap
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF211007), // Aged Walnut
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Hardened height for visibility
          child: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "HVF NEXUS: AUDIT CORE",
                style: TextStyle(
                  color: Color(0xFFFFC107), // High-Visibility Amber
                  fontWeight: FontWeight.black, // Maximum weight
                  fontSize: 24,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF3E2723), // Deep Cedar
            elevation: 20,
            shadowColor: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.shield_outlined, color: Colors.green, size: 100),
              const SizedBox(height: 10),
              const Text(
                "AGENT VERIFICATION ACTIVE", 
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 40),
              
              // --- THE SOVEREIGN AGENT TRACKER ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _agentIdController,
                  decoration: const InputDecoration(
                    labelText: "ENTER AGENT ID / CITY CODE",
                    labelStyle: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold),
                    hintText: "OK-JOHNSTON-001",
                    hintStyle: TextStyle(color: Colors.white24),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFFC107), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 4),
                    ),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // --- PRIMARY ACCESS BAR ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 75),
                    elevation: 12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GreatHallScreen()),
                    );
                  },
                  child: const Text(
                    "ACCESS INTERIOR ASSETS", 
                    style: TextStyle(fontWeight: FontWeight.black, fontSize: 20),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              const Divider(color: Colors.white38, indent: 50, endIndent: 50, thickness: 2),
              const Text("90/10 REVENUE SPLIT: ACTIVE", 
                   style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const Text("SOVEREIGNTY STATUS: VERIFIED", 
                   style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1.1)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SCREEN 2: THE SOCIAL CLUB: GREAT HALL INTERIOR ---
class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF211007),
        appBar: AppBar(
          title: const Text(
            "SOCIAL CLUB: GREAT HALL",
            style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF3E2723),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.holiday_village, color: Color(0xFFFFC107), size: 120),
              const SizedBox(height: 20),
              const Text(
                "INTERIOR ASSETS", 
                style: TextStyle(color: Color(0xFFFFC107), fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Divider(color: Color(0xFFFFC107), thickness: 4),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  "• 20ft Fieldstone Spine (Masonry Secure)\n\n"
                  "• 12x12 Cedar Structural Columns\n\n"
                  "• Sovereign Seating: CEO Wingbacks Anchored\n\n"
                  "• Veteran Club Chairs: ADA Compliant",
                  style: TextStyle(color: Colors.white, fontSize: 20, height: 1.6, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 40),
              
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC107)),
                label: const Text("RETURN TO COMMAND", style: TextStyle(color: Color(0xFFFFC107), fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
