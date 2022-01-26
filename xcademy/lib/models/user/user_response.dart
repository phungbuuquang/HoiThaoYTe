import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';
import 'package:xcademy/models/user/user_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends BaseResponse {
  UserModel? data;
  UserResponse();
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
