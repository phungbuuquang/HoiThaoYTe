import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';

part 'district_response.g.dart';

@JsonSerializable()
class DistrictResponse extends BaseResponse {
  List<DistrictModel>? data;
  DistrictResponse();
  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$DistrictResponseFromJson(json);
}

@JsonSerializable()
class DistrictModel {
  String? idTinhThanh;
  String? idQuanHuyen;
  String? TenQuanHuyen;
  DistrictModel({
    this.idQuanHuyen,
    this.TenQuanHuyen,
  });
  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);
}
