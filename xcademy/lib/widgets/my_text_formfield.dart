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
    this.radius,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  final double? radius;
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
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.grayEAB.withOpacity(0.24),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.grayEAB.withOpacity(0.24),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.grayEAB.withOpacity(0.24),
          ),
        ),
      ),
    );
  }
}
