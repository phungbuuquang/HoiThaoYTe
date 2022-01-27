import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/date_utils.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileInitialState());
  UserModel? user;
  List<ProvinceModel> listProvinces = [];
  ProvinceModel? province;
  DateTime? birthday;
  File? imageSelected;
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

  resetData() {
    birthday = null;
    imageSelected = null;
  }

  selectDate(DateTime date) {
    birthday = date;
    emit(
      ProfileSelectDateState(
        DateUtil.dateToStr(date),
      ),
    );
  }

  selectImage(XFile image) {
    imageSelected = File(image.path);
    emit(
      ProfileSelectImageState(),
    );
  }

  getProvices() async {
    final res = await injector.get<ApiClient>().getProvinces();
    if (res != null && res.data != null) {
      final provinces = res.data!;
      listProvinces = res.data!;
      for (var i = 0; i < provinces.length; i++) {
        if (provinces[i].idTinhThanh == (user?.TinhThanhCongTac ?? '')) {
          user?.tenTinhThanhCongTac = provinces[i].TenTinhThanh;
          province = provinces[i];
          return;
        }
      }
    }
  }

  selectProvince(String name) {
    for (var i = 0; i < listProvinces.length; i++) {
      if (listProvinces[i].TenTinhThanh == name) {
        province = listProvinces[i];
        break;
      }
    }
    emit(ProfileSelectProvinceState());
  }

  updateProfile({
    String? fullName,
    String? phone,
    String? email,
    String? address,
    String? placeBirth,
    String? major,
    String? office,
    String? title,
  }) async {
    emit(ProfileLoadingState());
    String urls = '';
    final userId = injector.get<DataPrefs>().getUserId();
    if (fullName != user?.HoTen && fullName != null) {
      urls += 'HoTen=$fullName&';
    }
    if (phone != user?.SoDienThoai && phone != null) {
      urls += 'SoDienThoai=$phone&';
    }
    if (email != user?.Email && email != null) {
      urls += 'Email=$email&';
    }
    if (address != user?.DiaChi && address != null) {
      urls += 'DiaChi=$address&';
    }
    if (birthday != null) {
      urls +=
          'NgaySinh=${DateUtil.dateToStr(birthday!, format: 'MM/dd/yyyy')}&';
    }
    if (placeBirth != user?.NoiSinh && placeBirth != null) {
      urls += 'NoiSinh=$birthday&';
    }
    if (major != user?.ChuyenNganh && major != null) {
      urls += 'ChuyenNganh=$major&';
    }
    if (office != user?.NoiLamViec && office != null) {
      urls += 'NoiLamViec=$office&';
    }
    if (title != user?.ChucDanh && title != null) {
      urls += 'ChucDanh=$title&';
    }
    if (imageSelected != null) {
      urls += 'AnhBangCap=${_getFileName()}.png&';
    }
    if (province != null && province?.idTinhThanh != user?.TinhThanhCongTac) {
      urls += 'TinhThanhCongTac=${province?.idTinhThanh}&';
    }
    final res = await injector.get<ApiClient>().updateInfoUser(
          userId,
          urls,
          imageSelected,
        );
    print(res);
    if (res != null && res.data?.first != null) {
      if (res.data?.first.result?.replaceAll(' ', '') == 'success') {
        getInfoUser();
        emit(ProfileUpdateDoneState(null));
        return;
      }
    }
    emit(ProfileUpdateDoneState(ErrorConstant.default_error));
  }

  String _getFileName() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final userId = injector.get<DataPrefs>().getUserId();
    return userId + now.toString();
  }
}
