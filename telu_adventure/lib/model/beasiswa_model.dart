import 'package:cloud_firestore/cloud_firestore.dart';

class Beasiswa {
  final String namaBeasiswa;
  final String image; // Path gambar lokal
  final String status;
  final String deskripsi;

  Beasiswa(
      {required this.namaBeasiswa,
      required this.image,
      required this.status,
      required this.deskripsi});

  Map<String, dynamic> toMap() => {
        'nama': namaBeasiswa,
        'image': image,
        'status': status,
        'deskripsi': deskripsi,
      };
}
