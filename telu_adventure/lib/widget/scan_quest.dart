import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../controllers/scan_controller.dart';
import '../model/scan_model.dart';

class ScanQuest extends StatelessWidget {
  const ScanQuest({
    super.key,
    required this.imageUrl,
    required this.question,
    required this.controller,
    required this.code,
  });

  final String imageUrl;
  final String question;
  final TextEditingController controller;
  final String? code;

  @override
  Widget build(BuildContext context) {
    void validateInput() async {
      if (controller.text.isEmpty) {
        const snackBar = SnackBar(
          content: Text('Jawaban harus diisi!'),
          backgroundColor: Color(0xFFBB371A),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Future.delayed(Duration.zero, () {
          scan_model scan = scan_model(
            uid: FirebaseAuth.instance.currentUser!.uid,
            isi: code ?? "Unknown",
            jawab: controller.text,
          );
          ScanCon.addToFirestore(context, scan);
        });
        Navigator.of(context).pop();
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.47,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 7,
                      color: const Color(0xFFBB371A),
                    ),
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: IntrinsicHeight(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pertanyaan',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 221, 221, 221),
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          question,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Jawaban...',
                    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFBB371A), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    validateInput();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 60),
                    backgroundColor: const Color(0xFFBB371A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Jawab',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      color: Color(0xFFBB371A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
