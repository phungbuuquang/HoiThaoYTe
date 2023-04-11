import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';

part 'province_response.g.dart';

@JsonSerializable()
class ProvinceResponse extends BaseResponse {
  List<ProvinceModel>? data;

  ProvinceResponse();
  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProvinceResponseFromJson(json);
}

@JsonSerializable()
class ProvinceModel {
  String? idTinhThanh;
  String? TenTinhThanh;
  ProvinceModel({
    this.idTinhThanh,
    this.TenTinhThanh,
  });
  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);
}
