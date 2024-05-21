import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/forum_controller.dart';
import 'package:intl/intl.dart';

import '../model/jawab_model.dart';

class forum_jawab extends StatefulWidget {
  final String documentId;

  forum_jawab({Key? key, required this.documentId}) : super(key: key);

  @override
  _forum_jawabState createState() => _forum_jawabState();
}

class _forum_jawabState extends State<forum_jawab> {
  forumCon _forumcon = forumCon();

  String _pertanyaan = '';
  final TextEditingController _jawabanController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadPertanyaan();
  }

  Future<void> _loadPertanyaan() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('forum')
          .where('id', isEqualTo: widget.documentId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          _pertanyaan = data['pertanyaan'] ?? '';
        });
      } else {
        print('No document found with id: ${widget.documentId}');
      }
    } catch (e) {
      print('Error loading pertanyaan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text(
              'Jawab Pertanyaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              preferredSize: Size.fromHeight(13.0),
            ),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 45,
                      height: 45,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: FirebaseAuth
                                    .instance.currentUser!.photoURL !=
                                null
                            ? NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!)
                            : AssetImage('assets/img/Fadhil.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10), // Padding untuk 'Fadhil'
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Menjawab',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _pertanyaan,
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.0), // Menambahkan jarak antara teks
                  Container(
                    margin: EdgeInsets.only(left: 3.0),
                    child: TextField(
                      controller: _jawabanController, // Add controller here
                      decoration: InputDecoration(
                        hintText: 'Tulis jawaban kamu',
                        hintStyle: TextStyle(
                          color: Color(0xFF969696),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  20, 0, 20, 105), // Atur padding di sini
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat('dd-MM-yyyy')
                              .format(
                                  now); // Format tanggal sesuai keinginan Anda

                          jawab_model jawab = jawab_model(
                            idpertanyaan: widget.documentId,
                            jawaban: _jawabanController
                                .text, // Anda mungkin ingin menanganinya secara berbeda
                            userid: FirebaseAuth.instance.currentUser!.uid,
                            nama: FirebaseAuth
                                    .instance.currentUser?.displayName ??
                                'User',
                            urlimg:
                                FirebaseAuth.instance.currentUser!.photoURL!,
                            waktu:
                                formattedDate, // Menentukan waktu dengan nilai formattedDate
                          );

                          forumCon.addjawab(context, jawab);
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFCA292E)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(0, 50)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                      ),
                      child: Text('Jawab Pertanyaan',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFFFFFFFF))),
                    ),
                  ),
                  SizedBox(width: 15),
                  Image.asset(
                    'assets/img/photoicon.png',
                    height: 30, // Sesuaikan ukuran gambar sesuai kebutuhan
                    fit: BoxFit.contain, // Sesuaikan metode fill gambar
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
