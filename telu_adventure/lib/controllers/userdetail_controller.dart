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

  void getLaporan(String uid) {
    String gedung;
    String gedungnk;
    String kantin;

    _firestore
        .collection('userdetail')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;

        // Assuming your document has fields 'gedung', 'gedungnk', and 'kantin'
        gedung = data['gedung'];
        gedungnk = data['gedungnk'];
        kantin = data['kantin'];

        print('Gedung: $gedung');
        print('Gedung NK: $gedungnk');
        print('Kantin: $kantin');
      } else {
        print('No documents found for uid: $uid');
      }
    });
  }

  Future<void> updateLaporan(String uid, String newGedung, String newGedungnk,
      String newKantin) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('userdetail')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'gedung': newGedung,
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
}
