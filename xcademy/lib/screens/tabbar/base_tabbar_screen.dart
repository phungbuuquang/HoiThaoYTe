import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/screens/home/bloc/home_bloc.dart';
import 'package:xcademy/screens/home/home_screen.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';

import 'package:xcademy/screens/profile/profile_screen.dart';
import 'package:xcademy/widgets/my_image.dart';

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
      BlocProvider(
        create: (_) => HomeBloc(),
        child: HomeScreen(),
      ),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          currentIndex: _currentIndex,
          onTap: (val) {
            setState(() {
              _currentIndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: MyImage(
                'ic_home.svg',
                color: ColorConstant.grayEAB,
              ),
              label: 'Trang chủ',
              activeIcon: MyImage(
                'ic_home.svg',
                color: Theme.of(context).primaryColor,
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.school,
            //   ),
            //   label: 'Khoá học',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.leaderboard,
            //   ),
            //   label: 'Hội thảo',
            // ),
            BottomNavigationBarItem(
              icon: MyImage(
                'ic_person.svg',
                color: ColorConstant.grayEAB,
              ),
              label: 'Cá nhân',
              activeIcon: MyImage(
                'ic_person.svg',
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        body: IndexedStack(
          children: _listScreens,
          index: _currentIndex,
        ),
      ),
    );
  }
}
