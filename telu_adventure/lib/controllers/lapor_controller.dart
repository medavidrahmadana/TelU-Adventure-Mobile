import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/model/barang_model.dart';

class LaporCon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, Barang barang) async {
    try {
      await FirebaseFirestore.instance
          .collection("laporan")
          .add(barang.toMap());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan sudah terkirim!')));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan gagal terkirim!')));
      Navigator.pop(context); // Assuming this is in a new screen
    }
  }

  //read
  Stream<QuerySnapshot> getlaporan() {
    return _firestore.collection('laporan').snapshots();
  }

  //update
  static Future<void> updateFirestore(
      BuildContext context, String documentId, Barang barang) async {
    try {
      await FirebaseFirestore.instance
          .collection('barang')
          .doc(documentId)
          .update({
        'nama': barang.nama,
        'type': barang.type,
        'deskripsi': barang.deskripsi,
        'imagePath': barang.imagePath,
        'lokasi': barang.lokasi,
        'kehilangan': barang.kehilangan,
        'status': barang.status,
      });
      Navigator.of(context).pop(); // Close the dialog on success
    } catch (e) {
      print('Error updating document: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating document')));
    }
  }

  //delete
  static Future<void> deleteKompetisi(String id) async {
    await FirebaseFirestore.instance.collection('barang').doc(id).delete();
  }
}
