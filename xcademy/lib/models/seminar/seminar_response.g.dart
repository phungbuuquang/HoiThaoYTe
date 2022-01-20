// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seminar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeminarResponse _$SeminarResponseFromJson(Map<String, dynamic> json) =>
    SeminarResponse()
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => SeminarModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SeminarResponseToJson(SeminarResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

SeminarModel _$SeminarModelFromJson(Map<String, dynamic> json) => SeminarModel()
  ..idHoiThao = json['idHoiThao'] as String?
  ..idLoaiHoiThao = json['idLoaiHoiThao'] as String?
  ..TieuDe = json['TieuDe'] as String?
  ..AnhHoiThao = json['AnhHoiThao'] as String?
  ..AnhBienLai = json['AnhBienLai'] as String?
  ..isXacNhanBienLai = json['isXacNhanBienLai'] as String?
  ..idHoiVien = json['idHoiVien'] as String?;

Map<String, dynamic> _$SeminarModelToJson(SeminarModel instance) =>
    <String, dynamic>{
      'idHoiThao': instance.idHoiThao,
      'idLoaiHoiThao': instance.idLoaiHoiThao,
      'TieuDe': instance.TieuDe,
      'AnhHoiThao': instance.AnhHoiThao,
      'AnhBienLai': instance.AnhBienLai,
      'isXacNhanBienLai': instance.isXacNhanBienLai,
      'idHoiVien': instance.idHoiVien,
    };
