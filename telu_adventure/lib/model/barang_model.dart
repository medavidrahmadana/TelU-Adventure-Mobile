import 'package:cloud_firestore/cloud_firestore.dart';

class Barang {
  final String nama;
  final String imagePath; // Path gambar lokal
  final String type;
  final String deskripsi;
  final String telepon;
  final String kehilangan;
  final String status;

  Barang({
    required this.deskripsi,
    required this.telepon,
    required this.nama,
    required this.imagePath,
    required this.type,
    required this.kehilangan,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        'nama': nama,
        'imagePath': imagePath,
        'type': type,
        'deskripsi': deskripsi,
        'telepon': telepon,
        'kehilangan': kehilangan,
        'status': status,
      };
}
