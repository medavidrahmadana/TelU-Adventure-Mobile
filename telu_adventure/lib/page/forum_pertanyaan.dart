import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';
import 'package:intl/intl.dart';


import '../controllers/forum_controller.dart';
import '../model/pertanyaan_model.dart';

class forum_pertanyaan extends StatelessWidget {
  forumCon _forumcon = forumCon();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text(
              'Tambah Pertanyaan',
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
                  Container(
                    margin: EdgeInsets.only(top: 12.0, left: 20.0),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFDA696C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
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
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Bertanya ',
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
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Apa yang anda ingin tanyakan?',
                  hintStyle: TextStyle(
                    color: Color(0xFF969696),
                    fontSize: 16.0,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color:
                      Colors.black, // Ganti dengan warna teks yang diinginkan
                  fontSize: 16.0,
                ),
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
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Future.delayed(Duration.zero, () {
                      final random = Random();
                      int randomNumber = random.nextInt(100);
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('dd-MM-yyyy').format(now); // Format tanggal sesuai keinginan Anda

                      pertanyaan_model forum = pertanyaan_model(
                        id: randomNumber.toString(),
                        pertanyaan: _controller.text, // Anda mungkin ingin menanganinya secara berbeda
                        userid: FirebaseAuth.instance.currentUser!.uid,
                        nama: FirebaseAuth.instance.currentUser?.displayName ?? 'User',
                        urlimg: FirebaseAuth.instance.currentUser!.photoURL!,
                        waktu: formattedDate, // Menentukan waktu dengan nilai formattedDate
                      );

                      forumCon.addToFirestore(context, forum);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFCA292E)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                  ),
                  child: Text('Tambah Pertanyaan',
                      style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
