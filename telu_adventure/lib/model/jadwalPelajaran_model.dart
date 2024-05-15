import 'package:cloud_firestore/cloud_firestore.dart';

class jadwalPelajaran{
  final String namaMatkul;
  final String namaGedung; // Path gambar lokal
  final String ruangan;
  final String waktu;

  jadwalPelajaran(
      {required this.namaMatkul,
      required this.namaGedung,
      required this.ruangan,
      required this.waktu});

  Map<String, dynamic> toMap() => {
        'namaMatkul': namaMatkul,
        'namaGedung': namaGedung,
        'ruangan': ruangan,
        'waktu': waktu,
      };
}
