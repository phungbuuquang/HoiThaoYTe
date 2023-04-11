import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    configLoading();
    initializeDateFormatting();
    await DependencyInjection.inject();

    runApp(
      BlocProvider(
        create: (_) => ProfileBloc(),
        child: MyApp(),
      ),
    );
  }, (e, stack) {
    // LogUtils.d(stack);
  });
}

class MyApp extends StatelessWidget {
  String get initialRoute {
    if (injector.get<DataPrefs>().getUserId() != '') {
      return RouterName.base_tabbar;
    } else {
      return RouterName.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: ColorConstant.primaryColor,
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: 12,
            color: Color(0xff646464),
            fontFamily: 'Inter',
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: ColorConstant.primaryColor,
          elevation: 0.8,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ), //here you can give the text color
        ),
      ),
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouterName.base_tabbar,
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorConstant.primaryColor
    ..textColor = Colors.yellow
    ..userInteractions = false
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..dismissOnTap = false;
}
