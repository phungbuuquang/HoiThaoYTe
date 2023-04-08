import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/user/user_model.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/utils/date_utils.dart';
import 'package:xcademy/widgets/my_button.dart';
import 'package:xcademy/widgets/my_image.dart';
import 'package:xcademy/widgets/my_text_formfield.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
        actions: injector.get<DataPrefs>().getUserId() == ''
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      if (_bloc.user == null) {
                        return;
                      }
                      _bloc.updateProfile();
                    },
                    child: Center(
                      child: Text(
                        'Lưu',
                        style: AppTextStyle.medium16Black
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
      ),
      body: injector.get<DataPrefs>().getUserId() == ''
          ? Center(
              child: MyButton(
                title: 'Đăng nhập',
                width: 200,
                onTap: () => Navigator.of(context).pushNamed(RouterName.login),
              ),
            )
          : SingleChildScrollView(
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
    );
  }

  Widget _buildListInfoView(UserModel? user) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstant.grayEAB.withOpacity(0.24),
              ),
            ),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: MyImage(
                        user?.AnhCaNhan ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: MyImage(
                      'ic_add_photo.svg',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MyTextFormField(
            labelText: 'Họ tên',
            controller: _bloc.nameCtrler,
          ),
          SizedBox(height: 10),
          MyTextFormField(
            labelText: 'Số điện thoại',
            controller: _bloc.phoneCtrler,
          ),
          SizedBox(height: 10),
          MyTextFormField(
            labelText: 'Email',
            controller: _bloc.emailCtrler,
          ),
          SizedBox(height: 10),
          MyTextFormField(
            labelText: 'Giới tính',
            controller: _bloc.genderCtrler,
          ),
          SizedBox(height: 10),
          MyTextFormField(
            labelText: 'Địa chỉ',
            controller: _bloc.addressCtrler,
          ),
          SizedBox(height: 10),
          MyTextFormField(
            labelText: 'Tỉnh thành',
            controller: _bloc.cityCtrler,
          ),
          SizedBox(
            height: 24,
          ),
          _buildLogoutBtn()
        ],
      ),
    );
  }

  Column _buildInfoImgView(
    UserModel? user, {
    String? title,
    String? imgUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 16,
            color: ColorConstant.subtitleColor,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        user == null || imgUrl == '' || imgUrl == 'null'
            ? Text('Chưa cập nhật')
            : FadeInImage.assetNetwork(
                placeholder: ImageConstant.placeholder,
                image: imgUrl ?? '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,
              )
      ],
    );
  }

  logout() async {
    await injector.get<DataPrefs>().clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouterName.base_tabbar,
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
