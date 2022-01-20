import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitialState());

  login(
    String username,
    String password,
  ) async {
    emit(LoginLoadingState());
    final res = await injector.get<ApiClient>().login(username, password);
    print(res);
    if (res == null) {
      emit(LoginFailedState(ErrorConstant.default_error));
      return;
    }
    if (res.message != '') {
      emit(LoginFailedState(res.message!));
      return;
    }
    injector.get<DataPrefs>().saveUserId(res.data!.first.idHoiVien ?? '');
    injector.get<DataPrefs>().saveUserName(res.data!.first.HoTen ?? '');
    emit(LoginSuccessState(res.data!.first));
  }
}
