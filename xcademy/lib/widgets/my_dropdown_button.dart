import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/widgets/my_image.dart';

class MyDropDownButton<T> extends StatelessWidget {
  const MyDropDownButton({
    Key? key,
    required this.context,
    required this.items,
    required this.value,
    this.onchanged,
    this.hint,
    this.isBorder = false,
    this.selectedItemBuilder,
  }) : super(key: key);

  final BuildContext context;
  final List<DropdownMenuItem<T>>? items;

  final T value;
  final Function(T? p1)? onchanged;
  final String? hint;
  final bool isBorder;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  @override
  Widget build(BuildContext context) => DropdownButton2<T>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                hint ?? '',
                style: AppTextStyle.regular12Gray,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items,
        value: value,
        onChanged: onchanged,
        icon: const MyImage(
          'ic_ar_down.svg',
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
        buttonHeight: 50,
        underline: Container(),
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: isBorder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  color: ColorConstant.grayEAB.withOpacity(0.24),
                ),
              )
            : null,
        buttonElevation: 0,
        itemHeight: 40,
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        selectedItemHighlightColor: ColorConstant.selected,
        style: AppTextStyle.regular14Gray,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 14,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        dropdownElevation: 0,
        selectedItemBuilder: selectedItemBuilder,
      );
}
