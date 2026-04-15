// HVF NEXUS OS V134.0 - THE AUDIT RECTIFICATION BUILD
// NIST 800-66 COMPLIANCE | SSA MILESTONE TRACKING | AGRI-TRACEABILITY
// CAGE: 1AHA8 | UEI: S1M4ENLHTDH5 | AUTHORIZED: J.D. HUMPHREY

class AuditCommand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _auditTile("FEDERAL_ENCRYPTION_FIPS", "VALIDATED", Colors.cyan),
        _auditTile("LIVESTOCK_TRACEABILITY", "UID_ENABLED", Colors.greenAccent),
        _auditTile("SSA_CLAIMS_MILESTONES", "SYNCED", Colors.orangeAccent),
      ],
    );
  }

  Widget _auditTile(String l, String s, Color c) => Container(
    padding: EdgeInsets.all(15), margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(color: Color(0xFF0D0D0D), border: Border.all(color: c, width: 0.5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        Text(s, style: TextStyle(fontSize: 8, color: c)),
      ],
    ),
  );
}
