import 'package:flutter/material.dart';
import 'package:xcademy/resources/color_constant.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.controller,
    this.isObscure = false,
    this.validator,
    this.suffixIcon,
    this.labelText,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      controller: controller,
      obscureText: isObscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          color: ColorConstant.subtitleColor,
        ),
        contentPadding: const EdgeInsets.only(top: 10, left: 10),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffD8DFEA),
          ),
        ),
      ),
    );
  }
}
