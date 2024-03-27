import 'package:flutter/material.dart';
import 'package:telu_adventure/page/course_vid_page.dart';

class course_page extends StatelessWidget {
  const course_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          // Tambahkan SingleChildScrollView di sini
          child: Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFBB371A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.0),
                  Center(
                    child: ProfilePicture(),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'David',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InfoBox(),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Course',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA11E22),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SingleChildScrollView(
                    // Tambahkan SingleChildScrollView di sini
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.0),
                        CourseOption(text: 'Mobpro'),
                        SizedBox(width: 10.0),
                        CourseOption(text: 'Proting 3'),
                        SizedBox(width: 10.0),
                        CourseOption(text: 'Kewirausahaan'),
                        SizedBox(width: 10.0),
                        CourseOption(text: 'Mobile Legends'),
                        SizedBox(width: 10.0),
                        CourseOption(text: 'Wrap Humic'),
                        SizedBox(width: 20.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    // Tambahkan SingleChildScrollView di sini
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      vid_page(/* Data khusus untuk CLO 1 */)),
                            );
                          },
                          child: ModulOption(
                              topText: 'CLO 1', bottomText: 'Flutter'),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman vid_page untuk CLO 2 - Dart
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      vid_page(/* Data khusus untuk CLO 2 */)),
                            );
                          },
                          child:
                              ModulOption(topText: 'CLO 2', bottomText: 'Dart'),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman vid_page untuk CLO 3 - Firebase
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      vid_page(/* Data khusus untuk CLO 3 */)),
                            );
                          },
                          child: ModulOption(
                              topText: 'CLO 3', bottomText: 'Firebase'),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman vid_page untuk CLO 4 - State Management
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      vid_page(/* Data khusus untuk CLO 4 */)),
                            );
                          },
                          child: ModulOption(
                              topText: 'CLO 4', bottomText: 'State Management'),
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Latihan Soal',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Color(0xFFA11E22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // Fungsi yang akan dijalankan saat tombol teks ditekan
                          },
                          child: Text(
                            'Lainnya',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ModulInfoBox(
                        title: 'Installasi Flutter',
                        dateTime: '20 Maret 2024, 15.00-15.30',
                      ),
                      ModulInfoBox(
                        title: 'Membuat Project Flutter',
                        dateTime: '21 Maret 2024, 10.30-11.30',
                      ),
                      ModulInfoBox(
                        title: 'Push Rank Epic II - Mythic',
                        dateTime: '22 Maret 2024, 00.00-03.00',
                      ),
                      ModulInfoBox(
                        title: 'Membuat Tampilan Sederhana',
                        dateTime: '23 Maret 2024, 08.00-09.30',
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: AssetImage('assets/img/profil.png'),
    );
  }
}

class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '8',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFA11E22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Matkul',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFA11E22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Video',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFA11E22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseOption extends StatefulWidget {
  final String text;

  CourseOption({required this.text});

  @override
  _CourseOptionState createState() => _CourseOptionState();
}

class _CourseOptionState extends State<CourseOption> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isSelected
            ? Color(0xFFA11E22)
            : Colors
                .white, // Mengatur warna latar belakang sesuai dengan kondisi
        disabledBackgroundColor: _isSelected
            ? Colors.white
            : Colors.black, // Mengatur warna teks sesuai dengan kondisi
        elevation: 5, // Menambahkan efek bayangan ketika tombol ditekan
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ModulOption extends StatefulWidget {
  final String topText;
  final String bottomText;

  ModulOption({required this.topText, required this.bottomText});

  @override
  _ModulOptionState createState() => _ModulOptionState();
}

class _ModulOptionState extends State<ModulOption> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0, // Tambahkan batasan tinggi di sini
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          width: 150.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _isSelected ? Color(0xFFA11E22) : Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.topText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: _isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Spacer(),
              Text(
                widget.bottomText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: _isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionGroup extends StatelessWidget {
  final String courseText;
  final String exerciseText;

  OptionGroup({required this.courseText, required this.exerciseText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          courseText,
          style: TextStyle(
            color: Color(0xFFA11E22),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Lainnya",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA11E22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                exerciseText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA11E22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ModulInfoBox extends StatelessWidget {
  final String title;
  final String dateTime;

  ModulInfoBox({required this.title, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA11E22),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            dateTime,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
