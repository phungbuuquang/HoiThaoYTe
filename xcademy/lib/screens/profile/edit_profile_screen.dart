import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileBloc get _bloc => BlocProvider.of(context);
  final _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.text = _bloc.user?.HoTen ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa thông tin',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            children: [
              _buildInfoView('Họ tên'),
              _buildInfoView('Số điện thoại'),
              _buildInfoView('Email'),
              _buildInfoView('Địa chỉ'),
              _buildInfoView('Ngày sinh'),
              _buildInfoView('Nơi sinh'),
              _buildInfoView('Chuyên ngành'),
              _buildInfoView('Nơi làm việc'),
              _buildInfoView('Chức danh'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoView(String title) {
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
          _buildTextFormField(),
        ],
      ),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(),
    );
  }
}
