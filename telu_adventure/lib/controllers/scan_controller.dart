import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/model/barang_model.dart';
import 'package:telu_adventure/model/jawab_model.dart';
import 'package:telu_adventure/model/pertanyaan_model.dart';
import 'package:telu_adventure/model/scan_model.dart';

class ScanCon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(BuildContext context, scan_model scan) async {
    try {
      await FirebaseFirestore.instance.collection("quest").add(scan.toMap());
      // Show success message or navigate to another screen

      Navigator.pop(context);
    } catch (error) {
      print(error); // Assuming this is in a new screen
    }
  }

  Stream<QuerySnapshot> getquest(String uid) {
    return _firestore
        .collection('quest')
        .where('uid', isEqualTo: uid) // Filter berdasarkan uid
        .snapshots();
  }
}
