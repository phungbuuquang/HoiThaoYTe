import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/province/province_response.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/screens/signup/bloc/signup_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/widgets/my_button.dart';
import 'package:xcademy/widgets/my_image.dart';
import 'package:xcademy/widgets/my_text_formfield.dart';
import 'package:xcademy/widgets/my_textfield_dropdown.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc get _bloc => BlocProvider.of(context);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đăng ký'),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    ColorConstant.subPrimary,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: MyImage(
                          'logo_demo.png',
                          width: 120,
                          height: 120,
                          folder: AssetsFolder.images,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextFormField(
                          labelText: 'Họ tên (*)',
                          controller: _bloc.nameCtrler,
                          validator: (val) {
                            if (val == '') {
                              return 'Vui lòng nhập họ tên!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormField(
                          labelText: 'Điện thoại (*)',
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            )
                          ],
                          controller: _bloc.phoneCtrler,
                          validator: (val) {
                            if (val == '') {
                              return 'Vui lòng nhập số điện thoại!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormField(
                          labelText: 'Mật khẩu (*)',
                          isObscure: true,
                          controller: _bloc.passCtrler,
                          validator: (val) {
                            if (val == '') {
                              return 'Vui lòng nhập mật khẩu!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormField(
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: _bloc.emailCtrler,
                          validator: (val) {
                            if (val != '' && val!.isEmail) {
                              return 'Vui lòng nhập đúng định dạng email!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                            buildWhen: (previous, current) =>
                                current is SignupUpdatedFieldState,
                            builder: (_, state) {
                              return MyTextFieldDropdown(
                                labelText: 'Giới tính',
                                items: ['Nam', 'Nữ'],
                                value: _bloc.gender,
                                onChanged: (val) => _bloc.onChangedGender(val!),
                              );
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                          buildWhen: (previous, current) =>
                              current is SignupUpdatedFieldState,
                          builder: (_, state) => MyTextFieldDropdown(
                            items: DataPrefsConstant.provinces
                                .map((e) => e.TenTinhThanh ?? '')
                                .toList(),
                            value: _bloc.province.TenTinhThanh!,
                            onChanged: (val) => _bloc.onChangedProvince(val!),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignupBloc, SignupState>(
                            builder: (_, state) {
                          var isLoading = false;
                          if (state is SignupLoadingState) {
                            isLoading = true;
                          }
                          return MyButton(
                            isLoading: isLoading,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _bloc.register(context);
                            },
                            title: 'Đăng ký',
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
