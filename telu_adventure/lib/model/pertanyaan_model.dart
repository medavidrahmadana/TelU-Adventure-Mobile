import 'package:cloud_firestore/cloud_firestore.dart';

class pertanyaan_model {
  final String id;
  final String pertanyaan;
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

  pertanyaan_model.fromDocumentSnapshot(QueryDocumentSnapshot snapshot)
      : id = snapshot.id,
        pertanyaan = snapshot['pertanyaan'],
        userid = snapshot['userid'],
        nama = snapshot['nama'],
        urlimg = snapshot['urlimg'],
        waktu = snapshot['waktu'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'pertanyaan': pertanyaan,
        'userid': userid,
        'nama': nama,
        'urlimg': urlimg,
        'waktu': waktu,
      };
}
