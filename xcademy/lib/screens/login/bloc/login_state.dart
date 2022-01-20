part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailedState extends LoginState {
  String error;
  LoginFailedState(this.error);
}

class LoginSuccessState extends LoginState {
  UserModel user;
  LoginSuccessState(this.user);
}
