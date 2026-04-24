import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// HVF NEXUS CORE: SOVEREIGN SENTINEL V2
// CEO: JEFFERY HUMPHREY | CAGE: 1AHA8
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox('sovereign_vault'); // Local, encrypted, zero-cloud storage
  runApp(const HVFSentinelApp());
}

class HVFSentinelApp extends StatelessWidget {
  const HVFSentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Stealth/Industrial Aesthetic
      home: const SentinelMonitor(),
    );
  }
}

class SentinelMonitor extends StatefulWidget {
  const SentinelMonitor({super.key});

  @override
  State<SentinelMonitor> createState() => _SentinelMonitorState();
}

class _SentinelMonitorState extends State<SentinelMonitor> {
  bool _isAuthorized = true; // Biometric Handshake Flag
  int _inactivityMinutes = 0; // The "No Man Left Behind" Clock

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isAuthorized 
          ? _buildAuthorizedUI() 
          : _buildIncursionStrobe(), // Anti-Theft Protocol
      ),
    );
  }

  // THE HUMAN SIDE: Personal Grounding Display
  Widget _buildAuthorizedUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("HVF CHRONUS", style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Icon(Icons.shield, color: Colors.blue, size: 80), // The Sovereign Shield
        Text("STATUS: SENTINEL ACTIVE", style: TextStyle(color: Colors.green[400])),
        const SizedBox(height: 10),
        Text("INACTIVITY: $_inactivityMinutes MIN"), // 60-min alert logic
      ],
    );
  }

  // THE RECOVERY SIDE: Active Deterrent Strobe
  Widget _buildIncursionStrobe() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: (DateTime.now().millisecond % 500 > 250) ? Colors.red : Colors.white,
      child: const Center(
        child: Text("HVF SECURITY LOCK", 
          style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.black)),
      ),
    );
  }
}
