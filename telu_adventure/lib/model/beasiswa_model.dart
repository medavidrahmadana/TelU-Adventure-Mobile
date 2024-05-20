import 'package:cloud_firestore/cloud_firestore.dart';

class Beasiswa {
  final String namaBeasiswa;
  final String image; // Path gambar lokal
  final String deskripsi;

  Beasiswa(
      {required this.namaBeasiswa,
      required this.image,
      required this.deskripsi});

  Map<String, dynamic> toMap() => {
        'nama': namaBeasiswa,
        'image': image,
        'deskripsi': deskripsi,
      };
}
