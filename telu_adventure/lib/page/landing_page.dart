import 'package:flutter/material.dart';
import 'login_page.dart';

class landing_page extends StatelessWidget {
  const landing_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 30,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/logo_datar.png',
                  height: 50,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 25),
                  child: Text(
                    'Jelajahi TelU dengan\nTelU Adventure',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SizedBox(
                    width: 650,
                    height: 650,
                    child: Image.asset(
                      'assets/img/Mask Group.png',
                    ),
                  ),
                ),
                SizedBox(height: 20), // Menambah jarak antara gambar dan tombol
              ],
            ),
          ),
          Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 650, bottom: 20), // Padding untuk tombol
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFCA292E)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                  ),
                  child: Text(
                    'Mulai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
