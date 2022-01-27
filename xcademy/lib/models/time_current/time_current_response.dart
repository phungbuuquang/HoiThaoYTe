import 'package:json_annotation/json_annotation.dart';
import 'package:xcademy/models/base/base_response.dart';

part 'time_current_response.g.dart';

@JsonSerializable()
class TimeCurrentResponse extends BaseResponse {
  TimeCurrentModel? data;
  TimeCurrentResponse();
  factory TimeCurrentResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeCurrentResponseFromJson(json);
}

@JsonSerializable()
class TimeCurrentModel {
  String? idHoiVien;
  String? idChuyenDe;
  String? SoGiay;
  TimeCurrentModel();
  factory TimeCurrentModel.fromJson(Map<String, dynamic> json) =>
      _$TimeCurrentModelFromJson(json);
}
