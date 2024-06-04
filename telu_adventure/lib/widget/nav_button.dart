import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:telu_adventure/page/forum_dashboard.dart';
import 'package:telu_adventure/page/home_page.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/page/map_page.dart';
import '../page/scan_page.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key});

  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  int _currentIndex = 0;
  late CameraDescription _camera;
  late PageStorageBucket _bucket;
  late Widget _currentScreen;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _initCamera();
    _bucket = PageStorageBucket();
    _currentScreen = const home_page(); // Assuming HomePage is your default screen
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _camera = cameras.first;
    setState(() {
      _children = [
        const home_page(),
        const map_page(),
        // MapCard(),
        // course_page(),
        ScanPage(camera: _camera),
        forum_dashboard(),
        const lapor_page(),
      ];
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _currentScreen = _children[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0), // Sesuaikan dengan tingkat kebulatan yang Anda inginkan
        ),
        child: const Icon(Icons.qr_code_scanner_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScanPage(camera: _camera)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _currentScreen = const home_page();
                          _currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: _currentIndex == 0 ? Colors.red : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _currentIndex == 0 ? Colors.red : Colors.grey,
                            ),
                          )
                        ],
                      )),
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _currentScreen = const map_page();
                          _currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: _currentIndex == 1 ? Colors.red : Colors.grey,
                          ),
                          Text(
                            'Map',
                            style: TextStyle(
                              color: _currentIndex == 1 ? Colors.red : Colors.grey,
                            ),
                          )
                        ],
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          _currentScreen = forum_dashboard();
                          _currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: _currentIndex == 2 ? Colors.red : Colors.grey,
                          ),
                          Text(
                            'Forum',
                            style: TextStyle(
                              color: _currentIndex == 2 ? Colors.red : Colors.grey,
                            ),
                          )
                        ],
                      )),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentScreen = const lapor_page();
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          color: _currentIndex == 3 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Lapor',
                          style: TextStyle(
                            color: _currentIndex == 3 ? Colors.red : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
