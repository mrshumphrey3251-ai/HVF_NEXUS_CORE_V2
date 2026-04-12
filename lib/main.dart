import 'package:flutter/material.dart';

// HVF NEXUS CORE V4.0 - THE LIVESTOCK MARKETPLACE BUILD
// REVENUE MODEL: 90/10 RESIDUAL SPLIT ENABLED
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF211007),
        appBar: AppBar(
          title: const Text("HVF NEXUS: AUDIT CORE", style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: const Color(0xFF3E2723),
          elevation: 10,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.shield_outlined, color: Colors.green, size: 80),
              const Text("AGENT AUDIT ACTIVE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              
              // --- MARKETPLACE NAVIGATION ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 70),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LivestockMarketplace()));
                  },
                  icon: const Icon(Icons.agriculture, size: 28),
                  label: const Text("ENTER LIVESTOCK MARKETPLACE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              
              // --- INTERIOR ASSETS NAVIGATION ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.amber,
                    minimumSize: const Size(double.infinity, 60),
                    side: const BorderSide(color: Colors.amber),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GreatHallScreen()));
                  },
                  icon: const Icon(Icons.meeting_room),
                  label: const Text("SOCIAL CLUB INTERIOR"),
                ),
              ),
              
              const SizedBox(height: 50),
              const Text("90/10 REVENUE SPLIT: ACTIVE", style: TextStyle(color: Colors.white54, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SCREEN 2: THE LIVESTOCK MARKETPLACE ---
class LivestockMarketplace extends StatelessWidget {
  const LivestockMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF211007),
        appBar: AppBar(
          title: const Text("VIRTUAL STOCKYARD", style: TextStyle(color: Color(0xFFFFC107))),
          backgroundColor: const Color(0xFF3E2723),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("AVAILABLE INVENTORY", style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.amber),
            const SizedBox(height: 10),
            
            _buildAnimalCard("Black Angus Bull", "1,450 lbs", "Nexus-Verified", "Johnston County"),
            _buildAnimalCard("Heifers (Batch of 5)", "800 lbs avg", "Organic Feed", "Marshall County"),
            _buildAnimalCard("Boer Goats", "Ready for Transit", "SME Certified", "Atoka County"),
            
            const SizedBox(height: 30),
            const Center(child: Text("TOTAL VIRTUAL HERD VALUE: \$245,000", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalCard(String title, String weight, String status, String location) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.pets, color: Colors.amber),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("$weight • $status\n$location", style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.add_shopping_cart, color: Colors.green),
        isThreeLine: true,
      ),
    );
  }
}

// --- SCREEN 3: THE GREAT HALL INTERIOR ---
class GreatHallScreen extends StatelessWidget {
  const GreatHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF211007),
        appBar: AppBar(
          title: const Text("SOCIAL CLUB: GREAT HALL", style: TextStyle(color: Color(0xFFFFC107))),
          backgroundColor: const Color(0xFF3E2723),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.holiday_village, color: Color(0xFFFFC107), size: 100),
              const Text("INTERIOR ASSETS ACTIVE", style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("• 20ft Fieldstone Spine\n• 12x12 Cedar Columns\n• Sovereign Seating", 
                style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
              ),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("BACK")),
            ],
          ),
        ),
      ),
    );
  }
}
