import 'package:flutter/material.dart';

import 'Modal_map.dart';

class mapcard extends StatelessWidget {
  const mapcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/DSC_0216.JPG'),
                fit: BoxFit.fitWidth,
              ),
            ),
            width: 400,
            height: 100,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Mengatur jumlah kolom menjadi 2
              children: [
                ModulAch(
                    botText1: 'Gedung Bangkit',
                    imagePath: 'assets/img/Rektorat.png',
                    botText2: '104 meter'),
                ModulAch(
                    botText1: 'FTE',
                    imagePath: 'assets/img/FTE.png',
                    botText2: '222 meter'),
                ModulAch(
                    botText1: 'FEB',
                    imagePath: 'assets/img/FEB.png',
                    botText2: '333 meter'),
                ModulAch(
                    botText1: 'FIK',
                    imagePath: 'assets/img/FIK.png',
                    botText2: '200 meter'),
                ModulAch(
                    botText1: 'FRI',
                    imagePath: 'assets/img/FRI.png',
                    botText2: '525 meter'),
                ModulAch(
                    botText1: 'FIF',
                    imagePath: 'assets/img/FIF.png',
                    botText2: '200 meter'),
                ModulAch(
                    botText1: 'TULT',
                    imagePath: 'assets/img/TULT.png',
                    botText2: '622 meter'),
                ModulAch(
                    botText1: 'GKU',
                    imagePath: 'assets/img/GKU.png',
                    botText2: '455 meter'),
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Modal_map(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 10),
            child: Text(
              botText1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 3),
            child: Text(
              botText2,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
