import 'package:flutter/material.dart';

// THE HVF NEXUS CORE - V106.3 HARDENED
void main() {
  runApp(const HVFNexus());
}

class HVFNexus extends StatelessWidget {
  const HVFNexus({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      home: const NexusCore(),
    );
  }
}

class NexusCore extends StatefulWidget {
  const NexusCore({super.key});
  @override
  State<NexusCore> createState() => _NexusCoreState();
}

class _NexusCoreState extends State<NexusCore> {
  bool isAuthorized = false;
  final TextEditingController _codeController = TextEditingController();

  void _verifyAccess() {
    if (_codeController.text == "CEO1880") {
      setState(() {
        isAuthorized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthorized) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFD700), width: 2),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("SOVEREIGN GATE", 
                  style: TextStyle(color: Color(0xFFFFD700), fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 5)),
                const SizedBox(height: 40),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: _codeController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      labelText: 'AUTHORIZATION CODE',
                      labelStyle: TextStyle(color: Colors.white54),
                    ),
                    onSubmitted: (_) => _verifyAccess(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                  onPressed: _verifyAccess,
                  child: const Text("UPLINK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(":: HVF OVERWATCH ::", style: TextStyle(color: Color(0xFFFFD700))),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, color: Color(0xFFFFD700), size: 80),
              const SizedBox(height: 20),
              const Text("SYSTEM ONLINE", style: TextStyle(color: Colors.white, fontSize: 24)),
              const Text("Welcome, CEO Jeffery.", style: TextStyle(color: Colors.green, fontSize: 16)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white10,
                child: const Text("25 ACRE LAKE: STABLE\nJOHNSTON COUNTY UPLINK: ACTIVE", 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFFFD700), fontFamily: 'monospace')),
              )
            ],
          ),
        ),
      );
    }
  }
}
