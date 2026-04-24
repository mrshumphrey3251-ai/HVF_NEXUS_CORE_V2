import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize the Sovereign Data Vault (Hive)
  await Hive.initFlutter();
  
  // Create a local vault for user telemetry
  await Hive.openBox('nexus_telemetry');

  runApp(const HVFNexusApp());
}

class HVFNexusApp extends StatelessWidget {
  const HVFNexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HVF Nexus Core',
      theme: ThemeData(
        brightness: Brightness.dark, // Executive Theme
        primarySwatch: Colors.blueGrey,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'NEXUS CORE: SYSTEM LIVE',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
