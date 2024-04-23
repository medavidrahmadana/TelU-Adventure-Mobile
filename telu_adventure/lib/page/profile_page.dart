import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _fullName = 'Indonesia U-23 vs Korea U-23';
  String _email = 'indololosolimpiade@afc.com';
  String _password = '********'; // Password diisi dengan tanda bintang sementara

  // Fungsi untuk menangani perubahan foto profil
  void _changeProfilePhoto() {
    // Tambahkan logika untuk mengubah foto profil
  }

  // Fungsi untuk menyimpan perubahan pada profil
  void _saveProfile() {
    // Tambahkan logika untuk menyimpan profil
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
                      backgroundImage: AssetImage('assets/img/Fadhil.png'), // Ganti dengan foto profil yang sesuai
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
              initialValue: _fullName,
              style: TextStyle(fontSize: 16.0), // Ganti ukuran teks input
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), // Ganti gaya garis input
              ),
            ),
            SizedBox(height: 20.0),
            Text('Email', style: TextStyle(fontSize: 18.0)),
            TextFormField(
              initialValue: _email,
              style: TextStyle(fontSize: 16.0), // Ganti ukuran teks input
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), // Ganti gaya garis input
              ),
            ),
            SizedBox(height: 20.0),
            Text('Password', style: TextStyle(fontSize: 18.0)),
            TextFormField(
              initialValue: _password,
              style: TextStyle(fontSize: 16.0), // Ganti ukuran teks input
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), // Ganti gaya garis input
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
