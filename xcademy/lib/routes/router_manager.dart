import 'package:flutter/material.dart';
import 'package:xcademy/screens/detail_tutorial/detail_tutoral_screen.dart';
import 'package:xcademy/screens/lession/lession_screen.dart';
import 'package:xcademy/screens/list_notification.dart/list_notification_screen.dart';
import 'package:xcademy/screens/login/login.screen.dart';
import 'package:xcademy/screens/tabbar/base_tabbar_screen.dart';

class RouterManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouterName.base_tabbar:
        return MaterialPageRoute(builder: (_) => BaseTabbarScreen());
      case RouterName.detail_tutorial:
        return MaterialPageRoute(builder: (_) => DetailTuTorialScreen());
      case RouterName.lession:
        return MaterialPageRoute(builder: (_) => LessionScreen());
      case RouterName.list_notification:
        return MaterialPageRoute(builder: (_) => ListNotificationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class RouterName {
  static const String login = '/login';
  static const String base_tabbar = '/base_tabbar';
  static const String detail_tutorial = '/detail_tutorial';
  static const String lession = '/lession';
  static const String list_notification = '/list_notification';
}
