import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/model/beasiswa_model.dart';
import 'package:telu_adventure/model/jadwalPelajaran_model.dart';
import 'package:telu_adventure/model/tugas_model.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Beasiswa>> getBeasiswa() async {
    List<Beasiswa> beasiswaList = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('beasiswa').get();
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
      QuerySnapshot querySnapshot = await _firestore.collection('jadwalPelajaran').get();
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

  Future<List<Tugas>> getTugas() async {
    List<Tugas> tugasList = [Tugas(
       namaTugas: 'Quiz minggu 6',
       namaMatkul: 'Tatulim SE 45.01',
       icon: 'assets/img/quiz.png',
       deadline: '1d 11j 12m 04d')];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tugas').get();
      querySnapshot.docs.forEach((doc) {
        Tugas tugas = Tugas(
          namaTugas: doc['namaTugas'] ?? '',
          namaMatkul: doc['namaMatkul'] ?? '',
          icon: doc['icon']??'',
          deadline: doc['deadline'] ?? '',
        );
        tugasList.add(tugas);
      });
    } catch (e) {
      print('Error fetching tugas: $e');
    }
    return tugasList;
  }
}
