import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:xcademy/models/login/login_response.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

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
