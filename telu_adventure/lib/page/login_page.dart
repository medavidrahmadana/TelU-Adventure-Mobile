import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/widget/nav_button.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _firebaseAuth;

  LoginPage({Key? key, FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(key: key);
  // Method untuk login menggunakan email dan password
  Future<User?> _signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // Lakukan proses login menggunakan signInWithEmailAndPassword
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigasi ke halaman lapor_page setelah login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavButton()),
      );
      // Jika login berhasil, arahkan pengguna ke halaman lain jika diperlukan
      return userCredential.user;
    } catch (e) {
      // Tangani kesalahan selama proses login
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal melakukan login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = ''; // Variabel untuk menyimpan email dari input pengguna
    String password =
        ''; // Variabel untuk menyimpan password dari input pengguna

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 180.0, top: 40),
              child: Image.asset(
                'assets/img/logo_datar.png',
                height: 50,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 230.0, top: 20),
              child: Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100.0, top: 10),
              child: Text(
                'Masuk ke TelU Adventure',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: Colors.grey[500],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 265),
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: Colors.grey[600],
                ),
              ),
            ),
            Container(
              width: 300,
              height: 150,
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value) {
                  email = value; // Simpan email saat diubah
                },
                decoration: InputDecoration(
                  labelText: 'Masukan Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 230),
              child: Container(
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 150,
              padding: EdgeInsets.only(top: 16.0),
              child: TextField(
                onChanged: (value) {
                  password = value; // Simpan password saat diubah
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Panggil method _signInWithEmailAndPassword saat tombol login ditekan
                _signInWithEmailAndPassword(email, password, context);
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
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle navigation to register page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      'Daftar sekarang',
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
            ),
          ],
        ),
      ),
    );
  }
}
