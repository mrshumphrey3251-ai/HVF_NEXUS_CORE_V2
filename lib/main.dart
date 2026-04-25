import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

// HVF NEXUS CORE: SOVEREIGN SENTINEL V2.0
// CEO: JEFFERY HUMPHREY | CAGE: 1AHA8 | UEI: S1M4ENLHTDH5
// MISSION: ELIMINATING THE RURAL TRIAGE GAP

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Sovereign Data Vault (Offline-First)
  await Hive.initFlutter();
  await Hive.openBox('nexus_telemetry');
  await Hive.openBox('dr_shield_vault'); // For Med Alerts

  runApp(const HVFNexusApp());
}

class HVFNexusApp extends StatelessWidget {
  const HVFNexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HVF Nexus Core',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isAuthorized = true; // Biometric Handshake Flag
  int _inactivitySeconds = 0;
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _startInactivityTimer();
  }

  // THE "NO MAN LEFT BEHIND" CLOCK
  void _startInactivityTimer() {
    _inactivityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _inactivitySeconds++;
      });
      
      // LOGIC: At 4 hours (14400 sec), trigger Guardian Strike
      if (_inactivitySeconds == 14400) {
        _triggerEmergencyProtocol("INACTIVITY STRIKE");
      }
    });
  }

  void _triggerEmergencyProtocol(String type) {
    print("CRITICAL: $type INITIATED. COORDINATES: 34.3056° N, 96.5056° W");
    // In a live build, this triggers the LTE-M Burst Transmission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Reset timer on movement/touch
          setState(() => _inactivitySeconds = 0);
        },
        onLongPress: () {
          // STEALTH PANIC BUTTON
          _triggerEmergencyProtocol("MANUAL STEALTH STRIKE");
        },
        child: Center(
          child: _isAuthorized ? _buildSecureUI() : _buildIncursionStrobe(),
        ),
      ),
    );
  }

  // EXECUTIVE DASHBOARD UI
  Widget _buildSecureUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("HVF CHRONUS", 
          style: TextStyle(letterSpacing: 8, fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 30),
        const Icon(Icons.shield, color: Colors.blueAccent, size: 100),
        const SizedBox(height: 30),
        const Text("SYSTEM LIVE", 
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 10),
        Text("INACTIVITY TIMER: ${_formatTime(_inactivitySeconds)}",
          style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 40),
        _buildMedAlertWidget(),
      ],
    );
  }

  Widget _buildMedAlertWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.medication, color: Colors.redAccent),
          SizedBox(width: 10),
          Text("DR. SHIELD: 08:00 AM READY"),
        ],
      ),
    );
  }

  // ANTI-THEFT DETERRANT
  Widget _buildIncursionStrobe() {
    return Container(
      color: (DateTime.now().millisecond % 500 > 250) ? Colors.red : Colors.white,
      child: const Center(
        child: Text("UNAUTHORIZED USER\nDATA LOCKED", 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.black)),
      ),
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }
}
