import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/services/api_request/api_client.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitialState());

  getListSeminar() async {
    emit(HomeLoadingState());
    final userId = injector.get<DataPrefs>().getUserId();
    final res = await injector.get<ApiClient>().getListSeminars(userId, '');
    if (res == null) {
      emit(HomeGetSeminarsDoneState([]));
      return;
    }
    emit(HomeGetSeminarsDoneState(res.data ?? []));
  }

  getNameUser() {
    final name = injector.get<DataPrefs>().getUserName();
    final avatar = injector.get<DataPrefs>().getAvatar();
    emit(
      HomeGetNameUserState(
        name: name,
        avatar: avatar,
      ),
    );
  }

  getProvices() async {
    final res = await injector.get<ApiClient>().getProvinces();
    if (res != null && res.data != null) {
      DataPrefsConstant.provinces = [
        ProvinceModel(
          idTinhThanh: '999',
          TenTinhThanh: 'Chọn tỉnh thành',
        )
      ];

      DataPrefsConstant.provinces.addAll(res.data!);
    }
  }
}
