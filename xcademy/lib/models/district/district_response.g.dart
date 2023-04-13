// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictResponse _$DistrictResponseFromJson(Map<String, dynamic> json) =>
    DistrictResponse()
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => DistrictModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DistrictResponseToJson(DistrictResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      idQuanHuyen: json['idQuanHuyen'] as String?,
      TenQuanHuyen: json['TenQuanHuyen'] as String?,
    )..idTinhThanh = json['idTinhThanh'] as String?;

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'idTinhThanh': instance.idTinhThanh,
      'idQuanHuyen': instance.idQuanHuyen,
      'TenQuanHuyen': instance.TenQuanHuyen,
    };
