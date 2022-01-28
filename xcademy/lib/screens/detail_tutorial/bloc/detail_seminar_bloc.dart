import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/models/subject/subject_model.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'detail_seminar_state.dart';

class DetailSeminarBloc extends Cubit<DetailSeminarState> {
  DetailSeminarBloc(this.seminar) : super(DetailSeminarInitialState());

  SeminarModel seminar;

  getDetailSeminar() async {
    emit(DetailSeminarLoadingState());
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().getListSeminars(
          userId,
          seminar.idHoiThao ?? '',
        );

    emit(DetailSeminarGetSubjectsDoneState(
      res?.data?.first.DataChuyenDe ?? [],
    ));
  }

  updateStatusBill() async {
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().getListSeminars(
          userId,
          seminar.idHoiThao ?? '',
        );
    if (res != null && res.data != null) {
      seminar = res.data!.first;
      emit(DetailSeminarUpdatePaidState());
    }
  }
}
