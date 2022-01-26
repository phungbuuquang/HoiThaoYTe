import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileBloc get _bloc => BlocProvider.of(context);
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _placeBirthController = TextEditingController();
  final _majorController = TextEditingController();
  final _officeController = TextEditingController();
  final _titleController = TextEditingController();
  final _nameProviceController = TextEditingController();
  final _usernameController = TextEditingController();

  XFile? _imagePicked;

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    _nameController.text = _bloc.user?.HoTen ?? '';
    _phoneController.text = _bloc.user?.SoDienThoai ?? '';
    _emailController.text = _bloc.user?.Email ?? '';
    _addressController.text = _bloc.user?.DiaChi ?? '';
    _birthdayController.text = _bloc.user?.NgaySinh ?? '';
    _placeBirthController.text = _bloc.user?.NoiSinh ?? '';
    _majorController.text = _bloc.user?.ChuyenNganh ?? '';
    _officeController.text = _bloc.user?.NoiLamViec ?? '';
    _titleController.text = _bloc.user?.ChucDanh ?? '';
    _nameProviceController.text = _bloc.user?.tenTinhThanhCongTac ?? '';
    _usernameController.text = _bloc.user?.TenDangNhap ?? '';
  }

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    print(image);
    setState(() {
      _imagePicked = image;
    });
  }

  updateProfile() {
    _bloc.updateProfile(fullName: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chỉnh sửa thông tin',
          ),
          actions: [
            IconButton(
              onPressed: updateProfile,
              icon: Text(
                'Lưu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Column(
              children: [
                _buildInfoView(
                  'Họ tên (*)',
                  controller: _nameController,
                ),
                _buildInfoView(
                  'Mã hội viên (*)',
                  controller: _usernameController,
                ),
                _buildInfoView(
                  'Số điện thoại',
                  controller: _phoneController,
                ),
                _buildInfoView(
                  'Email',
                  controller: _emailController,
                ),
                _buildInfoView(
                  'Địa chỉ',
                  controller: _addressController,
                ),
                _buildInfoView(
                  'Ngày sinh',
                  controller: _birthdayController,
                ),
                _buildInfoView(
                  'Nơi sinh',
                  controller: _placeBirthController,
                ),
                _buildInfoView(
                  'Chuyên ngành',
                  controller: _majorController,
                ),
                _buildInfoView(
                  'Nơi làm việc',
                  controller: _officeController,
                ),
                _buildInfoView(
                  'Chức danh',
                  controller: _titleController,
                ),
                _buildInfoView(
                  'Tên tỉnh thành công tác',
                  controller: _nameProviceController,
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ảnh bằng cấp',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Text(
                            'Chọn ảnh',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _imagePicked != null
                        ? Image.file(
                            File(_imagePicked!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          )
                        : FadeInImage.assetNetwork(
                            placeholder: ImageConstant.placeholder,
                            image: _bloc.user?.AnhBangCap ?? '',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoView(
    String title, {
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildTextFormField(
            controller: controller,
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField({
    TextEditingController? controller,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      controller: controller,
      decoration: InputDecoration(),
    );
  }
}
