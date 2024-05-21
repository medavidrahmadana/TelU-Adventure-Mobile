import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forum_jawab extends StatelessWidget {
  forum_jawab({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.only(left : 15.0),
                    child: Container(
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
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10), // Padding untuk 'Fadhil'
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName?? "",
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
                    'Emangnya di asrama ada cerita horor ya?\nSoalnya aku mau asrama nanti',
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
                        Navigator.pop(context);
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
