import 'package:flutter/material.dart';
import 'package:telu_adventure/page/login_page.dart';

class achievement_page extends StatelessWidget {
  const achievement_page({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Page'),
      ),
      body: Column(
        children: [
          Positioned(
                  bottom: 20.0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    value: 0.375, // Ganti nilai ini sesuai dengan kemajuan progres
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '3/8',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Mengatur jumlah kolom menjadi 2
              children: [
               ModulAch(
                  botText1: 'Still Free', 
                  imagePath: 'assets/img/scholar.png',
                  botText2: 'Beasiswa (1/1)'
                ),

                ModulAch(
                  botText1: 'Task Master', 
                  imagePath: 'assets/img/task_achievement.png',
                  botText2: 'Tugas (52/50)'
                ),

                ModulAch(
                  botText1: 'Food Place', 
                  imagePath: 'assets/img/restaurant.png',
                  botText2: 'Kantin (7/7)'
                ),
                ModulAch(
                  botText1: 'all master', 
                  imagePath: 'assets/img/Achievement-hitam.png',
                  botText2: 'Achievement (3/7)'
                ),
                 ModulAch(
                  botText1: 'Adventurer', 
                  imagePath: 'assets/img/Adventure-hitam.png',
                  botText2: 'Achievement Explore (1/3)'
                ),

                ModulAch(
                  botText1: 'Collage Explorer', 
                  imagePath: 'assets/img/University-hitam.png',
                  botText2: 'G. Perkuliahan(4/7)'
                ),

                ModulAch(
                  botText1: 'all place', 
                  imagePath: 'assets/img/gedung-hitam.png',
                  botText2: 'G. Non Perkuliahan (4/10)'
                ),
                ModulAch(
                  botText1: 'Never sleep?', 
                  imagePath: 'assets/img/Attendance-hitam.png',
                  botText2: 'Presensi (20/50)'
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModulAch extends StatelessWidget {
  final String botText1;
  final String botText2;
  final String imagePath;

  ModulAch({
    required this.botText1,
    required this.botText2,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10.0),
          Text(
            botText1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            botText2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

