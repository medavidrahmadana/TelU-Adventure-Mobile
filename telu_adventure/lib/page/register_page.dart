import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 200.0, top: 50),
              child: Image.asset(
                'assets/img/logo_datar.png',
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240.0, top: 20),
              child: Text(
                'Daftar',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 90.0, top: 10),
              child: Text(
                'Gabung ke TelU Adventure',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: Colors.grey[500],
                ),
              ),
            ),
            SizedBox(height: 50), // Jarak antara judul dan field pertama
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0), // Menambah jarak vertikal
                Container(
                  width: 300,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Menambah jarak vertikal antara form
                Text(
                  'Nama',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0), // Menambah jarak vertikal
                Container(
                  width: 300,
                  child: TextField(
                    controller: displayNameController,
                    decoration: InputDecoration(
                      labelText: 'Masukkan nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Menambah jarak vertikal antara form
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.0), // Menambah jarak vertikal
                Container(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Masukkan kata sandi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _registerWithEmailAndPassword(
                  usernameController.text,
                  passwordController.text,
                  displayNameController.text,
                  "",
                  context,
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFCA292E)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(Size(300, 50)),
              ),
              child: Text(
                'Daftar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
                height:
                    20), // Jarak antara tombol Daftar dan teks Masuk sekarang
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun? ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle navigation to login page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Masuk sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: Colors.red[800], // Merah
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerWithEmailAndPassword(
    String username,
    String password,
    String displayName,
    String pathimg,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      await userCredential.user!.updateDisplayName(displayName);
      await userCredential.user!.updatePhotoURL(pathimg);
      // Registrasi berhasil, arahkan pengguna ke halaman login
      print('User registered: ${userCredential.user?.uid}');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('berhasil registrasi!!')),
      );
    } catch (e) {
      // Tangani kesalahan selama proses registrasi
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal melakukan registrasi: $e')),
      );
    }
  }
}
