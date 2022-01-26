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
    await getProvices();
    emit(ProfileLoadDoneState(user!));
  }

  getProvices() async {
    final res = await injector.get<ApiClient>().getProvinces();
    if (res != null && res.data != null) {
      final provinces = res.data!;
      for (var i = 0; i < provinces.length; i++) {
        if (provinces[i].idTinhThanh == (user?.TinhThanhCongTac ?? '')) {
          user?.tenTinhThanhCongTac = provinces[i].TenTinhThanh;
          return;
        }
      }
    }
  }

  updateProfile({
    String? fullName,
  }) async {
    String urls = '';
    final userId = injector.get<DataPrefs>().getUserId();
    if (fullName != user?.HoTen) {
      urls += 'HoTen=${fullName}&';
    }
    final res = await injector.get<ApiClient>().updateInfoUser(userId, urls);
    print(res);
  }
}
