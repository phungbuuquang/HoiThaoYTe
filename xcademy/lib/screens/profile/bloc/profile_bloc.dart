import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileInitialState());
  UserModel? user;
  List<ProvinceModel> listProvinces = [];
  ProvinceModel? province;
  DateTime? birthday;
  File? imageTNCK;
  File? imageAvt;
  File? imageTHV;
  File? imageCCHN;
  File? imageVBCN;
  final nameCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final genderCtrler = TextEditingController();
  final addressCtrler = TextEditingController();
  final cityCtrler = TextEditingController();
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
    nameCtrler.text = user!.HoTen ?? '';
    phoneCtrler.text = user!.SoDienThoai ?? '';
    emailCtrler.text = user!.Email ?? '';
    genderCtrler.text = user!.GioiTinh ?? '';
    addressCtrler.text = user!.DiaChi ?? '';
    cityCtrler.text = user!.TinhThanhCongTac ?? '';
    await getProvices();
    emit(ProfileLoadDoneState(user!));
  }

  resetData() {
    birthday = null;
    imageTNCK = null;
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
    imageAvt = File(image.path);
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

  updateProfile() async {
    emit(ProfileLoadingState());
    String urls = '';
    final userId = injector.get<DataPrefs>().getUserId();
    if (nameCtrler.text != user?.HoTen) {
      urls += 'HoTen=${nameCtrler.text}&';
    }
    if (phoneCtrler.text != user?.SoDienThoai) {
      urls += 'SoDienThoai=${phoneCtrler.text}&';
    }
    if (emailCtrler.text != user?.Email) {
      urls += 'Email=${emailCtrler.text}&';
    }
    if (addressCtrler.text != user?.DiaChi) {
      urls += 'DiaChi=${addressCtrler.text}&';
    }
    // if (birthday != null) {
    //   urls +=
    //       'NgaySinh=${DateUtil.dateToStr(birthday!, format: 'MM/dd/yyyy')}&';
    // }
    // if (placeBirth != user?.NoiSinh && placeBirth != null) {
    //   urls += 'NoiSinh=$birthday&';
    // }
    // if (major != user?.ChuyenNganh && major != null) {
    //   urls += 'ChuyenNganh=$major&';
    // }
    // if (office != user?.NoiLamViec && office != null) {
    //   urls += 'NoiLamViec=$office&';
    // }
    // if (title != user?.ChucDanh && title != null) {
    //   urls += 'ChucDanh=$title&';
    // }
    // if (imageTNCK != null) {
    //   urls += 'AnhBangCap=${_getFileName()}&';
    // }
    // if (province != null && province?.idTinhThanh != user?.TinhThanhCongTac) {
    //   urls += 'TinhThanhCongTac=${province?.idTinhThanh}&';
    // }
    FormData? form;
    // if (imageAvt != null) {
    //   form = FormData.fromMap({
    //     'fileimg': MultipartFile.fromFileSync(
    //       imageAvt?.path ?? '',
    //       contentType:
    //           MediaType.parse(lookupMimeType(imageAvt?.path ?? '') ?? ''),
    //     ),
    //   });
    // }

    final res = await injector.get<ApiClient>().updateInfoUser(
          userId,
          urls,
          form,
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
