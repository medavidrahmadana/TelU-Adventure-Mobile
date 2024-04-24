import 'package:flutter/material.dart';

class Modal_map extends StatelessWidget {
  const Modal_map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text(
              'Detail Gedung',
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
              icon: Icon(Icons.arrow_back),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 20),
                    child: Container(
                      width: 300,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius value as needed
                        child: Image.asset(
                          'assets/img/Rektorat-large.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 40),
                    child: Text(
                      "Gedung Bangkit Rektorat",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 270),
                    child: Text(
                      "100 m",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  //button open camera, didalam container border warna abu" icon didalam container lagi berwarna merah containernya beradius camera dan text hitam
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 160),
                    child: Text(
                      "Tentang Gedung",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 40, right: 35),
                    child: Text(
                      "Gedung bangkit atau biasa disebut dengan gedung rektorat merupakan gedung yang di fungsikan untuk rektorat. Penamaan kata bangkit sendiri di ambil dari pulau bangkit yang terletak di Sulawesi Utara.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFCA292E)),
                              minimumSize:
                                  MaterialStateProperty.all<Size>(Size(0, 50)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14))),
                            ),
                            child: Text('Mulai',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFFFFFFFF))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            onPressed: () {
                              // Tambahkan logika untuk membuka kamera atau pemindaian di sini
                            },
                            icon: Icon(Icons.camera_alt),
                            color: Colors
                                .black, // Sesuaikan dengan warna yang kamu inginkan
                            iconSize:
                                30, // Sesuaikan ukuran ikon yang diinginkan
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
