// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_current_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeCurrentResponse _$TimeCurrentResponseFromJson(Map<String, dynamic> json) =>
    TimeCurrentResponse()
      ..message = json['message'] as String?
      ..data = json['data'] == null
          ? null
          : TimeCurrentModel.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$TimeCurrentResponseToJson(
        TimeCurrentResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

TimeCurrentModel _$TimeCurrentModelFromJson(Map<String, dynamic> json) =>
    TimeCurrentModel()
      ..idHoiVien = json['idHoiVien'] as String?
      ..idChuyenDe = json['idChuyenDe'] as String?
      ..SoGiay = json['SoGiay'] as String?;

Map<String, dynamic> _$TimeCurrentModelToJson(TimeCurrentModel instance) =>
    <String, dynamic>{
      'idHoiVien': instance.idHoiVien,
      'idChuyenDe': instance.idChuyenDe,
      'SoGiay': instance.SoGiay,
    };
