import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/utils/date_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc get _bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _bloc.getInfoUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Thông tin cá nhân'),
        actions: [
          IconButton(
            onPressed: () {
              if (_bloc.user == null) {
                return;
              }
              Navigator.of(context).pushNamed(RouterName.edit_profile);
            },
            icon: Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (prev, curr) {
              return curr is ProfileLoadDoneState;
            },
            builder: (context, state) {
              if (state is ProfileLoadDoneState) {
                return _buildListInfoView(state.user);
              }
              return _buildListInfoView(null);
            },
          ),
        ),
      ),
    );
  }

  Column _buildListInfoView(UserModel? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoLabelView('Họ tên', user?.HoTen ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView('Số điện thoại',
            user?.SoDienThoai == 'null' ? '' : user?.SoDienThoai ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
            'Email', user?.Email == 'null' ? '' : user?.Email ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
            'Địa chỉ', user?.DiaChi == 'null' ? '' : user?.DiaChi ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
            'Giới tính', user?.GioiTinh == 'null' ? '' : user?.GioiTinh ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
          'Ngày sinh',
          user?.NgaySinh == 'null'
              ? ''
              : DateUtil.strDatetoStr(
                  user?.NgaySinh ?? '',
                  format: 'dd/MM/yyyy',
                ),
        ),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
          'Nơi sinh',
          user?.NoiSinh == 'null' ? '' : user?.NoiSinh ?? '',
        ),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView('Chuyên ngành',
            user?.ChuyenNganh == 'null' ? '' : user?.ChuyenNganh ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView('Nơi làm việc',
            user?.NoiLamViec == 'null' ? '' : user?.NoiLamViec ?? ''),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
          'Chức danh',
          user?.ChucDanh == 'null' ? '' : user?.ChucDanh ?? '',
        ),
        SizedBox(
          height: 24,
        ),
        _buildInfoLabelView(
            'Tỉnh thành công tác', user?.tenTinhThanhCongTac ?? ''),
        SizedBox(
          height: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ảnh bằng cấp',
              style: TextStyle(
                fontSize: 16,
                color: ColorConstant.subtitleColor,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            user == null || user.AnhBangCap == '' || user.AnhBangCap == 'null'
                ? Text('Chưa cập nhật')
                : FadeInImage.assetNetwork(
                    placeholder: ImageConstant.placeholder,
                    image: user.AnhBangCap ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        _buildLogoutBtn()
      ],
    );
  }

  logout() async {
    await injector.get<DataPrefs>().clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouterName.login,
      (route) => false,
    );
  }

  Widget _buildLogoutBtn() {
    return Center(
      child: InkWell(
        onTap: logout,
        child: Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              'Đăng xuất',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildInfoLabelView(
    String title,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: ColorConstant.subtitleColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                content,
                textAlign: TextAlign.right,
                maxLines: null,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   height: 1,
        //   color: ColorConstant.dividerColor,
        // )
      ],
    );
  }
}
