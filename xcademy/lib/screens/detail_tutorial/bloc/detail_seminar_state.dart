part of 'detail_seminar_bloc.dart';

abstract class DetailSeminarState {}

class DetailSeminarInitialState extends DetailSeminarState {}

class DetailSeminarLoadingState extends DetailSeminarState {}

class DetailSeminarGetSubjectsDoneState extends DetailSeminarState {
  List<SubjectModel> listSubjects = [];
  DetailSeminarGetSubjectsDoneState(this.listSubjects);
}
