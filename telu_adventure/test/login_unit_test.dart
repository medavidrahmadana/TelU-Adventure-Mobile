import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockBuildContext extends Mock implements BuildContext {}

Future<bool> _signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    // Lakukan proses login menggunakan signInWithEmailAndPassword
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // Navigasi ke halaman lapor_page setelah login berhasil
    return true;
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => NavButton()),
    // );
    // Jika login berhasil, arahkan pengguna ke halaman lain jika diperlukan
    // print('User logged in: ${userCredential.user?.uid}');
    return true;
  } catch (e) {
    // Tangani kesalahan selama proses login
    // print('Error during login: $e');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Gagal melakukan login: $e')),
    // );
    print(e.toString());
    return false;
  }
}

void main() {
  setUpAll(() async {
    // Initialize Firebase
    await Firebase.initializeApp();
  });

  test('Login with valid email and password', () async {
    final String email = "test@test.com";
    final String password = "testtest";
    final BuildContext context = MockBuildContext();

    bool berhasil = await _signInWithEmailAndPassword(email, password, context);
    expect(berhasil, true);
  });

  test('Login with invalid email and password', () async {
    final String email = 'testinvalid@test.com';
    final String password = 'testinvalid';
    final BuildContext context = MockBuildContext();

    bool berhasil = await _signInWithEmailAndPassword(email, password, context);

    expect(berhasil, false);
  });
}
