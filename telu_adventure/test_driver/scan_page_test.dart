import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:telu_adventure/firebase_options.dart';
import 'package:telu_adventure/page/scan_page.dart';
import 'package:telu_adventure/widget/nav_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  const CameraDescription cameraDescription = CameraDescription(
    name: 'mock_camera',
    lensDirection: CameraLensDirection.back,
    sensorOrientation: 0,
  );

  testWidgets(
      "Tes Scan\n\n"
      "Ketika berada di halaman beranda, pergi ke scan untuk scan sebuah qrcode.\n"
      "Setelah scan terbuka, kembali lagi ke halaman beranda", (WidgetTester tester) async {
    // Login terlebih dahulu
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: 'dhafa@test.com',
        password: 'dhafatest',
      );

      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.email, 'dhafa@test.com');
    } catch (e) {
      print('Error during sign in: $e');
    }

    // Mulai tes

    // pump widget navbar
    await tester.pumpWidget(MaterialApp(home: NavButton()));
    await tester.pumpAndSettle();

    expect(find.byWidget(MaterialApp(home: NavButton())), findsWidgets);

    // cari floating button, lalu klik button nya
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // muncul page scan, lalu cek halamannya
    expect(find.byType(ScanPage), findsOneWidget);
    expect(find.text("Scan Page"), findsWidgets);

    // verifikasi apakah qrview muncul
    expect(find.byKey(GlobalKey(debugLabel: 'QR')), findsOneWidget);
  });

  // testWidgets(
  //     "Simulasi QR\n\n"
  //     "Ketika sudah di halaman scan, coba untuk simulasi ketika scan qr code.", (WidgetTester tester) async {
  //   // Login terlebih dahulu
  //   try {
  //     final FirebaseAuth auth = FirebaseAuth.instance;
  //     await auth.signInWithEmailAndPassword(
  //       email: 'dhafa@test.com',
  //       password: 'dhafatest',
  //     );

  //     expect(auth.currentUser, isNotNull);
  //     expect(auth.currentUser!.email, 'dhafa@test.com');
  //   } catch (e) {
  //     print('Error during sign in: $e');
  //   }

  //   // Mulai tes

  //   // pump widget qr camera
  //   await tester.pumpWidget(const MaterialApp(
  //     home: ScanPage(camera: cameraDescription),
  //   ));
  // });
}
