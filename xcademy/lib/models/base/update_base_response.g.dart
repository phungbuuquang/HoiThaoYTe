// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBaseResponse _$UpdateBaseResponseFromJson(Map<String, dynamic> json) =>
    UpdateBaseResponse()
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UpdateBaseResponseToJson(UpdateBaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) =>
    ResultModel()..result = json['result'] as String?;

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
