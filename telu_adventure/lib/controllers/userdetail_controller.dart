import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/model/barang_model.dart';

class usercon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getJumlah(String uid) async {
    var querySnapshot = await _firestore
        .collection('userdetail')
        .where('uid', isEqualTo: uid)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<Map<String, String?>> getGedung(String uid) async {
    var querySnapshot = await _firestore
        .collection('userdetail')
        .where('uid', isEqualTo: uid)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      return {
        'gedungk': documentSnapshot['gedungk'] as String?,
        'gedungnk': documentSnapshot['gedungnk'] as String?,
        'kantin': documentSnapshot['kantin'] as String?,
      };
    } else {
      return {
        'gedungk': '0',
        'gedungnk': '0',
        'kantin': '0',
      };
    }
  }

  Future<void> updateGedung(String uid, String newGedung, String newGedungnk,
      String newKantin) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('userdetail')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'gedungk': newGedung,
          'gedungnk': newGedungnk,
          'kantin': newKantin,
        });

        print('Document updated successfully');
      } else {
        print('No documents found for uid: $uid');
      }
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  Stream<QuerySnapshot> getQuestbyID(String uid) {
    return _firestore
        .collection('quest')
        .where('uid', isEqualTo: uid) // Filter berdasarkan uid
        .snapshots();
  }
}
