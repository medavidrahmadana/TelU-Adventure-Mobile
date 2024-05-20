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

  Stream<QuerySnapshot> getlaporan(String uid) {
    return _firestore
        .collection('laporan')
        .where('kehilangan', isEqualTo: uid) // Filter berdasarkan uid
        .snapshots();
  }

  Stream<QuerySnapshot> getlaporanbystatus() {
    return _firestore
        .collection('laporan')
        .where('status', isEqualTo: "Belum") // Filter berdasarkan uid
        .snapshots();
  }

  //update
  static Future<void> updateFirestore(
      BuildContext context, String documentId, Barang barang) async {
    try {
      Map<String, dynamic> updateData = {};

      if (barang.nama != "") {
        updateData['nama'] = barang.nama;
      }
      if (barang.type != "") {
        updateData['type'] = barang.type;
      }
      if (barang.deskripsi != "") {
        updateData['deskripsi'] = barang.deskripsi;
      }
      if (barang.imagePath != "") {
        updateData['imagePath'] = barang.imagePath;
      }
      if (barang.telepon != "") {
        updateData['telepon'] = barang.telepon;
      }
      if (barang.kehilangan != "") {
        updateData['kehilangan'] = barang.kehilangan;
      }
      if (barang.status != "") {
        updateData['status'] = barang.status;
      }

      await FirebaseFirestore.instance
          .collection('laporan')
          .doc(documentId)
          .update(updateData);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan sudah terupdate!')));
      Navigator.of(context).pop();
    } catch (e) {
      print('Error updating document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan gagal terupdate!')));
    }
  }

  //delete
  static Future<void> deleteLaporan(String id) async {
    await FirebaseFirestore.instance.collection('laporan').doc(id).delete();
  }
}
