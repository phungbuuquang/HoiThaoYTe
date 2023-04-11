// ignore_for_file: non_constant_identifier_names

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
  String? AnhCaNhan;
  String? AnhTheHoiVien;
  String? AnhChungChiHanhNghe;
  String? AnhVanBangCaoNhat;
  String? facebook;
  String? zalo;
  @JsonKey(ignore: true)
  String? tenTinhThanhCongTac;

  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
