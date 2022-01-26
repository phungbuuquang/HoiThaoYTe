import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/subject/subject_model.dart';

part 'subject_state.dart';

class SubjectBloc extends Cubit<SubjectState> {
  SubjectBloc(this.subject) : super(SubjectInitialState());

  final SubjectModel subject;
  int totalPage = 0;
  int currentPage = 0;
  List<String> listPdf = [];
  int currentPdf = 0;

  String getUrl() {
    print(Uri.encodeFull(subject.LinkVideo ?? ''));
    final url =
        Configurations.base_url + Uri.encodeFull(subject.LinkVideo ?? '');

    return url;
  }

  getTotalPdf() {
    final arr = subject.LinkPDF?.split('|~~|') ?? [];
    print(arr);
    listPdf = arr;
    _getTotalPagePdf();
    emit(SubjectGetNumPagePdfState());
    emit(
      SubjectGetUrlPdfState(
        _getUrlPdf(),
      ),
    );
    emit(
      SubjectGetNamePdfState(
        _getNamePdf(),
      ),
    );
  }

  String _getUrlPdf() {
    final url = (Configurations.base_url + listPdf[currentPdf])
        .replaceAll('.pdf', '_${currentPage + 1}.png');
    return url;
  }

  prevPage() {
    if (currentPage > 0) {
      currentPage -= 1;
      emit(SubjectGetNumPagePdfState());
      emit(
        SubjectGetUrlPdfState(
          _getUrlPdf(),
        ),
      );
    }
  }

  nextPage() {
    if (currentPage < (totalPage - 1)) {
      currentPage += 1;
      emit(SubjectGetNumPagePdfState());
      emit(
        SubjectGetUrlPdfState(
          _getUrlPdf(),
        ),
      );
    }
  }

  List<String> getListNamePdf() {
    List<String> list = [];
    listPdf.forEach((e) {
      list.add(e.split('/').last);
    });
    return list;
  }

  onChangePdf(String name) {
    if (name == _getNamePdf()) {
      return;
    }
    for (var i = 0; i < listPdf.length; i++) {
      if (listPdf[i].contains(name)) {
        currentPdf = i;
        break;
      }
    }
    currentPage = 0;
    _getTotalPagePdf();
    emit(SubjectGetNumPagePdfState());
    emit(
      SubjectGetUrlPdfState(
        _getUrlPdf(),
      ),
    );
    emit(
      SubjectGetNamePdfState(
        _getNamePdf(),
      ),
    );
  }

  _getTotalPagePdf() {
    final _arrNumImages = subject.SoImageConvertToPDF?.split('|~~|') ?? [];
    totalPage = int.parse(_arrNumImages[currentPdf]);
  }

  String _getNamePdf() {
    final name = listPdf[currentPdf].split('/').last;
    return name;
  }
}
