import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/model/barang_model.dart';
import 'package:telu_adventure/model/pertanyaan_model.dart';

class forumCon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, pertanyaan_model pertanyaan) async {
    try {
      await FirebaseFirestore.instance
          .collection("forum")
          .add(pertanyaan.toMap());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pertanyaan sudah terkirim!')));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pertanyaan gagal terkirim!')));
      Navigator.pop(context); // Assuming this is in a new screen
    }
  }

  Future<List<pertanyaan_model>> getPertanyaan() async {
    List<pertanyaan_model> pertanyaan_list = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('forum').get();
      querySnapshot.docs.forEach((doc) {
        pertanyaan_model pertanyaan = pertanyaan_model(
          id: doc['id'] ?? '',
          pertanyaan: doc['pertanyaan'] ?? '',
          userid: doc['userid'] ?? '',
          nama: doc['nama'] ?? '',
          urlimg: doc['urlimg'] ?? '',
          waktu: doc['waktu'] ?? '',
        );
        pertanyaan_list.add(pertanyaan);
      });
    } catch (e) {
      print('Error fetching forum: $e');
    }
    return pertanyaan_list;
  }
}
