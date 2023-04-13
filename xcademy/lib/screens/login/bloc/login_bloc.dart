import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginState.initial());

  login(
    String username,
    String password,
  ) async {
    emit(LoginState.loading());
    try {
      final res = await injector.get<ApiClient>().login(username, password);
      print(res);
      if (res == null) {
        emit(LoginState.error(ErrorConstant.default_error));
        return;
      }
      if (res.message != '') {
        emit(LoginState.error(res.message!));
        return;
      }
      injector.get<DataPrefs>().saveUserId(res.data!.idHoiVien ?? '');
      injector.get<DataPrefs>().saveUserName(res.data!.HoTen ?? '');
      injector.get<DataPrefs>().saveAvatar(res.data!.AnhCaNhan ?? '');
      emit(LoginState.success(res.data!));
    } catch (error) {
      print(error);
    }
  }
}
