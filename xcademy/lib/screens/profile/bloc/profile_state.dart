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
