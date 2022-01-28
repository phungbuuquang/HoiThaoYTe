import 'package:flutter/material.dart';
import 'package:xcademy/screens/detail_tutorial/list_subject_screen.dart';
import 'package:xcademy/widgets/my_tab_view.dart';

import 'overview_screen.dart';

class DetailSeminarScreen extends StatefulWidget {
  const DetailSeminarScreen({Key? key}) : super(key: key);

  @override
  _DetailSeminarScreenState createState() => _DetailSeminarScreenState();
}

class _DetailSeminarScreenState extends State<DetailSeminarScreen> {
  final List<String> menuList = [
    'Tổng quan',
    'Chuyên đề',
  ];
  List<Widget> _listViews = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _listViews = [
      OverviewScreen(),
      ListSubjectScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết hội thảo',
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyTabbar(
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: menuList
                  .map((e) => Tab(
                        icon: Text(e),
                      ))
                  .toList()),
        ),
      ),
      body: _listViews[_currentIndex],
    );
  }
}
