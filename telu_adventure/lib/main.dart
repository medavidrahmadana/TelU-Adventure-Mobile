import 'package:flutter/material.dart';
import 'package:telu_adventure/page/course_page.dart';
import 'package:telu_adventure/page/course_vid_page.dart';
import 'package:telu_adventure/page/forum_dashboard.dart';
import 'package:telu_adventure/page/forum_jawab.dart';
import 'package:telu_adventure/page/forum_notifikasi.dart';
import 'package:telu_adventure/page/forum_pertanyaan.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'page/home_page.dart';
import 'page/landing_page.dart';
import 'page/register_page.dart';
import 'page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => forum_dashboard()),
      );
    });
    return const start();
  }
}
