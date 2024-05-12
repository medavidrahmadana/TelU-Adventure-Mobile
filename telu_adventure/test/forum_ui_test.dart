import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tes Komponen Halaman Dashboard Forum', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.requestData('forum_dashboard');
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Cek Judul di App Bar', () async {
      SerializableFinder appBarTitleFinder = find.text('Forum Tanya Jawab');

      expect(await driver.getText(appBarTitleFinder), 'Forum Tanya Jawab');
    });

    test('Cek Notifikasi', () async {
      SerializableFinder notificationIconFinder = find.byValueKey('notificationKey');

      await driver.tap(notificationIconFinder);
    });

    test('Cek Foto Profil', () async {
      SerializableFinder profilePictureFinder = find.byValueKey('profileKey');

      expect(driver.waitFor(profilePictureFinder), completes);
    });

    test('Cek Field Text User', () async {
      SerializableFinder containerFinder = find.byValueKey('questionUserKey');

      expect(await driver.getText(containerFinder), 'Apa yang ingin Anda tanyakan?');
    });

    test('Tap Container Text Field Tanya', () async {
      SerializableFinder containerFinder = find.byValueKey('questionUserTapKey');

      await driver.tap(containerFinder);
    });

    test('Cari Container User Bertanya', () async {
      SerializableFinder userQuestionerKeyFinder = find.byValueKey('userQuestionerKey');
      await driver.waitFor(userQuestionerKeyFinder);
      expect(await driver.getText(userQuestionerKeyFinder), isNotNull);
    });

    test('Cari Pertanyaan User di Container User Bertanya', () async {
      SerializableFinder userQuestionKeyFinder = find.byValueKey('userQuestionKey');
      await driver.waitFor(userQuestionKeyFinder);
      expect(await driver.getText(userQuestionKeyFinder), isNotNull);
    });

    test('Cari Card Tentang Jawaban User Untuk Pertanyaan Yang Ada', () async {
      SerializableFinder cardUserAnswerKeyFinder = find.byValueKey('cardUserAnswerKey');
      await driver.waitFor(cardUserAnswerKeyFinder);
      expect(await driver.getText(cardUserAnswerKeyFinder), isNotNull);
    });
  });
}
