import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: Replace the placeholders below with your actual keys from Firebase Console
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY", 
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "hvf-nexus",
    ),
  );
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

  void _attemptLogin() {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SOVEREIGN GATE", 
                style: TextStyle(color: Color(0xFFFFD700), fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4)),
              const SizedBox(height: 30),
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
                    labelText: 'ENTER AUTHORIZATION',
                    labelStyle: TextStyle(color: Colors.white54),
                  ),
                  onSubmitted: (value) => _attemptLogin(),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _attemptLogin,
                child: const Text("UPLINK", style: TextStyle(color: Color(0xFFFFD700))),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(":: HVF OVERWATCH ::", style: TextStyle(color: Color(0xFFFFD700), letterSpacing: 2)),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFD700), width: 0.5),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.radar, color: Color(0xFFFFD700), size: 50),
                SizedBox(height: 20),
                Text("COMMAND CENTER ACTIVE", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300)),
                Text("All systems nominal.", style: TextStyle(color: Colors.green, fontSize: 14)),
              ],
            ),
          ),
        ),
      );
    }
  }
}
