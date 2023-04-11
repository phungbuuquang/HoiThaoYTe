import 'package:flutter/material.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/widgets/my_dropdown_button.dart';
import 'package:xcademy/widgets/my_text_formfield.dart';

class MyTextFieldDropdown extends StatelessWidget {
  const MyTextFieldDropdown({
    Key? key,
    this.labelText,
    required this.items,
    required this.value,
    this.onChanged,
  }) : super(key: key);
  final String? labelText;
  final List<String> items;
  final String value;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: MyTextFormField(),
        ),
        MyDropDownButton<String>(
          context: context,
          hint: labelText,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: AppTextStyle.regular16Black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: value,
          onchanged: onChanged,
        ),
      ],
    );
  }
}
