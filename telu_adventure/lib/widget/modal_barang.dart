import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';

class modal_barang extends StatelessWidget {
  final String documentId; // Assuming you pass the document ID to the modal
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _deskripsiBarangController =
      TextEditingController();
  final List<String> _statusOptions = ['Sudah', 'Belum'];
  String _selectedStatus = 'Belum'; // Default value

  modal_barang({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 25), // Set inset padding
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Lebar container utama
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
                SizedBox(width: 30), // Untuk keseimbangan
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
                    type: '', // You may want to handle this differently
                    deskripsi: _deskripsiBarangController.text,
                    imagePath: '', // Since image is removed
                    lokasi: '', // Since lokasi is removed
                    kehilangan: FirebaseAuth.instance.currentUser!.uid,
                    status: _selectedStatus,
                  );
                  LaporCon.updateFirestore(context, documentId, _barang);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
