import 'package:flutter/material.dart';

class forum_dashboard extends StatelessWidget {
  const forum_dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text(
              'Forum Tanya Jawab',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add logic to handle notifications here
                      },
                    ),
                  ],
                ),
              ),
            ],
            bottom: PreferredSize(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFDA696C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'Apa yang ingin Anda tanyakan?',
                          style: TextStyle(color: Color(0xFF969696)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 25), // jarak
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0, // jarak padding kanan kiri
                vertical: 1.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD966),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Color(0xFF1E1E1E), // Warna huruf abu-abu gelap
                          fontWeight: FontWeight.bold, // Membuat huruf tebal
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abdul Hamid',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'bertanya · ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '3 jam',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 35.0), // jarak padding kanan kiri
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emangnya di asrama ada cerita horor ya? Soalnya aku mau asrama nanti',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Belum ada jawaban',
                        style: TextStyle(
                          color: Color(0xFF797979),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Add function to handle response to the answer button here
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFCA292E),
                      ),
                      label: Text(
                        'Jawab',
                        style: TextStyle(
                          color: Color(0xFFCA292E),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Mengatur border radius
                          ),
                        ),
                        side: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                                color: Colors.red,
                                width: 2); // Warna outline saat tombol ditekan
                          }
                          return BorderSide(
                              color: Color(0xFFCA292E),
                              width: 1); // Warna outline default
                        }),
                        // Tambahan properti lain seperti warna, padding, dll dapat ditambahkan di sini
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 30), // jarak padding kanan kiri
              child: Padding(
                padding: const EdgeInsets.all(
                    14.0), // padding kanan kiri 30 maka edge insert 14, dan jika 20 makan edge inset 16
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFD966),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'A',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ambatukam',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Menjawab · ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '5 jam',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Saran jalan ke masjid telkom lewat mana ya yang cepet?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Kalau maksudnya cepat dari segi jarak tempuh\nmaupun waktu, saya menyarankan anda untuk\nmemilih lewat GKU, lalu lurus melewati gedung\nrektorat, ambil jalan kiri menuju gate 3.\nSesudahnya, belok kanan untuk lewat ke\ngedung cacuk, lurus terus dan anda sampai di\nmasjid.',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
