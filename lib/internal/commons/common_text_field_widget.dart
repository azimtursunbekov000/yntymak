import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../theme/text_helper.dart';
import '../theme/theme_helper.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? mask;
  final String? hintText;
  final bool isEmpty;
  final bool isBorder;
  final bool enabled;
  final bool showError;
  final int? maxLength;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const CommonTextFieldWidget({
    super.key,
    this.labelText,
    this.onChanged,
    this.mask,
    this.controller,
    this.hintText,
    this.isEmpty = false,
    this.enabled = true,
    this.showError = false,
    this.maxLength,
    this.suffixIcon,
    this.validator,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    var maskFormatter =
        mask != null ? MaskTextInputFormatter(mask: mask) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? '',
          style: TextHelper.poppinsMedium14.copyWith(color: ThemeHelper.black),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: isBorder
                ? Border.all(
                    color: Colors.transparent,
                  )
                : Border.all(
                    color: isEmpty ? Colors.red : ThemeHelper.black,
                    width: 1,
                  ),
          ),
          child: Padding(
            padding: EdgeInsets.zero,
            child: TextFormField(
              validator: validator,
              enabled: enabled,
              controller: controller,
              cursorColor: ThemeHelper.black,
              onChanged: onChanged,
              maxLength: maxLength,
              style: const TextStyle(color: ThemeHelper.black),
              inputFormatters: maskFormatter != null ? [maskFormatter] : [],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: hintText,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: suffixIcon,
                ),
                hintStyle:
                    TextHelper.poppins14.copyWith(color: ThemeHelper.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              'Заполните, пожалуйста, данное поле',
              style: TextHelper.poppins14.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
