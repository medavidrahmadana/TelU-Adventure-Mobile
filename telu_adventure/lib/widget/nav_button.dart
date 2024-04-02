import 'package:flutter/material.dart';
import 'package:telu_adventure/page/course_page.dart';
import 'package:telu_adventure/page/forum_dashboard.dart';
import 'package:telu_adventure/page/home_page.dart';
import 'package:telu_adventure/page/lapor_page.dart';
import 'package:telu_adventure/page/map_page.dart';

class NavButton extends StatefulWidget {
  NavButton({Key? key}) : super(key: key);

  @override
  _NavButtonState createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    home_page(),
    map_page(),
    lapor_page(),
    forum_dashboard(),
    CoursePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.black54,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map),
                    label: 'Map',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment),
                    label: 'Lapor',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Forum',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Course',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
