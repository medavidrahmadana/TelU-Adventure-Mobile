import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telu_adventure/page/login_page.dart';
import 'package:telu_adventure/widget/nav_button.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return super.noSuchMethod(
      Invocation.method(
        #signInWithEmailAndPassword,
        [],
        {#email: email, #password: password},
      ),
      returnValue: Future.value(MockUserCredential()),
      returnValueForMissingStub: Future.value(MockUserCredential()),
    );
  }
}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('LoginPage', () {
    late MockFirebaseAuth mockFirebaseAuth;

    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockFirebaseAuth = MockFirebaseAuth();
    });
    testWidgets('Login with valid credentials navigates to NavButton',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(firebaseAuth: mockFirebaseAuth),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Masukan Email');
      final passwordField =
          find.widgetWithText(TextField, 'Enter your password');
      final loginButton = find.widgetWithText(ElevatedButton, 'Login').first;

      await tester.enterText(emailField, 'test@test.com');
      await tester.enterText(passwordField, 'xxxx');

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'xxxx',
      )).thenAnswer((_) async => MockUserCredential());

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byType(NavButton), findsOneWidget);
    });
  });
}
