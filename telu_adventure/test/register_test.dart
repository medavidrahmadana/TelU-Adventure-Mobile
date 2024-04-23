import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockBuildContext extends Mock implements BuildContext {}

Future<bool> _registerWithEmailAndPassword(
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
    return true;
  } catch (e) {
    // Tangani kesalahan selama proses registrasi
    print('Error during registration: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal melakukan registrasi: $e')),
    );
    return false;
  }
}

void main() {
  setUpAll(() async {
    // Initialize Firebase
    await Firebase.initializeApp();
  });
  test('register with valid email and password', () async {
    final String username = "test1@test.com";
    final String password = "testtest";
    final BuildContext context = MockBuildContext();

    bool berhasil =
        await _registerWithEmailAndPassword(username, password, context);
    expect(berhasil, true);
  });
}
