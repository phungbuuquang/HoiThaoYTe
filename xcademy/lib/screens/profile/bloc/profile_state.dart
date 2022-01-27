part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadFailedState extends ProfileState {
  String error;
  ProfileLoadFailedState(this.error);
}

class ProfileLoadDoneState extends ProfileState {
  UserModel user;
  ProfileLoadDoneState(this.user);
}

// class ProfileGetNameProvinceState extends ProfileState {
//   String name;
//   ProfileGetNameProvinceState(this.name);
// }

class ProfileSelectProvinceState extends ProfileState {}

class ProfileSelectDateState extends ProfileState {
  String date;
  ProfileSelectDateState(this.date);
}

class ProfileUpdateDoneState extends ProfileState {
  String? error;
  ProfileUpdateDoneState(this.error);
}

class ProfileSelectImageState extends ProfileState {
  ProfileSelectImageState();
}
