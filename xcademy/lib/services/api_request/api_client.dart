import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:xcademy/models/base/update_base_response.dart';
import 'package:xcademy/models/login/login_response.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/models/time_current/time_current_response.dart';
import 'package:xcademy/models/user/user_response.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('${Apis.update_image_bill}?idHoiVien={userId}&idHoiThao={idSeminar}')
  @MultiPart()
  Future<UpdateBaseResponse?> updateImageBill(
    @Path("userId") String userId,
    @Path("idSeminar") String idSeminar,
    @Body() FormData formData,
  );

  @POST(
      '${Apis.set_time_current_video}?idHoiVien={userId}&idChuyenDe={idSubject}&SoGiay={seconds}')
  Future<UpdateBaseResponse?> setTimeCurrentVideo(
    @Path("userId") String userId,
    @Path("idSubject") String idSubject,
    @Path("seconds") String seconds,
  );
  @GET(
      '${Apis.get_time_current_video}?idHoiVien={userId}&idChuyenDe={idSubject}')
  Future<TimeCurrentResponse?> getTimeCurrentVideo(
    @Path("userId") String userId,
    @Path("idSubject") String idSubject,
  );
  @POST('${Apis.update_info_user}?idHoiVien={userId}{urls}')
  @MultiPart()
  Future<UpdateBaseResponse?> updateInfoUser(
    @Path("userId") String userId,
    @Path("urls") String urls,
    @Body() FormData? formData,
  );
  @POST(Apis.register)
  Future<UpdateBaseResponse?> registerUser(
    @Query('MaHoiVien') String idUser,
    @Query('HoTen') String fullName,
    @Query('GioiTinh') String gender,
    @Query('SoDienThoai') String phone,
    @Query('Email') String email,
    @Query('MatKhau') String password,
    @Query('TinhThanhCongTac') String province,
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
