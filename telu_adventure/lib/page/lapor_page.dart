import 'package:flutter/material.dart';
import 'package:telu_adventure/page/forum_notifikasi.dart';
import 'package:telu_adventure/page/login_page.dart';

import 'modal_lapor.dart';

class Barang {
  final String nama;
  final String imagePath; // Path gambar lokal
  final String type;

  Barang({required this.nama, required this.imagePath, required this.type});
}

// Daftar contoh data
List<Barang> dataList = [
  Barang(
      nama: 'Item 1', imagePath: 'assets/gambar_barang1.png', type: 'Type 1'),
  Barang(
      nama: 'Item 2', imagePath: 'assets/gambar_barang2.png', type: 'Type 2'),
  Barang(
      nama: 'Item 3', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
  Barang(
      nama: 'Item 4', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
  Barang(
      nama: 'Item 5', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
  Barang(
      nama: 'Item 6', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
  Barang(
      nama: 'Item 7', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
  Barang(
      nama: 'Item 8', imagePath: 'assets/gambar_barang3.png', type: 'Type 3'),
];

class lapor_page extends StatelessWidget {
  const lapor_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Color(0xFFBB371A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 30),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              Colors.transparent, // Warna latar belakang putih
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Ganti dengan warna yang diinginkan
                        borderRadius:
                            BorderRadius.circular(9), // Menambahkan radius
                        image: DecorationImage(
                          image: AssetImage('assets/img/Fadhil.png'),
                          fit: BoxFit.cover, // Atur cara gambar ditampilkan
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, right: 20),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              Color(0xFFEED1D1), // Warna latar belakang putih
                          borderRadius: BorderRadius.circular(
                              9), // Radius sudut 30 (agar bundar)
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
                            Icons.notifications,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Stack(
                                    children: <Widget>[
                                      lapor_page(), // Menambahkan forum_dashboard di belakang forum_notifikasi
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
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Penambahan spasi antara profil dan nama pengguna
                Text(
                  'Fadhil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 225, left: 22.5),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(21),
              child: Container(
                width: 350,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '8',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            'Selesai',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 17.0),
                          child: Text(
                            'Belum',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your button 1 action here
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(
                                      0xFFBB371A)), // Mengatur warna latar belakang tombol
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      9), // Mengatur radius
                                  side: BorderSide(
                                      color: Color(
                                          0xFFBB371A)), // Jika ingin memberikan border
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(
                                  5), // Menambahkan efek bayangan
                            ),
                            child: Container(
                              width: 70,
                              height: 20,
                              alignment: Alignment.center,
                              child: Text(
                                'Cari',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your button 1 action here
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors
                                      .white), // Mengatur warna latar belakang tombol
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      9), // Mengatur radius
                                  side: BorderSide(
                                      color: Colors
                                          .white), // Jika ingin memberikan border
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(
                                  5), // Menambahkan efek bayangan
                            ),
                            child: Container(
                              width: 70,
                              height: 20,
                              alignment: Alignment.center,
                              child: Text(
                                'Lapor',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 405, left: 25),
                    child: Text(
                      'List Barang Dicari',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBB371A),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 410.0, left: 70),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang putih
                        borderRadius: BorderRadius.circular(
                            13), // Radius sudut 30 (agar bundar)
                        border: Border.all(
                          color: Color.fromARGB(255, 228, 226, 226),
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Implement your notification button functionality here
                        },
                        icon: Icon(Icons.search),
                        color: Color(0xFFBB371A),
                        iconSize: 32, // Warna ikon
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 410.0, left: 15),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Color.fromARGB(255, 228, 226, 226),
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Stack(
                                  children: <Widget>[
                                    lapor_page(), // Menambahkan forum_dashboard di belakang forum_notifikasi
                                    SlideTransition(
                                      position: Tween<Offset>(
                                        begin: Offset(0, 0),
                                        end: Offset(0, 0),
                                      ).animate(animation),
                                      child: modal_lapor(),
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
                        icon: Icon(Icons.add),
                        color: Color(0xFFBB371A),
                        iconSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 350,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Barang',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0, right: 60),
                        child: Text(
                          'Type',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: 90 * (22 / 7 / 180),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                          color: Colors.grey[500],
                          iconSize: 32,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Letakkan ListView.builder di sini
              ListView.builder(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0), // Menambahkan padding vertikal
                itemExtent: 60.0, // Menentukan tinggi setiap item
                shrinkWrap: true,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final barang = dataList[index];
                  return Row(
                    children: [
                      // Widget untuk gambar
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang putih
                            borderRadius: BorderRadius.circular(
                                13), // Radius sudut 30 (agar bundar)
                            border: Border.all(
                              color: Color.fromARGB(255, 228, 226, 226),
                              width: 2,
                            ),
                          ),
                          // child: Image.asset(
                          //   barang.imagePath,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child:
                            Text(barang.nama, style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child:
                            Text(barang.type, style: TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 55.0,
                        ),
                        child: Transform.rotate(
                          angle: 90 * (22 / 7 / 180),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert),
                            color: Colors.grey[500],
                            iconSize: 32,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
