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
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Standing on top of mountain peak success achieved generated by ai.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          width: 400,
          height: 100,
          child: Stack( // Tambahkan Stack di sini
            children: [
              Positioned(
                bottom: 50.0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: GameXPBar(
                    maxWidth: 375.0,
                    value: 37.5, // Misalnya, XP saat ini adalah 70%
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
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
            ],
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

class GameXPBar extends StatefulWidget {
  final double maxWidth;
  final double value;

  GameXPBar({required this.maxWidth, required this.value});

  @override
  _GameXPBarState createState() => _GameXPBarState();
}

class _GameXPBarState extends State<GameXPBar> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.maxWidth,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Container(
          width: _animation.value / 100 * widget.maxWidth,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ],
    );
  }
}