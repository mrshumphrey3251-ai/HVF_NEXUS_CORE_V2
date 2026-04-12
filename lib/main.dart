// Adding the 'Agent ID' field to the Command Center to track the 40-City Tour residuals.
// This ensures you know exactly who to pay that 10% to.

// Update your Dashboard Column in main.dart:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(Icons.verified_user, color: Colors.green, size: 80),
    const Text("SYSTEM OPERATIONAL", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
    const SizedBox(height: 20),
    // NEW: Agent/City Tracker Field
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        decoration: InputDecoration(
          labelText: "AGENT ID / CITY CODE",
          labelStyle: TextStyle(color: Colors.amber),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    ),
    const SizedBox(height: 30),
    // ... rest of your ElevatedButton code ...
  ],
)
