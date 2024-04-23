import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telu_adventure/page/forum_dashboard.dart';

void main() {
  testWidgets('Pengujian Halaman Dashboard Forum', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: forum_dashboard()));

    await tester.pumpAndSettle();

    // -- Tes apakah ada title di app bar
    expect(find.text('Forum Tanya Jawab'), findsOneWidget);

    // -- Tes apakah ada tombol notifikasi
    expect(find.byKey(const ValueKey('notificationKey')), findsOneWidget);

    // -- Tes apakah ada foto profil
    expect(find.byKey(const ValueKey('profileKey')), findsOneWidget);

    // -- Tes apakah ada container untuk menjawab
    expect(find.byKey(const ValueKey('questionUserKey')), findsOneWidget);

    // -- Tes apakah ada user yang sedang bertanya
    expect(find.byKey(const ValueKey('userQuestionerKey')), findsOneWidget);

    // -- Tes pertanyaan user
    expect(find.byKey(const ValueKey('userQuestionKey')), findsOneWidget);

    // -- Tes apakah ada tombol untuk menjawab pertanyaan user
    expect(find.byKey(const ValueKey('answerButtonKey')), findsOneWidget);

    // -- Tes apakah ada yang menjawab pertanyaan user yang bertanya
    expect(find.byKey(const ValueKey('cardUserAnswerKey')), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
  });
}
