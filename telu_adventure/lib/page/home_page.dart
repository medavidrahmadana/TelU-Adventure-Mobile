import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/widget/forum_notifikasi.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/page/login_page.dart';
import 'package:telu_adventure/page/achievement_page.dart';
import 'package:telu_adventure/page/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/home_controller.dart';
import 'package:telu_adventure/model/jadwalPelajaran_model.dart';

HomeController _controller = HomeController();

class Tugas {
  final String nama;
  final String deskripsi;
  final String imagePath;
  final String waktu;

  Tugas(
      {required this.nama,
      required this.deskripsi,
      required this.imagePath,
      required this.waktu});
}

List<Tugas> dataList = [
  Tugas(
      nama: 'Quiz Minggu 3',
      deskripsi: 'Manajemen Proyek IT SE 45.01',
      imagePath: 'assets/img/quiz.png',
      waktu: '1d 11j 12m 04d'),
  Tugas(
      nama: 'assesment CLO 1',
      deskripsi: 'PBO SE 45.01',
      imagePath: 'assets/img/task.png',
      waktu: '1d 11j 12m 04d'),
  Tugas(
      nama: 'Quiz minggu 4',
      deskripsi: 'Tatulim SE 45.01',
      imagePath: 'assets/img/quiz.png',
      waktu: '1d 11j 12m 04d'),
  Tugas(
      nama: 'Quiz Minggu 4',
      deskripsi: 'Manajemen Proyek IT SE 45.01',
      imagePath: 'assets/img/quiz.png',
      waktu: '1d 11j 12m 04d'),
  Tugas(
      nama: 'assesment CLO 3',
      deskripsi: 'PBO SE 45.01',
      imagePath: 'assets/img/task.png',
      waktu: '1d 11j 12m 04d'),
  Tugas(
      nama: 'Quiz minggu 6',
      deskripsi: 'Tatulim SE 45.01',
      imagePath: 'assets/img/quiz.png',
      waktu: '1d 11j 12m 04d')
];

class Beasiswa {
  final String nama;
  final String deskripsi;
  final String imagePath;

  Beasiswa(
      {required this.nama, required this.deskripsi, required this.imagePath});
}

List<Beasiswa> dataList1 = [
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg'),
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg'),
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg'),
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg'),
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg'),
  Beasiswa(
      nama: 'Oksigen Education 2023',
      deskripsi: '21 Juli 2022 - 27 Juli 2022',
      imagePath: 'assets/img/oksigen.jpeg')
];

int currentListIndex = 0;
int currentPage = 0;

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    final List<Tugas> currentData = dataList;

    final List<List<Tugas>> pages = [];
    for (int i = 0; i < currentData.length; i += 4) {
      pages.add(currentData.sublist(
          i, i + 4 > currentData.length ? currentData.length : i + 4));
    }
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
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
                  SizedBox(height: 50.0),
                  Center(
                    child: ProfilePicture(),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InfoBox(),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder<List<jadwalPelajaran>>(
                      future: _controller
                          .getJadwalPelajaran(), // Menggunakan home_controller
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<jadwalPelajaran> jadwalList =
                              snapshot.data ?? [];
                          return Row(
                            children: jadwalList.map((jadwal) {
                              return SizedBox(
                                width: 200, // Lebar masing-masing item
                                child: ModulOption(
                                  imagePath:
                                      'assets/img/Map.png', // Ganti dengan gambar yang sesuai
                                  topText: jadwal.namaMatkul,
                                  bottomTexts: [
                                    jadwal.namaGedung,
                                    jadwal.ruangan,
                                    jadwal.waktu
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Column(
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
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => achievement_page()),
                            );
                          },
                          child: Text(
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
                  SizedBox(height: 10.0),
                  SingleChildScrollView(
                    // Tambahkan SingleChildScrollView di sini
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.0),
                        ModulAch(
                            topText: 'Still Free',
                            imagePath: 'assets/img/scholar.png'),
                        SizedBox(width: 10.0),
                        ModulAch(
                            topText: 'Task Master',
                            imagePath: 'assets/img/task_achievement.png'),
                        SizedBox(width: 10.0),
                        ModulAch(
                            topText: 'Food Place',
                            imagePath: 'assets/img/restaurant.png'),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Tugas',
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
                  ),

                  ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemExtent: 100.0,
                    shrinkWrap: true,
                    itemCount:
                        pages[currentPage].length + (pages.length > 1 ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == pages[currentPage].length &&
                          pages.length > 1) {
                        // Tampilkan pagination
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (pageIndex) => Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 3.0, right: 3.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage = pageIndex;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    backgroundColor: currentPage == pageIndex
                                        ? Color(0xFFA11E22)
                                        : Colors.white,
                                    minimumSize: Size(35, 50),
                                  ),
                                  child: Text(
                                    (pageIndex + 1).toString(),
                                    style: TextStyle(
                                      color: currentPage == pageIndex
                                          ? Colors.white
                                          : Color(0xFFA11E22),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final Tugas = dataList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  Tugas.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Tugas.nama,
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      Tugas.deskripsi,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'waktu Tersisa',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '1d 11j 12m 04d',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemExtent:
                        70.0, // Asumsi tinggi kotak adalah 120.0, sesuaikan sesuai kebutuhan Anda
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final Beasiswa = dataList1[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang kotak
                            borderRadius: BorderRadius.circular(
                                10.0), // Sudut bulat kotak
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Warna bayangan
                                spreadRadius: 3, // Radius penyebaran bayangan
                                blurRadius: 5, // Radius kabur bayangan
                                offset: Offset(0, 3), // Offset bayangan
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        10.0), // Sudut bulat atas kiri
                                    bottomLeft: Radius.circular(
                                        10.0), // Sudut bulat bawah kiri
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(Beasiswa.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Beasiswa.nama,
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      Beasiswa.deskripsi,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 1),
                              TextButton(
                                onPressed: () {
                                  // Implementasi aksi yang dijalankan saat tombol ditekan
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Menempatkan row di tengah secara horizontal
                                  children: [
                                    Transform.rotate(
                                      angle: 0, // Sudut rotasi 0 derajat
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFFA11E22), // Warna latar belakang teks
                                          borderRadius: BorderRadius.circular(
                                              8.0), // Radius sudut kotak
                                        ),
                                        padding: EdgeInsets.all(
                                            8.0), // Padding untuk memberi ruang di sekitar teks
                                        child: Text(
                                          'Lihat',
                                          style: TextStyle(
                                            fontSize: 16, // Ukuran teks
                                            color: Colors.white, // Warna teks
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Mengatur posisi antara icon button dan child lainnya
                    children: [
                      Spacer(), // Spacer untuk menggeser icon button ke kanan
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, right: 20), // Ubah padding ke bagian kanan
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                Color(0xFFEED1D1), // Warna latar belakang putih
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black, // Warna efek bayangan
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2), // Mengatur arah bayangan
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
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
        backgroundImage: FirebaseAuth.instance.currentUser!.photoURL!= null 
        ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
        : AssetImage('assets/img/Fadhil.png') as ImageProvider,
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
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
                    '5',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFFA11E22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
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
                    '2',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFFA11E22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
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
                    '2',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFFA11E22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
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
          SizedBox(height: 20.0),
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Kurangi radius sudut
                      ),
                    ),
                  ),
                  child: Text(
                    'Explorasi',
                    style: TextStyle(color: Colors.white), // Warna teks putih
                  ),
                ),
              ),
              SizedBox(width: 10), // Spacer
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle event when kesehatan button is pressed
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white), // Warna latar putih
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0.0), // Kurangi radius sudut
                      ),
                    ),
                  ),
                  child: Text(
                    'Kesehatan',
                    style: TextStyle(color: Colors.black), // Warna teks hitam
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModulOption extends StatelessWidget {
  final String topText;
  final List<String> bottomTexts; // Mengubah bottomText menjadi List<String>
  final String imagePath;

  ModulOption(
      {required this.topText,
      required this.bottomTexts,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 170.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFA11E22), // Ganti warna latar belakang menjadi merah
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
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
          SizedBox(width: 10.0), // Spasi antara gambar dan teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topText, // Judul modul
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
                SizedBox(height: 5.0),
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
                          margin: EdgeInsets.only(right: 5.0),
                        ),
                        Expanded(
                          child: Text(
                            text,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white, // Warna teks putih
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10.0), // Spasi antara bottom text dan tombol
                ElevatedButton(
                  onPressed: () {
                    // Handle event when navigasi button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Warna latar belakang putih
                  ),
                  child: Text(
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

  ModulAch({required this.topText, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.all(10.0), // Tambahkan margin 10.0 di semua sisi container
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Mengatur agar column menyesuaikan ukuran widget
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(
                bottom: 10.0), // Tambahkan jarak pada bagian bawah
            child: Text(
              topText,
              textAlign:
                  TextAlign.center, // Mengatur agar teks berada di tengah
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ubah warna teks menjadi hitam
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModulInfoBox extends StatelessWidget {
  final String title;
  final String dateTime;

  ModulInfoBox({required this.title, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA11E22),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            dateTime,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
