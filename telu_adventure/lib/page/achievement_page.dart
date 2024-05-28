import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/home_controller.dart';
import 'package:telu_adventure/model/achievement_model.dart';

class achievement_page extends StatelessWidget {
  String UID = FirebaseAuth.instance.currentUser!.uid;

  achievement_page({Key? key}) : super(key: key);
  int trueCount = 0;
  int falseCount = 0;
  int allCount = 0;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = HomeController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: homeController.getAchievement(UID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No achievements found'));
          } else {
            List<ModulAch> achievements = snapshot.data!.docs.map((doc) {
              // Log data for debugging
              print('Achievement doc: ${doc.data()}');

              Achievement achievement = Achievement(
                UID: doc['UID'] ?? '',
                namaAchievement: doc['namaAchievement'] ?? '',
                gambarAchievement: doc['gambarAchievement'] ?? '',
                status: doc['status'] ?? 'false',
              );
              
                String status = doc['status'];
                if (status == 'true') {
                  trueCount++;
                } else {
                  falseCount++;
                }
              allCount = trueCount + falseCount;
              return ModulAch(
                botText1: achievement.namaAchievement,
                imagePath: achievement.gambarAchievement,
                status: achievement.status,
                botText2: '', // This can be customized as needed
              );
            }).toList();

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/img/Standing on top of mountain peak success achieved generated by ai.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  width: 400,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 50.0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: GameXPBar(
                              maxWidth: 375.0,
                              value:
                                  100/allCount*trueCount,  // Example XP value, this should be dynamic
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
                                '$trueCount/$allCount',
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
                    crossAxisCount: 2, // Set the number of columns to 2
                    children: achievements,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ModulAch extends StatelessWidget {
  final String botText1;
  final String botText2;
  final String imagePath;
  final String status;

  ModulAch({
    required this.botText1,
    required this.botText2,
    required this.imagePath,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: status == 'false' ? Colors.grey.withOpacity(0.7) : Colors.white,
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
            color: status == 'false' ? Colors.black : null,
          ),
          SizedBox(height: 10.0),
          Text(
            botText1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: status == 'false' ? Colors.white : Colors.black,
            ),
          ),
          Text(
            botText2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: status == 'false' ? Colors.white : Colors.black,
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
