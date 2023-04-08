import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/screens/detail_tutorial/bloc/detail_seminar_bloc.dart';
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
    'Chuyên đề',
    'Tổng quan',
  ];
  List<Widget> _listViews = [];
  int _currentIndex = 0;
  DetailSeminarBloc get _bloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();

    _listViews = [
      ListSubjectScreen(),
      OverviewScreen(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.getDetailSeminar();
    });
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
