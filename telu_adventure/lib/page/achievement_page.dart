import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telu_adventure/controllers/home_controller.dart';
import 'package:telu_adventure/model/achievement_model.dart';

class achievement_page extends StatefulWidget {
  const achievement_page({Key? key}) : super(key: key);

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<achievement_page> {
  late Future<List<Achievement>> _achievementFuture;
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    // Mendapatkan UID pengguna yang login
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;

    // Memanggil fungsi untuk mengambil data achievement
    if (uid != null) {
      _achievementFuture = _homeController.getAchievement(uid);
    } else {
      // Tangani kasus di mana UID tidak ditemukan
      _achievementFuture = Future.error('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievement Page'),
      ),
      body: FutureBuilder<List<Achievement>>(
        future: _achievementFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.map((achievement) {
                return ModulAch(
                  botText1: achievement.namaAchievement,
                  imagePath: achievement.gambarAchievement,
                  botText2: achievement.status,
                  status: achievement.status,
                );
              }).toList(),
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
          Image.network(
            imagePath,
            width: 100,
            height: 100,
            color: status == 'false' ? Colors.grey : null, // Efek hitam putih jika status false
            colorBlendMode: status == 'false' ? BlendMode.saturation : null,
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
