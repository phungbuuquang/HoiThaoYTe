import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:xcademy/configurations/configurations.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'subject_state.dart';

class SubjectBloc extends Cubit<SubjectState> {
  SubjectBloc(this.subject) : super(SubjectInitialState());

  final SubjectModel subject;
  int totalPage = 0;
  int currentPage = 0;
  List<String> listPdf = [];
  int currentPdf = 0;
  int seconds = 0;

  String getUrl() {
    print(Uri.encodeFull(subject.LinkVideo ?? ''));
    final url = Uri.encodeFull(subject.LinkVideo ?? '');

    return url;
  }

  getTotalPdf() {
    List<String> arr = [];
    if (subject.LinkPDF != '' && subject.LinkPDF != null) {
      arr = subject.LinkPDF?.split('|~~|') ?? [];
    }
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
    final url =
        listPdf[currentPdf].replaceAll('.pdf', '_${currentPage + 1}.png');
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

  Future<void> setTimeCurrentVideo() async {
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().setTimeCurrentVideo(
          userId,
          subject.idChuyenDe ?? '',
          seconds.toString(),
        );
    print(res);
  }

  listenTimeCurrent(VideoPlayerController controller) async {
    final s = await controller.position;
    print(s?.inSeconds.toString());
    seconds = s?.inSeconds ?? 0;
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

  getTimeCurrentVideo() async {
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().getTimeCurrentVideo(
          userId,
          subject.idChuyenDe ?? '',
        );
    if (res != null && res.data != null) {
      var val = int.tryParse(res.data!.SoGiay ?? '');
      if (val != null) {
        seconds = val;
      }
    }
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
