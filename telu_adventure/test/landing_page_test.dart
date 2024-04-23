import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telu_adventure/page/landing_page.dart';

void main() {
  testWidgets('Pengujian Widget Halaman Landing', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: landing_page()));

    await tester.pumpAndSettle();

    // -- Ekspektasi
    expect(find.text('Jelajahi TelU dengan\nTelU Adventure'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.semanticLabel == 'gambar_landing',
      ),
      findsOneWidget,
    );
    expect(find.text('Mulai'), findsOneWidget);
  });
}
