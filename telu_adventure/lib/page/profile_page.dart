import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Memuat profil pengguna saat ini
  void _loadUserProfile() {
    User? user = _auth.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  // Fungsi untuk menangani perubahan foto profil
  void _changeProfilePhoto() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    // Menampilkan modal untuk memilih antara kamera dan galeri
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Capture Photo'),
            onTap: () async {
              Navigator.pop(context);
              await _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Select from Gallery'),
            onTap: () async {
              Navigator.pop(context);
              await _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih gambar dari sumber yang ditentukan
  Future<void> _pickImage(ImageSource source) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

        // Unggah gambar ke Firebase Storage
        String fileName = 'profile_photos/${user.uid}.jpg';
        UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(file);

        TaskSnapshot snapshot = await uploadTask;
        String photoURL = await snapshot.ref.getDownloadURL();

        // Perbarui URL foto profil pengguna
        await user.updatePhotoURL(photoURL);
        // Reload pengguna untuk memastikan perubahan disimpan
        await user.reload();
        user = _auth.currentUser;

        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Foto profil berhasil diperbarui.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengubah foto profil: $e')));
    }
  }

  // Fungsi untuk menyimpan perubahan pada profil
  void _saveProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Update nama tampilan
        if (_nameController.text.isNotEmpty) {
          await user.updateDisplayName(_nameController.text);
        }

        // Update email
        if (_emailController.text.isNotEmpty && _emailController.text != user.email) {
          await user.updateEmail(_emailController.text);
        }

        // Reload pengguna untuk memastikan perubahan disimpan
        await user.reload();
        user = _auth.currentUser;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profil berhasil diperbarui.')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memperbarui profil: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _changeProfilePhoto,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _auth.currentUser?.photoURL != null
                        ? NetworkImage(_auth.currentUser!.photoURL!)
                        : AssetImage('assets/img/Fadhil.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Full Name', style: TextStyle(fontSize: 18.0)),
            TextFormField(
              initialValue: _nameController.text,
              style: TextStyle(fontSize: 16.0),
              onChanged: (value) {
                setState(() {
                  _nameController.text = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Email', style: TextStyle(fontSize: 18.0)),
            TextFormField(
              initialValue: _emailController.text,
              style: TextStyle(fontSize: 16.0),
              enabled: false,
              onChanged: (value) {
                setState(() {
                  _emailController.text = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: _saveProfile,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
