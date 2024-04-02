import 'package:flutter/material.dart';
import 'package:telu_adventure/page/course_vid_page.dart';

class CoursePage extends StatelessWidget {
  CoursePage({Key? key}) : super(key: key);

  // Daftar Course Option
  final List<Map<String, String>> courses = [
    {'text': 'Mobpro'},
    {'text': 'Proting 3'},
    {'text': 'Kewirausahaan'},
    {'text': 'Mobile Legends'},
    {'text': 'Wrap Humic'},
  ];

  // Daftar Modul Option
  final List<Map<String, String>> pilihanModul = [
    {'topText': 'CLO 1', 'bottomText': 'Flutter'},
    {'topText': 'CLO 2', 'bottomText': 'Dart'},
    {'topText': 'CLO 3', 'bottomText': 'Firebase'},
    {'topText': 'CLO 4', 'bottomText': 'State Management'},
  ];

  // Daftar Informasi Modul
  final List<Map<String, String>> latSoal = [
    {'title': 'Installasi Flutter', 'dateTime': '20 Maret 2024, 15.00-15.30'},
    {
      'title': 'Membuat Project Flutter',
      'dateTime': '21 Maret 2024, 10.30-11.30'
    },
    {
      'title': 'Push Rank Epic II - Mythic',
      'dateTime': '22 Maret 2024, 00.00-03.00'
    },
    {
      'title': 'Membuat Tampilan Sederhana',
      'dateTime': '23 Maret 2024, 08.00-09.30'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
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
                  //bagain course option atau pilihan mata kuliah
                  SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(courses.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CourseOption(text: courses[index]['text']!),
                        );
                      }),
                    ),
                  ),
                  //bagian modul option atau pilihan modul
                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(pilihanModul.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ModulOption(
                            topText: pilihanModul[index]['topText']!,
                            bottomText: pilihanModul[index]['bottomText']!,
                          ),
                        );
                      }),
                    ),
                  ),

                  //bagian latihan soal
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
                            // untuk button lainnya
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
                  //list view untuk latian soal
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(latSoal.length, (index) {
                      return LatihanSoal(
                        title: latSoal[index]['title']!,
                        dateTime: latSoal[index]['dateTime']!,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class buat profil
class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: AssetImage('assets/img/profil.png'),
    );
  }
}

//class buat box info dibawah profil
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

//class buat course
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

//class buat modul
class ModulOption extends StatelessWidget {
  final String topText;
  final String bottomText;

  ModulOption({required this.topText, required this.bottomText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => vid_page()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          width: 150.0,
          padding: EdgeInsets.all(10.0),
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
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  topText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                bottomText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class buat latian soal
class LatihanSoal extends StatelessWidget {
  final String title;
  final String dateTime;

  LatihanSoal({required this.title, required this.dateTime});

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
