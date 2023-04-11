import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
part 'signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  SignupBloc() : super(SignupInitialState());
  final nameCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final passCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final gender = 'Nam';
  final province = DataPrefsConstant.provinces.first;
}
