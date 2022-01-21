// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel()
  ..idHoiThao = json['idHoiThao'] as String?
  ..idChuyenDe = json['idChuyenDe'] as String?
  ..TieuDe = json['TieuDe'] as String?
  ..LinkVideo = json['LinkVideo'] as String?
  ..TimeVideoCurrent = json['TimeVideoCurrent'] as String?
  ..LinkPDF = json['LinkPDF'] as String?
  ..SoImageConvertToPDF = json['SoImageConvertToPDF'] as String?
  ..ThoiLuongVideo = json['ThoiLuongVideo'] as String?;

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'idHoiThao': instance.idHoiThao,
      'idChuyenDe': instance.idChuyenDe,
      'TieuDe': instance.TieuDe,
      'LinkVideo': instance.LinkVideo,
      'TimeVideoCurrent': instance.TimeVideoCurrent,
      'LinkPDF': instance.LinkPDF,
      'SoImageConvertToPDF': instance.SoImageConvertToPDF,
      'ThoiLuongVideo': instance.ThoiLuongVideo,
    };
