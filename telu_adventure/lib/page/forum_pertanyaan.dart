import 'package:flutter/material.dart';

class forum_pertanyaan extends StatelessWidget {
  const forum_pertanyaan({Key? key}) : super(key: key);

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
                      child: Image.asset('assets/img/forum-image1.png'),
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
                          'Fadhil',
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
              child: Text(
                'Apa yang anda ingin tanyakan?',
                style: TextStyle(
                  color: Color(0xFF969696),
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
                    // Aksi yang ingin dilakukan saat tombol ditekan
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
