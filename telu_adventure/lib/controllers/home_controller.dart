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
          namaBeasiswa: doc['nama'] ?? '',
          image: doc['image'] ?? '',
          status: doc['status'] ?? '',
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
    List<Tugas> tugasList = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tugas').get();
      querySnapshot.docs.forEach((doc) {
        Tugas tugas = Tugas(
          namaTugas: doc['namaTugas'] ?? '',
          namaMatkul: doc['namaMatkul'] ?? '',
          icon: doc['icon']??'',
          deadline: doc['deadline'] ?? '',
          status: doc['status'] ?? '',
        );
        tugasList.add(tugas);
      });
    } catch (e) {
      print('Error fetching tugas: $e');
    }
    return tugasList;
  }
}
