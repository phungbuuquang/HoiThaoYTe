part of 'subject_bloc.dart';

abstract class SubjectState {}

class SubjectInitialState extends SubjectState {}

class SubjectGetNumPagePdfState extends SubjectState {}

class SubjectGetUrlPdfState extends SubjectState {
  String url;
  SubjectGetUrlPdfState(this.url);
}

class SubjectGetNamePdfState extends SubjectState {
  String name;
  SubjectGetNamePdfState(this.name);
}
