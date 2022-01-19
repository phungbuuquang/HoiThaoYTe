import 'package:flutter/material.dart';
import 'package:xcademy/screens/detail_tutorial/list_subject_screen.dart';
import 'package:xcademy/widgets/my_tab_view.dart';

class DetailTuTorialScreen extends StatefulWidget {
  const DetailTuTorialScreen({Key? key}) : super(key: key);

  @override
  _DetailTuTorialScreenState createState() => _DetailTuTorialScreenState();
}

class _DetailTuTorialScreenState extends State<DetailTuTorialScreen> {
  final List<String> menuList = [
    'Môn học',
    'Thông tin',
    'Tiến độ',
  ];
  List<Widget> _listViews = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _listViews = [
      ListSubjectScreen(),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết khoá học',
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
