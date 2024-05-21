import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  final String UID;
  final String namaAchievement; 
  final String gambarAchievement;
  final String status;


  Achievement(
      {required this.UID,
      required this.namaAchievement,
      required this.gambarAchievement,
      required this.status,
});

  Map<String, dynamic> toMap() => {
        'UID': UID,
        'namaAchievement': namaAchievement,
        'gambarAchievement': gambarAchievement,
        'status': status,
      };
}