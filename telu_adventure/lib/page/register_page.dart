import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/logo_datar.png',
              height: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Daftar',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Gabung ke TelU Adventure',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: Colors.grey[600],
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Masukkan nama pengguna',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: Colors.grey[600],
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Masukkan kata sandi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registerWithEmailAndPassword(
                  usernameController.text,
                  passwordController.text,
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
            SizedBox(height: 20),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
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
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username, // Gunakan email sebagai nama pengguna untuk contoh ini
        password: password,
      );
      // Registrasi berhasil, arahkan pengguna ke halaman lain jika diperlukan
      print('User registered: ${userCredential.user?.uid}');
    } catch (e) {
      // Tangani kesalahan selama proses registrasi
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal melakukan registrasi: $e')),
      );
    }
  }
}
