import 'package:flutter/material.dart';
import 'package:xcademy/screens/home/home_screen.dart';

import 'package:xcademy/screens/profile/profile_screen.dart';

class BaseTabbarScreen extends StatefulWidget {
  const BaseTabbarScreen({Key? key}) : super(key: key);

  @override
  _BaseTabbarScreenState createState() => _BaseTabbarScreenState();
}

class _BaseTabbarScreenState extends State<BaseTabbarScreen> {
  int _currentIndex = 0;
  List<Widget> _listScreens = [];
  @override
  void initState() {
    super.initState();
    _listScreens = [
      HomeScreen(),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.purple,
      ),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
            ),
            label: 'Khoá học',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.leaderboard,
            ),
            label: 'Hội thảo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Cá nhân',
          ),
        ],
      ),
      body: IndexedStack(
        children: _listScreens,
        index: _currentIndex,
      ),
    );
  }
}
