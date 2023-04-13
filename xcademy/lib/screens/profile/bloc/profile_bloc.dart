import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/district/district_response.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/common_utils.dart';
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
  final fbCtrler = TextEditingController();
  final zaloCtrler = TextEditingController();
  final genders = ['Nam', 'Nữ'];
  var gender = 'Nam';
  List<DistrictModel> listDistricts = [
    DistrictModel(
      idQuanHuyen: '',
      TenQuanHuyen: 'Chọn quận huyện',
    )
  ];

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
    fbCtrler.text = user!.facebook ?? '';
    zaloCtrler.text = user!.zalo ?? '';
    if (DataPrefsConstant.provinces.isNotEmpty) {
      for (var i = 0; i < DataPrefsConstant.provinces.length; i++) {
        if (DataPrefsConstant.provinces[i].idTinhThanh ==
            (user?.TinhThanhCongTac ?? '')) {
          user?.tenTinhThanhCongTac =
              DataPrefsConstant.provinces[i].TenTinhThanh;
          province = DataPrefsConstant.provinces[i];
          break;
        }
      }
      if (user?.TinhThanhCongTac != '999') {
        await getDistricts();
      }
    }
    emit(ProfileLoadDoneState(user!));
  }

  getDistricts() async {
    final res = await injector
        .get<ApiClient>()
        .getDistrict(province?.idTinhThanh ?? '');
    if (res != null && res.data != null) {
      listDistricts = [
        DistrictModel(
          idQuanHuyen: '',
          TenQuanHuyen: 'Chọn quận huyện',
        )
      ];
      listDistricts.addAll(res.data!);
      if (listDistricts.isNotEmpty) {
        for (var i = 0; i < listDistricts.length; i++) {
          if (listDistricts[i].idQuanHuyen == (user?.QuanHuyen ?? '')) {
            user?.tenQuanHuyen = listDistricts[i].TenQuanHuyen;

            break;
          }
        }
      }
    }
  }

  resetData() {
    birthday = null;
    imageTNCK = null;
  }

  onChangedProvince(String val) {
    if (val != province?.TenTinhThanh) {
      province =
          DataPrefsConstant.provinces.where((e) => e.TenTinhThanh == val).first;
      user?.TinhThanhCongTac = province?.TenTinhThanh;
      user?.tenTinhThanhCongTac = province?.TenTinhThanh;
      if (province?.idTinhThanh != '999') {
        getDistricts();
      }
    }
  }

  onChangedDistrict(String val) {
    if (val != user?.QuanHuyen) {
      final district = listDistricts.where((e) => e.TenQuanHuyen == val).first;
      user?.QuanHuyen = district.TenQuanHuyen;
      user?.tenQuanHuyen = district.TenQuanHuyen;
    }
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
      listProvinces = res.data!;
      DataPrefsConstant.provinces = [
        ProvinceModel(
          idTinhThanh: '999',
          TenTinhThanh: 'Chọn tỉnh thành',
        )
      ];
      getInfoUser();
      DataPrefsConstant.provinces.addAll(res.data!);
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

  updateProfile(BuildContext context) async {
    CommonUtils.showLoading();

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
    if (imageAvt != null) {
      form = FormData.fromMap({
        'AnhCaNhan': MultipartFile.fromFileSync(
          imageAvt?.path ?? '',
          contentType:
              MediaType.parse(lookupMimeType(imageAvt?.path ?? '') ?? ''),
        ),
      });
    }
    final queries = {
      "idHoiVien": DataPrefsConstant.userId,
      "HoTen": nameCtrler.text,
      "GioiTinh": gender == 'Nam' ? '0' : '1',
      "NamSinh": '',
      'SoDienThoai': phoneCtrler.text,
      'Email': emailCtrler.text,
      'DiaChi': addressCtrler.text,
      'ThongTinThem': '',
      'TinhThanhCongTac': user?.TinhThanhCongTac,
      'QuanHuyen': '',
      'MatKhau': user?.MatKhau,
      'facebook': fbCtrler.text,
      'zalo': zaloCtrler.text,
    };
    final res = await injector.get<ApiClient>().updateInfoUser(
          queries,
          form,
        );
    print(res);
    CommonUtils.hideLoading();
    if (res != null && res.data?.first != null) {
      if (res.data?.first.result?.replaceAll(' ', '') == 'success') {
        getInfoUser();
        CommonUtils.showOkDialog(context,
            msg: 'Cập nhật thông tin thành công!');
        // emit(ProfileUpdateDoneState(null));
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
