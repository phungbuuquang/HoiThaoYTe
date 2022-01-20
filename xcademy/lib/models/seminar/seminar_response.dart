import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';

part 'seminar_response.g.dart';

@JsonSerializable()
class SeminarResponse extends BaseResponse {
  List<SeminarModel>? data;
  SeminarResponse();
  factory SeminarResponse.fromJson(Map<String, dynamic> json) =>
      _$SeminarResponseFromJson(json);
}

@JsonSerializable()
class SeminarModel {
  String? idHoiThao;
  String? idLoaiHoiThao;
  String? TieuDe;
  String? AnhHoiThao;
  String? AnhBienLai;
  String? isXacNhanBienLai;
  String? idHoiVien;
  SeminarModel();
  factory SeminarModel.fromJson(Map<String, dynamic> json) =>
      _$SeminarModelFromJson(json);
}
