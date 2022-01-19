import 'package:flutter/material.dart';

class MyTabbar extends StatefulWidget {
  final Function(int)? onTap;
  final List<Widget> tabs;

  MyTabbar({
    this.onTap,
    required this.tabs,
  });
  @override
  _MyTabbarState createState() => _MyTabbarState();
}

class _MyTabbarState extends State<MyTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3.0,
              color: Colors.white,
            ),
          ),
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //For Selected tab
          unselectedLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          onTap: (index) {
            if (widget.onTap != null) {
              widget.onTap!(index);
            }
          },
          tabs: widget.tabs,
        ),
      ),
    );
  }
}
