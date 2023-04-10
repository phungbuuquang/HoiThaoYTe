import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';
import 'package:xcademy/models/user/user_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  UserModel? data;
  LoginResponse();
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
