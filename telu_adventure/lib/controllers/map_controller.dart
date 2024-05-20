import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/model/gedung_model.dart';

// Controller untuk mengelola data lokasi
class mapCon {
  // Mendapatkan data lokasi dari Firestore
  Future<List<gedung>> getLocationsFromFirestore() async {
    List<gedung> locations = [];
    // Mendapatkan data dari koleksi "gedung" di Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('gedung').get();

    // Memetakan data Firestore menjadi objek Location
    querySnapshot.docs.forEach((doc) {
      String namaGedung = doc['namaGedung'];
      String latitude = doc['Lat'];
      String longitude = doc['Long'];
      locations.add(gedung(
        Lat: latitude,
        Long: longitude,
        namaGedung: namaGedung,
      ));
    });

    return locations;
  }
}
