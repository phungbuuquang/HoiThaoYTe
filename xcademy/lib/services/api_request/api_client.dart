import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:xcademy/models/base/update_base_response.dart';
import 'package:xcademy/models/login/login_response.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/models/user/user_response.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('${Apis.info_user}?idHoiVien={userId}&{urls}')
  Future<UpdateBaseResponse?> updateInfoUser(
    @Path("userId") String userId,
    @Path("urls") String urls,
  );

  @GET('${Apis.provinces}')
  Future<ProvinceResponse?> getProvinces();

  @GET('${Apis.info_user}?idHoiVien={userId}')
  Future<UserResponse?> getInfoUser(
    @Path('userId') String userId,
  );

  @GET('${Apis.login}?taikhoan={username}&matkhau={password}')
  Future<LoginResponse?> login(
    @Path('username') String username,
    @Path('password') String password,
  );
  @GET('${Apis.list_seminars}?idHoiVien={userId}&idHoiThao={seminarId}')
  Future<SeminarResponse?> getListSeminars(
    @Path('userId') String userId,
    @Path('seminarId') String seminarId,
  );
}
