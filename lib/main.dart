import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// HVF NEXUS OS V139.0 - THE FUNCTIONAL ENGINE
// LIVE COMMERCE & VIDEO PROOF UPLOAD
// AUTHORIZED BY: JEFFERY DONNELL HUMPHREY (CEO / SME)

class ExchangeEngine extends StatefulWidget {
  const ExchangeEngine({super.key});
  @override
  State<ExchangeEngine> createState() => _ExchangeEngineState();
}

class _ExchangeEngineState extends State<ExchangeEngine> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 1. THE "PROOF OF LIFE" UPLOAD LOGIC
  Future<void> uploadAssetVideo(String assetId, File videoFile) async {
    try {
      // SME Standard: Geo-tag and Timestamp the Proof
      Reference ref = _storage.ref().child('proof_of_life/$assetId.mp4');
      await ref.putFile(videoFile);
      String downloadUrl = await ref.getDownloadURL();
      
      await _db.collection('listings').doc(assetId).update({
        'video_proof_url': downloadUrl,
        'sme_verified': true,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print(":: PROOF_OF_LIFE_SYNCED ::");
    } catch (e) {
      print(":: UPLOAD_FAILURE: $e ::");
    }
  }

  // 2. THE "INSTITUTIONAL PURCHASE" EXECUTION
  Future<void> buyAsset(String assetId, String buyerId) async {
    // Start a Database Transaction to prevent "Double Selling"
    return _db.runTransaction((transaction) async {
      DocumentReference assetRef = _db.collection('listings').doc(assetId);
      DocumentSnapshot snapshot = await transaction.get(assetRef);

      if (!snapshot.exists || snapshot.get('status') == 'SOLD') {
        throw Exception("ASSET_UNAVAILABLE");
      }

      // Execute the Exchange
      transaction.update(assetRef, {
        'status': 'SOLD',
        'buyer_id': buyerId,
        'manifest_status': 'PENDING_4PL',
      });

      // Credit the Storm Chest & Social Ledger
      _db.collection('treasury').doc('storm_chest').update({
        'balance': FieldValue.increment(snapshot.get('price') * 0.05), // 5% Underwriting
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(":: LIVE_EXCHANGE_TERMINAL ::", style: TextStyle(fontSize: 9))),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('listings').where('status', isEqualTo: 'AVAILABLE').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("PRICE: \$${doc['price']}"),
                trailing: ElevatedButton(
                  onPressed: () => buyAsset(doc.id, "BUYER_SEC_001"),
                  child: const Text("BUY_NOW"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
