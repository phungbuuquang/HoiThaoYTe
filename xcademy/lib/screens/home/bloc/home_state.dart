part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeGetSeminarsDoneState extends HomeState {
  List<SeminarModel> listSeminars;
  HomeGetSeminarsDoneState(this.listSeminars);
}

class HomeGetNameUserState extends HomeState {
  String? name;
  String? avatar;
  HomeGetNameUserState({
    this.name,
    this.avatar,
  });
}
