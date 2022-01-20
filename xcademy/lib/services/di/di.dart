import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/network/dio_client.dart';
import 'package:xcademy/services/network/logger.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject() async {
    final shared = await SharedPreferences.getInstance();
    injector.registerSingleton<DataPrefs>(DataPrefs(shared));
    final _dio = await DioClient.setup(
      baseUrl: Configurations.base_api_url,
    );
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
    injector.registerSingleton<ApiClient>(
      ApiClient(
        _dio,
        baseUrl: Configurations.base_api_url,
      ),
    );
  }
}
