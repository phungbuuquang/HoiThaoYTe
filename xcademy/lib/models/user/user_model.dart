import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? idHoiVien;
  String? HoTen;
  String? GioiTinh;
  String? SoDienThoai;
  String? Email;
  String? DiaChi;
  String? ChucDanh;
  String? ChuyenNganh;
  String? NoiLamViec;
  String? TinhThanhCongTac;
  String? AnhBangCap;
  String? TenDangNhap;
  String? NoiSinh;
  String? NgaySinh;
  @JsonKey(ignore: true)
  String? tenTinhThanhCongTac;

  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
