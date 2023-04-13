part of 'login_bloc.dart';

// abstract class LoginState {}

// class LoginInitialState extends LoginState {}

// class LoginLoadingState extends LoginState {}

// class LoginFailedState extends LoginState {
//   String error;
//   LoginFailedState(this.error);
// }

// class LoginSuccessState extends LoginState {
//   UserModel user;
//   LoginSuccessState(this.user);
// }
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.error(String error) = _Error;
  const factory LoginState.success(UserModel user) = _Success;
}
