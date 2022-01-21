import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';
import 'package:xcademy/models/subject/subject_model.dart';

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
  List<SubjectModel>? DataChuyenDe;
  SeminarModel();
  factory SeminarModel.fromJson(Map<String, dynamic> json) =>
      _$SeminarModelFromJson(json);
}
