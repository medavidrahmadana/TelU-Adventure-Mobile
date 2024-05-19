import 'package:cloud_firestore/cloud_firestore.dart';

class Barang {
  final String nama;
  final String imagePath; // Path gambar lokal
  final String type;
  final String deskripsi;
  final String lokasi;
  final String kehilangan;
  final String status;

  Barang({
    required this.deskripsi,
    required this.lokasi,
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
        'lokasi': lokasi,
        'kehilangan': kehilangan,
        'status': status,
      };
}
