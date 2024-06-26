import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/home_controller.dart';
import 'package:telu_adventure/controllers/userdetail_controller.dart';
import 'package:telu_adventure/model/achievement_model.dart';

class achievement_page extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<achievement_page> {
  final usercon _usercon = usercon();
  final String UID = FirebaseAuth.instance.currentUser!.uid;
  String? gedungk;
  String? gedungnk;
  String? kantin;
  int jumlahquest = 0;
  int achieve = 0;

  @override
  void initState() {
    super.initState();
    _fetchGedungData();
    _calculateQuestCount();
  }

  Future<void> _fetchGedungData() async {
    Map<String, String?> gedungData = await _usercon.getGedung(UID);
    setState(() {
      gedungk = gedungData['gedungk'];
      gedungnk = gedungData['gedungnk'];
      kantin = gedungData['kantin'];
    });
  }

  Future<void> _calculateQuestCount() async {
    final questStream = _usercon.getQuestbyID(UID);
    questStream.listen((snapshot) {
      setState(() {
        jumlahquest = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = HomeController();
    int trueCount = 0;
    int falseCount = 0;
    int allCount = 0;
    int achieve = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Achievement Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: homeController.getAchievement(),
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
                id: doc['id'] ?? '',
                namaAchievement: doc['namaAchievement'] ?? '',
                gambarAchievement: doc['gambarAchievement'] ?? '',
                syarat: doc['syarat'] ?? '',
              );

              String syarat = achievement.syarat;
              if ((syarat == gedungk && achievement.id == '3') ||
                  (syarat == gedungnk && achievement.id == '2') ||
                  (syarat == kantin && achievement.id == '4')) {
                // Show achievement image
                trueCount++;
                String botText2 = (syarat == gedungk)
                    ? '($gedungk/$syarat)'
                    : (syarat == gedungnk)
                        ? '($gedungnk/$syarat)'
                        : '($kantin/$syarat)';
                return ModulAch(
                  botText1: doc['namaAchievement'],
                  botText2: botText2,
                  imagePath: doc['gambarAchievement'],
                  status: true,
                );
              } else if (gedungk == '3' &&
                  gedungnk == '5' &&
                  kantin == '7' &&
                  achievement.id == '1') {
                achieve++;
                achieve++;
                achieve++;
                trueCount++;
                String box = "($achieve / $syarat)";
                return ModulAch(
                  botText1: doc['namaAchievement'],
                  botText2: box,
                  imagePath: doc['gambarAchievement'],
                  status: true,
                );
              } else if (
                  achievement.id == '6') {
                trueCount++;
                String tugas = "($syarat)";
                return ModulAch(
                  botText1: doc['namaAchievement'],
                  botText2: tugas,
                  imagePath: doc['gambarAchievement'],
                  status: true,
                );
                }
                else if (int.parse(syarat) <= jumlahquest &&
                  achievement.id == '5') {
                trueCount++;
                String task = "($jumlahquest/$syarat)";
                return ModulAch(
                  botText1: doc['namaAchievement'],
                  botText2: task,
                  imagePath: doc['gambarAchievement'],
                  status: true,
                );
                }
                else if ((syarat != gedungk && achievement.id == '3') ||
                    (syarat != gedungnk && achievement.id == '2') ||
                    (syarat != kantin && achievement.id == '4')) {
                  falseCount++;

                  // Show achievement image
                  String botText2 = (syarat == gedungk)
                      ? '($gedungk/$syarat)'
                      : (syarat == gedungnk)
                          ? '($gedungnk/$syarat)'
                          : '($kantin/$syarat)';
                  return ModulAch(
                    botText1: doc['namaAchievement'],
                    botText2: botText2,
                    imagePath: doc['gambarAchievement'],
                    status: false,
                  );
                } else if ((gedungk != '3' &&
                  gedungnk == '5' &&
                  kantin == '7' &&
                  achievement.id == '1') || (gedungk == '3' &&
                  gedungnk != '5' &&
                  kantin == '7' &&
                  achievement.id == '1') || (gedungk == '3' &&
                  gedungnk == '5' &&
                  kantin != '7' &&
                  achievement.id == '1')) {
                  achieve++;
                  achieve++;
                  falseCount++;
                  String box = "($achieve / $syarat)";
                  return ModulAch(
                    botText1: doc['namaAchievement'],
                    botText2: box,
                    imagePath: doc['gambarAchievement'],
                    status: false,
                  );
                }
                else if ((gedungk != '3' &&
                  gedungnk != '5' &&
                  kantin == '7' &&
                  achievement.id == '1') || (gedungk == '3' &&
                  gedungnk != '5' &&
                  kantin != '7' &&
                  achievement.id == '1') || (gedungk != '3' &&
                  gedungnk == '5' &&
                  kantin != '7' &&
                  achievement.id == '1')) {
                  achieve++;
                  falseCount++;
                  String box = "($achieve / $syarat)";
                  return ModulAch(
                    botText1: doc['namaAchievement'],
                    botText2: box,
                    imagePath: doc['gambarAchievement'],
                    status: false,
                  );
                } else if (int.parse(syarat) > jumlahquest &&
                    achievement.id == '5') {
                  falseCount++;

                  String task = "($jumlahquest/$syarat)";
                  return ModulAch(
                    botText1: doc['namaAchievement'],
                    botText2: task,
                    imagePath: doc['gambarAchievement'],
                    status: false,
                  );
              } else {
                falseCount++;
                return ModulAch(
                  botText1: doc['namaAchievement'],
                  botText2: "()",
                  imagePath: doc['gambarAchievement'],
                  status: false,
                );
              }

            }).toList();
            allCount = trueCount + falseCount;
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
                            value: allCount == 0
                                ? 0
                                : (100 / allCount) *
                                    trueCount, // Prevent division by zero
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
  final bool status;

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
        color: status ? Colors.white : Colors.grey.withOpacity(0.7),
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
            color: status ? null : Colors.black,
          ),
          SizedBox(height: 10.0),
          Text(
            botText1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: status ? Colors.black : Colors.white,
            ),
          ),
          Text(
            botText2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: status ? Colors.black : Colors.white,
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
