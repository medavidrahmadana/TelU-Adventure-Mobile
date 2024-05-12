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
    return _firestore.collection('lapor').snapshots();
  }

  //update
  static Future<Barang> updateKarir(
      BuildContext context, barang, String id) async {
    await FirebaseFirestore.instance
        .collection('lapor')
        .doc(id)
        .update(barang.toMap());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('barang terupdate updated successfully!')));
    Navigator.pop(context);
    return barang;
  }

  //delete
  static Future<void> deleteKompetisi(String id) async {
    await FirebaseFirestore.instance.collection('barang').doc(id).delete();
  }
}
