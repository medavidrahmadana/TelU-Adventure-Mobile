import 'package:flutter/material.dart';
import 'package:telu_adventure/page/forum_jawab.dart';
import 'package:telu_adventure/page/forum_pertanyaan.dart';
import '../widget/forum_notifikasi.dart';

class forum_dashboard extends StatelessWidget {
  forum_dashboard({super.key});

  final GlobalKey notificationKey = GlobalKey();
  final GlobalKey profileKey = GlobalKey();
  final GlobalKey questionUserKey = GlobalKey();
  final GlobalKey questionUserTapKey = GlobalKey();
  final GlobalKey userQuestionerKey = GlobalKey();
  final GlobalKey userQuestionKey = GlobalKey();
  final GlobalKey answerButtonKey = GlobalKey();
  final GlobalKey cardUserAnswerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            title: const Text(
              'Forum Tanya Jawab',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    IconButton(
                      key: notificationKey,
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return Stack(
                                children: <Widget>[
                                  forum_dashboard(), // Menambahkan forum_dashboard di belakang forum_notifikasi
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1.0, 0.0),
                                      end: const Offset(0.2, 0.0),
                                    ).animate(animation),
                                    child: const forum_notifikasi(),
                                  ),
                                ],
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDA696C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/img/forum-image1.png', // Path ke file gambar di dalam folder assets
                      key: profileKey,
                      width:
                          30, // Sesuaikan dengan ukuran gambar yang diinginkan
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    key: questionUserTapKey,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Stack(
                              children: <Widget>[
                                forum_dashboard(), // Menampilkan forum_dashboard di belakang forum_pertanyaan
                                SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(
                                        0.0, 1.0), // Mulai dari bawah layar
                                    end: const Offset(0.0,
                                        0.1), // Berhenti saat terbuka sebagian (misalnya 0.6)
                                  ).animate(animation),
                                  child: ClipRect(
                                    child:
                                        forum_pertanyaan(), // forum_pertanyaan yang terbuka sebagian
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      key: questionUserKey,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Apa yang ingin Anda tanyakan?',
                            style: TextStyle(color: Color(0xFF969696)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 25), // jarak
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(2, (index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, // jarak padding kanan kiri
                          vertical: 1.0,
                        ),
                        child: Container(
                          key: userQuestionerKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD966),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'A',
                                    style: TextStyle(
                                      color: Color(
                                          0xFF1E1E1E), // Warna huruf abu-abu gelap
                                      fontWeight: FontWeight
                                          .bold, // Membuat huruf tebal
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Abdul Hamid',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          'bertanya · ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '3 jam',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0), // jarak padding kanan kiri
                        child: Column(
                          key: userQuestionKey,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Emangnya di asrama ada cerita horor ya? Soalnya aku mau asrama nanti',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Row(
                              children: [
                                Text(
                                  'Belum ada jawaban',
                                  style: TextStyle(
                                    color: Color(0xFF797979),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                key: answerButtonKey,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return Stack(
                                          children: <Widget>[
                                            forum_dashboard(), // Menampilkan forum_dashboard di belakang forum_pertanyaan
                                            SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(0.0,
                                                    1.0), // Mulai dari bawah layar
                                                end: const Offset(0.0,
                                                    0.1), // Berhenti saat terbuka sebagian (misalnya 0.6)
                                              ).animate(animation),
                                              child: ClipRect(
                                                child:
                                                    forum_jawab(), // forum_jawab yang terbuka sebagian
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFFCA292E),
                                ),
                                label: const Text(
                                  'Jawab',
                                  style: TextStyle(
                                    color: Color(0xFFCA292E),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Mengatur border radius
                                    ),
                                  ),
                                  side: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const BorderSide(
                                          color: Colors.red,
                                          width:
                                              2); // Warna outline saat tombol ditekan
                                    }
                                    return const BorderSide(
                                        color: Color(0xFFCA292E),
                                        width: 1); // Warna outline default
                                  }),
                                  // Tambahan properti lain seperti warna, padding, dll dapat ditambahkan di sini
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
