import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';

class modal_barang extends StatelessWidget {
  final String documentId; // Mengasumsikan Anda meneruskan ID dokumen ke modal
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _deskripsiBarangController =
      TextEditingController();
  final List<String> _statusOptions = ['Sudah', 'Belum'];
  String _selectedStatus = 'Belum'; // Nilai default

  modal_barang({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 25), // Atur inset padding
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Lebar kontainer utama
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Lapor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        try {
                          LaporCon.deleteLaporan(
                              documentId); // Memanggil fungsi deleteKompetisi
                          Navigator.of(context)
                              .pop(); // Menutup modal setelah menghapus
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Laporan berhasil dihapus'),
                              duration: Duration(seconds: 2), // Durasi snackbar
                            ),
                          );
                        } catch (error) {
                          print('Error deleting laporan: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Gagal menghapus laporan'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),

                    SizedBox(width: 10), // Untuk keseimbangan
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            TextField(
              controller: _namaBarangController,
              decoration: InputDecoration(
                hintText: "Nama Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  _selectedStatus = newValue;
                }
              },
              decoration: InputDecoration(
                hintText: "Status Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _deskripsiBarangController,
              decoration: InputDecoration(
                hintText: "Deskripsi Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFBB371A)),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 50),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        11), // Atur radius sesuai keinginan
                  ),
                ),
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Barang _barang = Barang(
                    nama: _namaBarangController.text,
                    type: '', // Anda mungkin ingin menanganinya secara berbeda
                    deskripsi: _deskripsiBarangController.text,
                    imagePath: '', // Karena gambar dihapus
                    telepon: '', // Karena lokasi dihapus
                    kehilangan: FirebaseAuth.instance.currentUser!.uid,
                    status: _selectedStatus,
                  );
                  LaporCon.updateFirestore(context, documentId, _barang);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
