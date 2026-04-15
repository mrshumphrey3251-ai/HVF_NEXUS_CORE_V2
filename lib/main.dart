// ADDING TELEMETRY FIELDS TO THE CARD
Widget _assetTile(String id, String name, dynamic val, bool isSold, Map<String, dynamic> telemetry) {
  return Card(
    color: isSold ? const Color(0xFF1A0000) : const Color(0xFF0D0D0D),
    child: ListTile(
      leading: Icon(isSold ? Icons.verified : Icons.satellite_alt, 
                   color: isSold ? Colors.greenAccent : Colors.cyan),
      title: Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("VALUE: \$$val", style: const TextStyle(color: Colors.white38, fontSize: 8)),
          // NEW TELEMETRY READOUT
          Text("LOC: ${telemetry['lat'] ?? 'SEARCHING...'}, ${telemetry['long'] ?? ''}", 
               style: const TextStyle(color: Colors.cyan, fontSize: 7)),
          Text("LAST_SYNC: ${telemetry['timestamp'] ?? 'PENDING'}", 
               style: const TextStyle(color: Colors.white10, fontSize: 7)),
        ],
      ),
      trailing: isSold 
        ? const Text("SECURED", style: TextStyle(color: Colors.redAccent, fontSize: 8))
        : ElevatedButton(
            onPressed: () => _executeUnderwriting(id, name, val),
            child: const Text("EXECUTE", style: TextStyle(fontSize: 7)),
          ),
    ),
  );
}
