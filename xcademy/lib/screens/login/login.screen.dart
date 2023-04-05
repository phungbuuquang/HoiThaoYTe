import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/login/bloc/login_bloc.dart';
import 'package:xcademy/utils/common_utils.dart';

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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    ColorConstant.subPrimary,
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                height: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabelWithFormFieldView(
                          'Tên đăng nhập',
                          controller: _usernameTextController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Vui lòng nhập tên đăng nhập!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        _buildLabelWithFormFieldView(
                          'Mật khẩu',
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
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        return InkWell(
          onTap: isLoading ? null : loginTapped,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Column _buildLabelWithFormFieldView(
    String title, {
    Widget? suffixIcon,
    bool isObscure = false,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 3),
        _buildFormField(
          suffixIcon: suffixIcon,
          isObscure: isObscure,
          controller: controller,
          validator: validator,
        )
      ],
    );
  }

  TextFormField _buildFormField({
    Widget? suffixIcon,
    bool isObscure = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, left: 10),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
      ),
    );
  }
}
