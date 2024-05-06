import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telu_adventure/page/register_page.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return super.noSuchMethod(
      Invocation.method(
        #createUserWithEmailAndPassword,
        null,
        {#email: email, #password: password},
      ),
      returnValue: Future.value(MockUserCredential()),
      returnValueForMissingStub: Future.value(MockUserCredential()),
    );
  }
}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('RegisterPage', () {
    late MockFirebaseAuth mockFirebaseAuth;

    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockFirebaseAuth = MockFirebaseAuth();
    });

    testWidgets('Register with valid credentials', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterPage(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Masukkan Email');
      final passwordField =
          find.widgetWithText(TextField, 'Masukkan kata sandi');
      final registerButton = find.widgetWithText(ElevatedButton, 'Daftar');

      await tester.enterText(emailField, 'test@test.com');
      await tester.enterText(passwordField, 'password123');

      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password123',
      )).thenAnswer((_) async => MockUserCredential());

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
    testWidgets('Register with invalid credentials',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterPage(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Masukkan Email');
      final passwordField =
          find.widgetWithText(TextField, 'Masukkan kata sandi');
      final registerButton = find.widgetWithText(ElevatedButton, 'Daftar');

      await tester.enterText(emailField, 'test@test.com');
      await tester.enterText(passwordField, '');

      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@test.com',
        password: '',
      )).thenThrow(FirebaseAuthException(code: 'weak-password'));

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Check if the RegisterPage is still present after the unsuccessful registration
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
