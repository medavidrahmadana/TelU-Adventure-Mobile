import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:telu_adventure/page/map_page.dart';
import 'package:telu_adventure/widget/forum_notifikasi.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/page/login_page.dart';
import 'package:telu_adventure/page/achievement_page.dart';
import 'package:telu_adventure/page/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/home_controller.dart';
import 'package:telu_adventure/model/jadwalPelajaran_model.dart';
import 'package:telu_adventure/model/beasiswa_model.dart';
import 'package:telu_adventure/model/tugas_model.dart';
import 'package:telu_adventure/model/achievement_model.dart';

import '../Handler/DatabaseHelper.dart';

HomeController _controller = HomeController();

int currentListIndex = 0;
int currentPage = 0;

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Color(0xFFBB371A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  const Center(
                    child: ProfilePicture(),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const InfoBox(),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Jadwal Pelajaran',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA11E22),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder<List<jadwalPelajaran>>(
                      future: _controller.getJadwalPelajaran(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<jadwalPelajaran> jadwalList =
                              snapshot.data ?? [];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0), // Atur jarak kiri dan kanan
                            child: Row(
                              children:
                                  List.generate(jadwalList.length, (index) {
                                // Check if it's not the last item to add space after it
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: index < jadwalList.length - 1
                                          ? 20.0
                                          : 0.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: ModulOption(
                                      imagePath:
                                          'assets/img/Map.png', // Ganti dengan gambar yang sesuai
                                      topText: jadwalList[index].namaMatkul,
                                      bottomTexts: [
                                        jadwalList[index].namaGedung,
                                        jadwalList[index].ruangan,
                                        jadwalList[index].waktu
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Achievement',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Color(0xFFA11E22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => achievement_page()),
                            );
                          },
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const SingleChildScrollView(
                    // Tambahkan SingleChildScrollView di sini
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.0),
                        ModulAch(
                            topText: 'New Star',
                            imagePath: 'assets/img/Achievement.png'),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Beasiswa',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Color(0xFFA11E22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), // Atur jarak antara ListView
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder<List<Beasiswa>>(
                      future: _controller.getBeasiswa(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          ); // Menampilkan indikator loading di tengah saat data sedang dimuat
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          ); // Menampilkan pesan kesalahan di tengah jika terjadi error
                        } else {
                          List<Beasiswa> beasiswaList =
                              snapshot.data ?? []; // Mendapatkan data beasiswa
                          return Column(
                            children: beasiswaList.map((beasiswa) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: double
                                      .infinity, // Lebar kontainer mengikuti lebar layar
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Warna latar belakang kotak
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Sudut bulat kotak
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Warna bayangan
                                        spreadRadius:
                                            3, // Radius penyebaran bayangan
                                        blurRadius: 5, // Radius kabur bayangan
                                        offset: const Offset(
                                            0, 3), // Offset bayangan
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: SizedBox(
                                          height: 100, // Tinggi gambar
                                          child: Image.asset(
                                            beasiswa
                                                .image, // URL gambar beasiswa
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              beasiswa.namaBeasiswa,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              beasiswa.deskripsi,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Mengatur posisi antara icon button dan child lainnya
                    children: [
                      const Spacer(), // Spacer untuk menggeser icon button ke kanan
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, right: 20), // Ubah padding ke bagian kanan
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFEED1D1), // Warna latar belakang putih
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black, // Warna efek bayangan
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2), // Mengatur arah bayangan
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.orange,
                            ),
                            onPressed: () async {
                              // Delete the SQLite database
                              await DatabaseHelper().deleteDatabase();

                              // Navigate to the login page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman profil saat gambar profil ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: FirebaseAuth.instance.currentUser!.photoURL != null
            ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
            : const AssetImage('assets/img/Fadhil.png') as ImageProvider,
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // Get the current user UID

    return StreamBuilder<QuerySnapshot>(
      stream: _controller.getgedung(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          // Extract data from the snapshot
          var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          String perkuliahan = data['gedungk'] ?? "";
          String kantin = data['kantin'] ?? "";
          String nonPerkuliahan = data['gedungnk'] ?? "";

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          perkuliahan,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFFA11E22),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'G. Perkuliahan',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          kantin,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFFA11E22),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Kantin',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          nonPerkuliahan,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFFA11E22),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'G. Non Perkuliahan',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle event when explorasi button is pressed
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xFFA11E22)), // Warna latar merah
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Kurangi radius sudut
                            ),
                          ),
                        ),
                        child: const Text(
                          'Explorasi',
                          style: TextStyle(
                              color: Colors.white), // Warna teks putih
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ModulOption extends StatelessWidget {
  final String topText;
  final List<String> bottomTexts; // Mengubah bottomText menjadi List<String>
  final String imagePath;

  const ModulOption(
      {super.key,
      required this.topText,
      required this.bottomTexts,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 170.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color:
            const Color(0xFFA11E22), // Ganti warna latar belakang menjadi merah
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0,
                right: 0.0,
                bottom: 40.0,
                left: 0.0), // Sesuaikan nilai sesuai kebutuhan
            child: Image.asset(
              imagePath, // Path gambar
              width: 100, // Lebar gambar, sesuaikan sesuai kebutuhan
              height: 100, // Tinggi gambar, sesuaikan sesuai kebutuhan
            ),
          ),
          const SizedBox(width: 10.0), // Spasi antara gambar dan teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topText, // Judul modul
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
                const SizedBox(height: 5.0),
                // Menampilkan setiap baris bottom text dalam lingkaran dengan border putih
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bottomTexts.map((text) {
                    return Row(
                      children: [
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Warna border putih
                              width: 1.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(right: 5.0),
                        ),
                        Expanded(
                          child: Text(
                            text,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white, // Warna teks putih
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(
                    height: 10.0), // Spasi antara bottom text dan tombol
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => map_page()),
                    );
                    // Handle event when navigasi button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar belakang putih
                  ),
                  child: const Text(
                    'Navigasi',
                    style: TextStyle(color: Colors.black), // Warna teks hitam
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModulAch extends StatelessWidget {
  final String topText;
  final String imagePath;

  const ModulAch({super.key, required this.topText, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tambahkan kode untuk menampilkan efek fireworks di sini
        // Contoh: menampilkan dialog atau animasi fireworks
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Congratulations!"),
              content: Text("You've achieved $topText!"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                topText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModulInfoBox extends StatelessWidget {
  final String title;
  final String dateTime;

  const ModulInfoBox({super.key, required this.title, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA11E22),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            dateTime,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
