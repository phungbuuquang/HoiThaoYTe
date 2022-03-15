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
  ..AnhBia = json['AnhBia'] as String?
  ..AnhBienLai = json['AnhBienLai'] as String?
  ..isXacNhanBienLai = json['isXacNhanBienLai'] as String?
  ..idHoiVien = json['idHoiVien'] as String?
  ..LoaiHoiThao = json['LoaiHoiThao'] as String?
  ..DataChuyenDe = (json['DataChuyenDe'] as List<dynamic>?)
      ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..DiaDiem = json['DiaDiem'] as String?
  ..NgayDienRa = json['NgayDienRa'] as String?
  ..ThoiGianBatDau = json['ThoiGianBatDau'] as String?
  ..ThoiGianKetThuc = json['ThoiGianKetThuc'] as String?
  ..CoPhi = json['CoPhi'] as String?;

Map<String, dynamic> _$SeminarModelToJson(SeminarModel instance) =>
    <String, dynamic>{
      'idHoiThao': instance.idHoiThao,
      'idLoaiHoiThao': instance.idLoaiHoiThao,
      'TieuDe': instance.TieuDe,
      'AnhHoiThao': instance.AnhHoiThao,
      'AnhBia': instance.AnhBia,
      'AnhBienLai': instance.AnhBienLai,
      'isXacNhanBienLai': instance.isXacNhanBienLai,
      'idHoiVien': instance.idHoiVien,
      'LoaiHoiThao': instance.LoaiHoiThao,
      'DataChuyenDe': instance.DataChuyenDe,
      'DiaDiem': instance.DiaDiem,
      'NgayDienRa': instance.NgayDienRa,
      'ThoiGianBatDau': instance.ThoiGianBatDau,
      'ThoiGianKetThuc': instance.ThoiGianKetThuc,
      'CoPhi': instance.CoPhi,
    };
