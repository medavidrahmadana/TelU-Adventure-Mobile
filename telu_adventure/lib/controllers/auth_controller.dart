import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/model/userdetail_model.dart';

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

  static Future<void> addToFirestore(
      BuildContext context, udetail_model udetail_model) async {
    try {
      await FirebaseFirestore.instance
          .collection("userdetail")
          .add(udetail_model.toMap());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan sudah terkirim!')));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Laporan gagal terkirim!')));
      Navigator.pop(context); // Assuming this is in a new screen
    }
  }
}
