import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/screens/detail_tutorial/bloc/detail_seminar_bloc.dart';
import 'package:xcademy/screens/detail_tutorial/detail_seminar_screen.dart';
import 'package:xcademy/screens/lession/bloc/subject_bloc.dart';
import 'package:xcademy/screens/lession/subject_screen.dart';
import 'package:xcademy/screens/list_notification.dart/list_notification_screen.dart';
import 'package:xcademy/screens/login/bloc/login_bloc.dart';
import 'package:xcademy/screens/login/login.screen.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/screens/profile/edit_profile_screen.dart';
import 'package:xcademy/screens/tabbar/base_tabbar_screen.dart';

class RouterManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginBloc(),
            child: LoginScreen(),
          ),
        );
      case RouterName.base_tabbar:
        return MaterialPageRoute(builder: (_) => BaseTabbarScreen());
      case RouterName.detail_tutorial:
        final SeminarModel item = settings.arguments as SeminarModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => DetailSeminarBloc(item),
            child: DetailSeminarScreen(),
          ),
        );
      case RouterName.lession:
        final SubjectModel subject = settings.arguments as SubjectModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SubjectBloc(subject),
            child: SubjectScreen(),
          ),
        );
      case RouterName.edit_profile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
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
  static const String edit_profile = '/edit_profile';
}
