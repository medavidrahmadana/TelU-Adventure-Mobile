import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/nav_button.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // Lakukan proses login menggunakan signInWithEmailAndPassword
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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

  Future<User?> registerUser(
      String email, String password, String displayName) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(displayName);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }
}
