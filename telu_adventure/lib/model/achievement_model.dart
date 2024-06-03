import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  final String id;
  final String namaAchievement; 
  final String gambarAchievement;
  final String syarat;



  Achievement(
      {required this.id,
      required this.namaAchievement,
      required this.gambarAchievement,
      required this.syarat,

});

  Map<String, dynamic> toMap() => {
        'id': id,
        'namaAchievement': namaAchievement,
        'gambarAchievement': gambarAchievement,
        'syarat': syarat,
      };
}