import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:telu_adventure/page/login_page.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  testWidgets('Test sign in with email and password',
      (WidgetTester tester) async {
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com', password: 'password'))
        .thenAnswer((_) => Future.value(MockUserCredential()));

    await tester.pumpWidget(
      MaterialApp(
        // home: LoginPage(auth: mockFirebaseAuth),
        key: UniqueKey(), // Providing a UniqueKey
      ),
    );

    // Tap on login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Ensure that signInWithEmailAndPassword method is called
    verify(mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com', password: 'password'))
        .called(1);
  });
}
