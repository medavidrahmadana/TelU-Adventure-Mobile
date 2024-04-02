import 'package:flutter/material.dart';

class forum_notifikasi extends StatelessWidget {
  const forum_notifikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Row(
              children: [
                SizedBox(width: 1), // Memberikan jarak antara ikon dan teks
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 2), // Memberikan jarak antara ikon dan teks
                Text(
                  'Notifikasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            bottom: PreferredSize(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/Notif.png', // Path ke file gambar di dalam folder assets
                width: 200, // Ubah ukuran
                height: 200,
              ),
              Text(
                'Tidak ada notifikasi',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18), // Mengatur ukuran teks
              ),
            ],
          ),
        ),
      ),
    );
  }
}
