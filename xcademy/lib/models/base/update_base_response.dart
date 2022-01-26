import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';

part 'update_base_response.g.dart';

@JsonSerializable()
class UpdateBaseResponse extends BaseResponse {
  List<ResultModel>? data;
  UpdateBaseResponse();
  factory UpdateBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateBaseResponseFromJson(json);
}

@JsonSerializable()
class ResultModel {
  String? result;
  ResultModel();
  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}
