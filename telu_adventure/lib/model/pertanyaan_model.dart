import 'package:cloud_firestore/cloud_firestore.dart';

class pertanyaan_model {
  final String id;
  final String pertanyaan; // Path gambar lokal
  final String userid;

  pertanyaan_model({
    required this.id,
    required this.pertanyaan,
    required this.userid,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'pertanyaan': pertanyaan,
        'userid': userid,
      };
}
