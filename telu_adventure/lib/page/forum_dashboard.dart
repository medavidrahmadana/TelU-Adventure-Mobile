import 'package:flutter/material.dart';
import 'package:telu_adventure/page/forum_jawab.dart';
import 'package:telu_adventure/page/forum_pertanyaan.dart';
import 'forum_notifikasi.dart';

class forum_dashboard extends StatelessWidget {
  const forum_dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text(
              'Forum Tanya Jawab',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(right: 16),
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
                      icon: Icon(
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
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.2, 0.0),
                                    ).animate(animation),
                                    child: forum_notifikasi(),
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
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFDA696C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/img/forum-image1.png', // Path ke file gambar di dalam folder assets
                      width:
                          30, // Sesuaikan dengan ukuran gambar yang diinginkan
                      height: 30,
                    ),
                  ),
                ),
                SizedBox(width: 16),
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
                                    begin: Offset(
                                        0.0, 1.0), // Mulai dari bawah layar
                                    end: Offset(0.0,
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
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
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
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 25), // jarak
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0, // jarak padding kanan kiri
                vertical: 1.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD966),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Color(0xFF1E1E1E), // Warna huruf abu-abu gelap
                          fontWeight: FontWeight.bold, // Membuat huruf tebal
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
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
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 35.0), // jarak padding kanan kiri
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emangnya di asrama ada cerita horor ya? Soalnya aku mau asrama nanti',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Belum ada jawaban',
                        style: TextStyle(
                          color: Color(0xFF797979),
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return Stack(
                                children: <Widget>[
                                  forum_dashboard(), // Menampilkan forum_dashboard di belakang forum_pertanyaan
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(
                                          0.0, 1.0), // Mulai dari bawah layar
                                      end: Offset(0.0,
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
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFCA292E),
                      ),
                      label: Text(
                        'Jawab',
                        style: TextStyle(
                          color: Color(0xFFCA292E),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Mengatur border radius
                          ),
                        ),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                                color: Colors.red,
                                width: 2); // Warna outline saat tombol ditekan
                          }
                          return BorderSide(
                              color: Color(0xFFCA292E),
                              width: 1); // Warna outline default
                        }),
                        // Tambahan properti lain seperti warna, padding, dll dapat ditambahkan di sini
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 30), // jarak padding kanan kiri
              child: Padding(
                padding: const EdgeInsets.all(
                    14.0), // padding kanan kiri 30 maka edge insert 14, dan jika 20 makan edge inset 16
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFD966),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/img/forum-image2.png', // Path ke file gambar di dalam folder assets
                              width:
                                  45, // Sesuaikan dengan ukuran gambar yang diinginkan
                              height: 45,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ambatukam',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Menjawab · ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '5 jam',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Saran jalan ke masjid telkom lewat mana ya yang cepet?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Kalau maksudnya cepat dari segi jarak tempuh\nmaupun waktu, saya menyarankan anda untuk\nmemilih lewat GKU, lalu lurus melewati gedung\nrektorat, ambil jalan kiri menuju gate 3.\nSesudahnya, belok kanan untuk lewat ke\ngedung cacuk, lurus terus dan anda sampai di\nmasjid.',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
