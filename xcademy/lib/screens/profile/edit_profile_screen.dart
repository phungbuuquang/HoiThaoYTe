import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/utils/date_utils.dart';
import 'package:xcademy/widgets/options_dialog.dart';

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

  @override
  void initState() {
    super.initState();
    _bloc.resetData();
    setData();
  }

  setData() {
    _nameController.text = _bloc.user?.HoTen ?? '';
    _phoneController.text = _bloc.user?.SoDienThoai ?? '';
    _emailController.text = _bloc.user?.Email ?? '';
    _addressController.text = _bloc.user?.DiaChi ?? '';
    _birthdayController.text = DateUtil.strDatetoStr(
      _bloc.user?.NgaySinh ?? '',
      format: 'dd/MM/yyyy',
    );
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
    if (image != null) {
      _bloc.selectImage(image);
    }
  }

  updateProfile() {
    _bloc.updateProfile(
      fullName: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      address: _addressController.text,
      placeBirth: _placeBirthController.text,
      major: _majorController.text,
      office: _officeController.text,
      title: _titleController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) {
        return curr is ProfileUpdateDoneState;
      },
      listener: (_, state) {
        if (state is ProfileUpdateDoneState) {
          if (state.error != null) {
            CommonUtils.showOkDialog(context, msg: state.error!);
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      child: GestureDetector(
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
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (_, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
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
                              'Số điện thoại',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                            _buildInfoView(
                              'Email',
                              controller: _emailController,
                            ),
                            _buildInfoView(
                              'Địa chỉ',
                              controller: _addressController,
                            ),
                            _buildBirthDayView(context),
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
                            _buildProvinceView(),
                            SizedBox(
                              height: 16,
                            ),
                            _buildImageCert(),
                          ],
                        ),
                      ),
                    ),
                    state is ProfileLoadingState
                        ? Center(child: CommonUtils.circleIndicator(context))
                        : SizedBox.shrink(),
                  ],
                );
              },
            )),
      ),
    );
  }

  GestureDetector _buildBirthDayView(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _selectDate(context);
      },
      child: IgnorePointer(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (_, state) {
            if (state is ProfileSelectDateState) {
              _birthdayController.text = state.date;
            }
            return _buildInfoView(
              'Ngày sinh',
              controller: _birthdayController,
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      _bloc.selectDate(picked);
    }
  }

  Widget _buildProvinceView() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (prev, curr) {
        return curr is ProfileSelectProvinceState;
      },
      builder: (_, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => OptionsDialog(
                title: 'Chọn tỉnh thành',
                datas: _bloc.listProvinces
                    .map((e) => e.TenTinhThanh ?? '')
                    .toList(),
                onSelect: (name) => _bloc.selectProvince(name),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tỉnh thành công tác ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _bloc.province?.TenTinhThanh ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCert() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (prev, curr) {
        return curr is ProfileSelectImageState;
      },
      builder: (_, state) {
        return Column(
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
            _bloc.imageSelected != null
                ? Image.file(
                    _bloc.imageSelected!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
                : _bloc.user?.AnhBangCap == ''
                    ? Text('Chưa cập nhật')
                    : FadeInImage.assetNetwork(
                        placeholder: ImageConstant.placeholder,
                        image: _bloc.user?.AnhBangCap ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
          ],
        );
      },
    );
  }

  Widget _buildInfoView(
    String title, {
    TextEditingController? controller,
    TextInputType? keyboardType,
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
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField({
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
