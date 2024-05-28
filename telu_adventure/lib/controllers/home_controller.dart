import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/model/beasiswa_model.dart';
import 'package:telu_adventure/model/jadwalPelajaran_model.dart';
import 'package:telu_adventure/model/tugas_model.dart';
import 'package:telu_adventure/model/achievement_model.dart';
import 'package:telu_adventure/model/userdetail_model.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Beasiswa>> getBeasiswa() async {
    List<Beasiswa> beasiswaList = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('beasiswa').get();
      querySnapshot.docs.forEach((doc) {
        Beasiswa beasiswa = Beasiswa(
          namaBeasiswa: doc['namaBeasiswa'] ?? '',
          image: doc['image'] ?? '',
          deskripsi: doc['deskripsi'] ?? '',
        );
        beasiswaList.add(beasiswa);
      });
    } catch (e) {
      print('Error fetching beasiswa: $e');
    }
    return beasiswaList;
  }

  Future<List<jadwalPelajaran>> getJadwalPelajaran() async {
    List<jadwalPelajaran> jadwalList = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('jadwalPelajaran').get();
      querySnapshot.docs.forEach((doc) {
        jadwalPelajaran jadwal = jadwalPelajaran(
          namaMatkul: doc['namaMatkul'] ?? '',
          namaGedung: doc['namaGedung'] ?? '',
          ruangan: doc['ruangan'] ?? '',
          waktu: doc['waktu'] ?? '',
        );
        jadwalList.add(jadwal);
      });
    } catch (e) {
      print('Error fetching jadwal pelajaran: $e');
    }
    return jadwalList;
  }

  Stream<QuerySnapshot> getgedung(String uid) {
    return _firestore
        .collection('userdetail')
        .where('uid', isEqualTo: uid) // Filter berdasarkan uid
        .snapshots();
  }

 Stream<QuerySnapshot> getAchievement(String UID) {
    return _firestore
        .collection('achievement')
        .where('UID', isEqualTo: UID) // Filter berdasarkan uid
        .snapshots();
  }
  // Future<List<Achievement>> getAchievement(String UID) async {
  //   List<Achievement> achievementList = [];
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('achievements')
  //         .where('UID', isEqualTo: UID) // Ganti 'UID' dengan 'uid' jika di Firestore menggunakan huruf kecil
  //         .get();
  //     querySnapshot.docs.forEach((doc) {
  //       Achievement achievement = Achievement(
  //         UID: doc['UID'] ?? '', // Gunakan doc['UID'] atau doc['uid'] sesuai dengan yang ada di Firestore
  //         namaAchievement: doc['namaAchievement'] ?? '',
  //         gambarAchievement: doc['gambarAchievement'] ?? '',
  //         status: doc['status'] ?? '',
  //       );
  //       achievementList.add(achievement);
  //     });
  //   } catch (e) {
  //     print('Error fetching Achievement: $e');
  //   }
  //   return achievementList;
  // }
}
