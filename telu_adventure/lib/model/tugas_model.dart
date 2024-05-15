import 'package:cloud_firestore/cloud_firestore.dart';

class Tugas {
  final String namaTugas;
  final String namaMatkul; 
  final String icon;
  final String deadline;
  final String status;

  Tugas(
      {required this.namaTugas,
      required this.namaMatkul,
      required this.icon,
      required this.deadline,
      required this.status});

  Map<String, dynamic> toMap() => {
        'namaTugas': namaTugas,
        'namaMatkul': namaMatkul,
        'icon': icon,
        'deadline': deadline,
        'status': status,
      };
}
