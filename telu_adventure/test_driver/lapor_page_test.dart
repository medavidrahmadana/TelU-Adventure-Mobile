import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:telu_adventure/firebase_options.dart';
import 'package:telu_adventure/page/cari_page.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/widget/modal_lapor.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets(
      "Ketika di halaman lapor, cari tombol tambah lalu tekan tombolnya dan muncul modal. "
      "Jika muncul modal, maka cari widget di dalamnya, dan keluar dari modal tersebut.",
      (WidgetTester tester) async {
    // Simulasikan login dengan email dan kata sandi yang telah ada
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: 'dhafa@test.com',
        password: 'dhafatest',
      );

      // Pastikan pengguna telah berhasil login
      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.email, 'dhafa@test.com');
    } catch (e) {
      print('Error during sign in: $e');
    }

    // Mulai tes
    await tester.pumpWidget(MaterialApp(home: lapor_page()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tombol-tambah-lapor-key')));
    await tester.pumpAndSettle(); // Pastikan modal muncul dengan menunggu pumpAndSettle()

    expect(find.byWidget(modal_lapor()), findsNothing);
    expect(find.text("Lapor"), findsWidgets);
    expect(find.byType(TextField), findsWidgets);
    expect(find.byType(ElevatedButton), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('tombol-close-modal-key')));
    await tester.pumpAndSettle();

    expect(find.byWidget(lapor_page()), findsNothing);
  });

  testWidgets(
      "Cari Modal Lapor\n\n"
      "Di halaman lapor, cari tombol untuk menuju halaman cari, tekan lalu dialihkan ke halaman tersebut.\n "
      "Jika muncul, maka cari teks List Barang. Sesudahnya, dialihkan kembali ke halaman lapor.",
      (WidgetTester tester) async {
    // Simulasikan login dengan email dan kata sandi yang telah ada
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: 'dhafa@test.com',
        password: 'dhafatest',
      );

      // Pastikan pengguna telah berhasil login
      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.email, 'dhafa@test.com');
    } catch (e) {
      print('Error during sign in: $e');
    }

    // Mulai tes
    await tester.pumpWidget(MaterialApp(home: lapor_page()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tombol-halamancari-key')));
    await tester.pumpAndSettle();

    expect(find.byWidget(cari_page()), findsNothing);
    expect(find.text("List Barang"), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('tombol-halamanlapor-key')));
    await tester.pumpAndSettle();

    expect(find.byWidget(lapor_page()), findsNothing);
  });
}
