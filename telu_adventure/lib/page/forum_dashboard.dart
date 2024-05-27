import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/page/forum_jawab.dart';
import 'package:telu_adventure/page/forum_komentar.dart';
import 'package:telu_adventure/page/forum_pertanyaan.dart';
import '../widget/forum_notifikasi.dart';
import 'package:telu_adventure/model/pertanyaan_model.dart';
import 'package:telu_adventure/controllers/forum_controller.dart';

forumCon _controller = forumCon();

class forum_dashboard extends StatelessWidget {
  forum_dashboard({Key? key});

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
                              return child!;
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
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        FirebaseAuth.instance.currentUser!.photoURL != null
                            ? NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!)
                            : AssetImage('assets/img/Fadhil.png')
                                as ImageProvider,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
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
            Expanded(
              child: FutureBuilder<List<pertanyaan_model>>(
                future: _controller.getPertanyaan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<pertanyaan_model> pertanyaan_list =
                        snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: pertanyaan_list.length,
                      itemBuilder: (context, index) {
                        pertanyaan_model pertanyaan = pertanyaan_list[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFD966),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                        pertanyaan.urlimg,
                                        fit: BoxFit
                                            .cover, // Opsional, sesuaikan sesuai kebutuhan
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pertanyaan.nama,
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
                                                pertanyaan.waktu,
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
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pertanyaan.pertanyaan,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  forum_komentar(
                                                documentId: pertanyaan.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Lihat Komentar',
                                          style: TextStyle(
                                            color: Color(0xFF797979),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return Stack(
                                                children: <Widget>[
                                                  forum_dashboard(),
                                                  SlideTransition(
                                                    position: Tween<Offset>(
                                                      begin: const Offset(
                                                          0.0, 1.0),
                                                      end: const Offset(
                                                          0.0, 0.1),
                                                    ).animate(animation),
                                                    child: ClipRect(
                                                      child: forum_jawab(
                                                        documentId:
                                                            pertanyaan.id,
                                                      ),
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
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return const BorderSide(
                                                color: Colors.red,
                                                width:
                                                    2); // Warna outline saat tombol ditekan
                                          }
                                          return const BorderSide(
                                              color: Color(0xFFCA292E),
                                              width:
                                                  1); // Warna outline default
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
