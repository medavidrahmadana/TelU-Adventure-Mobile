import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';
import 'dart:io';

class modal_lapor extends StatefulWidget {
  @override
  _modal_laporState createState() => _modal_laporState();
}

class _modal_laporState extends State<modal_lapor> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _typeBarangController = TextEditingController();
  final TextEditingController _imageBarangController = TextEditingController();
  final TextEditingController _deskripsiBarangController =
      TextEditingController();
  final TextEditingController _lokasiBarangController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageBarangController.text = pickedFile.name;
      });
      print('Image picked: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    if (_imageFile == null) return null;

    String fileName = _imageFile!.path.split('/').last;
    Reference storageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');

    try {
      TaskSnapshot snapshot = await storageRef.putFile(_imageFile!);
      String downloadURL = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully: $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _submitReport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage and get the download URL
      String? imageURL = await _uploadImageToFirebase();

      // Create Barang object with the image URL
      Barang barang = Barang(
        nama: _namaBarangController.text,
        type: _typeBarangController.text,
        deskripsi: _deskripsiBarangController.text,
        imagePath: imageURL ?? "",
        telepon: _lokasiBarangController.text,
        kehilangan: FirebaseAuth.instance.currentUser!.uid,
        status: "Belum",
      );

      // Add the Barang object to Firestore
      await LaporCon.addToFirestore(context, barang);
      print('Report submitted successfully');
    } catch (e) {
      print('Error during report submission: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 25), // Set inset padding
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
                            onPressed: _pickImage,
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
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB371A),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            11), // Atur radius sesuai keinginan
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
                    onPressed: _submitReport,
                  ),
          ],
        ),
      ),
    );
  }
}
