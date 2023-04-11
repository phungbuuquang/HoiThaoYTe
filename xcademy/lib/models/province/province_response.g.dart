// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceResponse _$ProvinceResponseFromJson(Map<String, dynamic> json) =>
    ProvinceResponse()
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => ProvinceModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ProvinceResponseToJson(ProvinceResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      idTinhThanh: json['idTinhThanh'] as String?,
      TenTinhThanh: json['TenTinhThanh'] as String?,
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'idTinhThanh': instance.idTinhThanh,
      'TenTinhThanh': instance.TenTinhThanh,
    };
