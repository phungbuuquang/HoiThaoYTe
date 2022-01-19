import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/login/bloc/login_bloc.dart';

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
  // bool isLoading = false;

  loginTapped() async {
    _bloc.login(
      _usernameTextController.text,
      _passwordTextController.text,
    );
    // Navigator.of(context).pushReplacementNamed(RouterName.base_tabbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithFormFieldView(
              'Email',
              controller: _usernameTextController,
            ),
            SizedBox(height: 20),
            _buildLabelWithFormFieldView(
              'Mật khẩu',
              controller: _passwordTextController,
              isObscure: _isObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
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
            Text(
              'Bạn đã quên mật khẩu?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
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
        )
      ],
    );
  }

  TextFormField _buildFormField({
    Widget? suffixIcon,
    bool isObscure = false,
    TextEditingController? controller,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      controller: controller,
      obscureText: isObscure,
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
