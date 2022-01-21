import 'package:json_annotation/json_annotation.dart';
part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  String? idHoiThao;
  String? idChuyenDe;
  String? TieuDe;
  String? LinkVideo;
  String? TimeVideoCurrent;
  String? LinkPDF;
  String? SoImageConvertToPDF;
  String? ThoiLuongVideo;
  SubjectModel();
  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}
