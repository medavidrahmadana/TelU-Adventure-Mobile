import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/widget/modal_barang.dart';
import 'package:telu_adventure/page/lapor_page.dart';

import '../widget/modal_cari.dart';
import '../widget/modal_lapor.dart';
import 'lapor_page.dart';

class cari_page extends StatelessWidget {
  // Contoh nilai UID
  final LaporCon _laporCon = LaporCon();
  int _loadedItems = 3; // Jumlah awal item yang akan ditampilkan
  final int _loadThreshold = 3; // Jumlah item yang akan dimuat setiap kali di-scroll
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  cari_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
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
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    Container(
                      child: const Center(
                        child: ProfilePicture(),
                      ),
                    ),
Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, right: 20),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // Ubah warna latar belakang menjadi transparan
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                  style: const TextStyle(
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
                          if (uid != null)
                            StreamBuilder(
                              stream: _laporCon.getlaporanbystatus(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError ||
                                    snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                List<DocumentSnapshot> docs = snapshot.data!.docs;
                                int totalItems = docs.length;
                                int sudahItems = docs.where((doc) => doc['status'] == 'Sudah').length;
                                int belumItems = docs.where((doc) => doc['status'] == 'Belum').length;
                                return SizedBox(
                                  width: 250,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 25.0),
                                          child: Text(
                                            '$totalItems',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Center(
                                          child: Text(
                                            '$sudahItems',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 45.0),
                                        child: Text(
                                          '$belumItems',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          else
                            const Text(
                              'No User Data',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.0),
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(
                            'Selesai',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 17.0),
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
                            key: const ValueKey('tombol-halamanlapor-key'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  lapor_page()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                                side: const BorderSide(color: Colors.white),
                              ),
                              elevation: 5,
                            ),
                            child: Container(
                              width: 70,
                              height: 20,
                              alignment: Alignment.center,
                              child: const Text(
                                'Lapor',
                                style: TextStyle(
                                  color: Colors.black,
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBB371A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                                side: const BorderSide(color: Colors.white),
                              ),
                              elevation: 5,
                            ),
                            child: Container(
                              width: 70,
                              height: 20,
                              alignment: Alignment.center,
                              child: const Text(
                                'Cari',
                                style: TextStyle(
                                  color: Colors.white,
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 405, left: 25),
                    child: Text(
                      'List Barang',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBB371A),
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
                    color: const Color(0xFFF5F5F5),
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
                          icon: const Icon(Icons.more_vert),
                          color: Colors.grey[500],
                          iconSize: 32,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: _buildBarangListCari(context)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBarangListCari(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder(
      stream: _laporCon.getlaporanbystatus(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Tidak ada data'));
        }

        final docs = snapshot.data!.docs;
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels >= notification.metrics.maxScrollExtent &&
                _loadedItems < docs.length) {
              _loadedItems += _loadThreshold;
              if (_loadedItems >= docs.length) {
                _loadedItems = docs.length;
              }
            }
            return false;
          },
          child: ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              if (index >= _loadedItems) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return _buildLaporCariItem(docs[index], context);
            },
          ),
        );
      },
    );
  }

  void _loadMore() {
    final scrollController = ScrollController();
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      _loadedItems += _loadThreshold;
    }
  }

  Widget _buildLaporCariItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
      child: SizedBox(
        width: 350,
        height: 45,
        child: Row(
          children: [
            SizedBox(
              width: 170,
              height: 45,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: const Color.fromARGB(255, 228, 226, 226),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: data['imagePath'] != null &&
                              data['imagePath'].isNotEmpty
                          ? Image.network(
                              data['imagePath'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            )
                          : Icon(Icons.image_not_supported),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(data['nama'], style: const TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  data['type'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "inter",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 85,
              height: 45,
              child: Transform.rotate(
                angle: 90 * (22 / 7 / 180),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Stack(
                            children: <Widget>[
                              cari_page(),
                              SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: modal_cari(
                                  documentId: doc.id,
                                ), // Adjust this line to pass the correct documentId
                              ),
                            ],
                          );
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                  iconSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
