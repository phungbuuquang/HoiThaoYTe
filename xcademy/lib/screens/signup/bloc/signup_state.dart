part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupDoneState extends SignupState {}

class SignupUpdatedFieldState extends SignupState {}
