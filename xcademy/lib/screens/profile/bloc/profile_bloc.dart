import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileInitialState());
  UserModel? user;
  getInfoUser() async {
    emit(ProfileLoadingState());
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().getInfoUser(userId);
    print(res?.data);
    if (res == null || res.data == null) {
      emit(ProfileLoadFailedState(ErrorConstant.default_error));
      return;
    }
    user = res.data;
    emit(ProfileLoadDoneState(res.data!));
  }
}
