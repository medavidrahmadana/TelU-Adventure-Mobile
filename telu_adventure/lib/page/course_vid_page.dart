import 'package:flutter/material.dart';
import 'package:telu_adventure/page/profile_page.dart';

class vid_page extends StatelessWidget {
  vid_page({Key? key}) : super(key: key);

  // Daftar data video
  final List<Map<String, String>> videos = [
    {
      'title': 'Installasi Flutter',
      'uploaded': '1 hari yang lalu',
      'thumbnail': 'assets/img/ThumbnailFlutter.jpg',
    },
    {
      'title': 'Create Project Flutter',
      'uploaded': '5 jam yang lalu',
      'thumbnail': 'assets/img/ThumbnailFlutter.jpg',
    },
    {
      'title': 'Push Rank',
      'uploaded': '1 minggu yang lalu',
      'thumbnail': 'assets/img/ThumbnailFlutter.jpg',
    },
    {
      'title': 'List View Builder',
      'uploaded': '2 hari yang lalu',
      'thumbnail': 'assets/img/ThumbnailFlutter.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 50),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFEED1D1),
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                      'Fadhil Jaidi',
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
                      'Flutter',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA11E22),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: List.generate(videos.length, (index) {
                      return Column(
                        children: [
                          SizedBox(height: 10.0),
                          Center(
                            child: VideoButton(
                              thumbnail: videos[index]['thumbnail']!,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              videos[index]['title']!,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Center(
                            child: Text(
                              'Uploaded - ${videos[index]['uploaded']}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
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

class VideoButton extends StatelessWidget {
  final String thumbnail;

  const VideoButton({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Fungsi untuk menangani ketika tombol video ditekan
          print('Tombol video ditekan');
        },
        child: Container(
          width: 350,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(thumbnail),
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(
            Icons.play_arrow,
            size: 100.0,
            color: const Color.fromARGB(255, 255, 17, 0),
          ),
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman profil saat gambar profil ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage('assets/img/Fadhil.png'),
      ),
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
                '4',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFA11E22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Video Tersedia',
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
