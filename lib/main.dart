// HVF NEXUS OS - TRIPLE-LOCK FUSION V137.0
// INTEGRATING HELIOGRID, MEDIA PROOF, AND TRANSACTION
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)

Widget _commandStream() => Container(
  child: ListView(
    children: [
      _streamItem("UTILITY", "HELIOGRID OUTPUT: 482kW - STABLE", Colors.orangeAccent),
      _streamItem("MEDIA", "PRODUCER #104 UPLOADED VIDEO: CATTLE_HEALTH_CHECK", Colors.cyan),
      _streamItem("EXCHANGE", "PURCHASE INITIALIZED: LOT #882 - $42,000", Colors.greenAccent),
      _streamItem("LOGISTICS", "MANIFEST GENERATED: PENDING FLEET PICKUP", Color(0xFFC5A059)),
    ],
  ),
);
