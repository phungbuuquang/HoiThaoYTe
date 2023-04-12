import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/common_utils.dart';
part 'signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  SignupBloc() : super(SignupInitialState());
  final nameCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final passCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  var gender = 'Nam';
  var province = DataPrefsConstant.provinces.first;

  register(BuildContext context) async {
    emit(SignupLoadingState());
    final res = await injector.get<ApiClient>().registerUser(
          '',
          nameCtrler.text,
          gender == 'Nam' ? '0' : '1',
          phoneCtrler.text,
          emailCtrler.text,
          passCtrler.text,
          province.idTinhThanh == '999' ? '' : province.idTinhThanh!,
        );
    emit(SignupDoneState());
    if (res != null &&
        res.data != null &&
        res.data?.first.result == 'success') {
      CommonUtils.showOkDialog(
        context,
        msg: 'Bạn đã đăng ký thành công, vui lòng đăng nhập!',
        okAction: () => Navigator.of(context).pop(),
      );
      return;
    }
    CommonUtils.showOkDialog(context,
        msg: 'Số điện thoại của bạn đã tồn tại, vui lòng nhập số khác!');
  }

  onChangedGender(String val) {
    gender = val;
    emit(SignupUpdatedFieldState());
  }

  onChangedProvince(String val) {
    if (val != province.TenTinhThanh) {
      province =
          DataPrefsConstant.provinces.where((e) => e.TenTinhThanh == val).first;
    }
    emit(SignupUpdatedFieldState());
  }
}
