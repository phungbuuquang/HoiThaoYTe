import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/login/bloc/login_bloc.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/widgets/my_button.dart';
import 'package:xcademy/widgets/my_image.dart';
import 'package:xcademy/widgets/my_text_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  LoginBloc get _bloc => BlocProvider.of(context);
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  loginTapped() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _bloc.login(
      _usernameTextController.text,
      _passwordTextController.text,
    );
  }

  @override
  void initState() {
    _usernameTextController.text = '0968990921';
    _passwordTextController.text = '1232';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is LoginFailedState) {
          CommonUtils.showOkDialog(context, msg: state.error);
        }
        if (state is LoginSuccessState) {
          Navigator.of(context).pushReplacementNamed(RouterName.base_tabbar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đăng nhập'),
          elevation: 0,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        labelText: 'Tên đăng nhập',
                        controller: _usernameTextController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Vui lòng nhập tên đăng nhập!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      MyTextFormField(
                        labelText: 'Mật khẩu',
                        controller: _passwordTextController,
                        isObscure: _isObscure,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Vui lòng nhập mật khẩu!';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff646464),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      _buildLoginBtn(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản ?',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstant.text,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(RouterName.signup),
                            child: Text(
                              'Đăng ký mới',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.subPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) {
        bool isLoading = false;
        if (state is LoginLoadingState) {
          isLoading = true;
        }
        return MyButton(
          isLoading: isLoading,
          onTap: loginTapped,
          title: 'Đăng nhập',
        );
      },
    );
  }
}
