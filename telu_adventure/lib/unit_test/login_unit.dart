// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:telu_adventure/page/login_page.dart';
// import 'package:telu_adventure/widget/nav_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// void main() {
//   group('_signInWithEmailAndPassword', () {
//     test('successfully logs in with valid email and password', () async {
//       // Create a mock FirebaseAuth instance
//       MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();

//       // Set up the mock FirebaseAuth instance to return a UserCredential
//       when(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       ))
//           .thenAnswer((_) async => UserCredential(
//                 user: User(
//                   uid: 'user_id',
//                 ),
//               ));

//       // Create an instance of LoginPage
//       LoginPage loginPage = LoginPage();

//       // Call the _signInWithEmailAndPassword function
//       await loginPage._signInWithEmailAndPassword(
//         'test@example.com',
//         'password',
//         context,
//       );

//       // Verify that the mock FirebaseAuth instance was called with the correct parameters
//       verify(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: 'test@example.com',
//         password: 'password',
//       ));

//       // Verify that the UserCredential returned by the mock FirebaseAuth instance was not null
//       expect(loginPage.userCredential, isNotNull);
//     });

//     test('handles an error during login', () async {
//       // Create a mock FirebaseAuth instance
//       MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();

//       // Set up the mock FirebaseAuth instance to throw an error
//       when(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       ))
//           .thenThrow(Exception('An error occurred during login'));

//       // Create an instance of LoginPage
//       LoginPage loginPage = LoginPage();

//       // Call the _signInWithEmailAndPassword function
//       await expectLater(
//         loginPage._signInWithEmailAndPassword(
//           'test@example.com',
//           'password',
//           context,
//         ),
//         throwsException('An error occurred during login'),
//       );

//       // Verify that the mock FirebaseAuth instance was called with the correct parameters
//       verify(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: 'test@example.com',
//         password: 'password',
//       ));
//     });
//   });
// }