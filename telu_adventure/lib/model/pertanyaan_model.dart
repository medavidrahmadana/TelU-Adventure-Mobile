import 'package:cloud_firestore/cloud_firestore.dart';

class pertanyaan_model {
  final String id;
  final String pertanyaan; // Path gambar lokal
  final String userid;
  final String nama;
  final String urlimg;
  final String waktu;

  pertanyaan_model({
    required this.id,
    required this.pertanyaan,
    required this.userid,
    required this.nama,
    required this.urlimg,
    required this.waktu,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'pertanyaan': pertanyaan,
        'userid': userid,
        'nama': nama,
        'urlimg': urlimg,
        'waktu' : waktu,
      };
}
