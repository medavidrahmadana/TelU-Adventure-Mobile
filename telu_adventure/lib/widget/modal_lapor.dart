import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';

class modal_lapor extends StatelessWidget {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _typeBarangController = TextEditingController();
  final TextEditingController _imageBarangController = TextEditingController();
  final TextEditingController _deskripsiBarangController = TextEditingController();
  final TextEditingController _lokasiBarangController = TextEditingController();

  modal_lapor({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25), // Set inset padding
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Lebar container utama
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  key: const ValueKey('tombol-close-modal-key'),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Lapor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 30), // Untuk keseimbangan
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _namaBarangController,
              decoration: InputDecoration(
                hintText: "Nama Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _typeBarangController,
                        decoration: InputDecoration(
                          hintText: "Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _imageBarangController,
                        decoration: InputDecoration(
                          hintText: "Foto",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10, // Positioning the camera icon
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFBB371A),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle camera icon press
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _deskripsiBarangController,
              decoration: InputDecoration(
                hintText: "Deskripsi Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _lokasiBarangController,
              decoration: InputDecoration(
                hintText: "No Handphone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB371A),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11), // Atur radius sesuai keinginan
                  // Tambahan properti untuk mengatur tepi (edge)
                ),
              ),
              child: const Text(
                'Lapor',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Barang barang = Barang(
                    nama: _namaBarangController.text,
                    type: _typeBarangController.text,
                    deskripsi: _deskripsiBarangController.text,
                    imagePath: _imageBarangController.text,
                    telepon: _lokasiBarangController.text,
                    kehilangan: FirebaseAuth.instance.currentUser!.uid,
                    status: "Belum",
                  );
                  LaporCon.addToFirestore(context, barang);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
