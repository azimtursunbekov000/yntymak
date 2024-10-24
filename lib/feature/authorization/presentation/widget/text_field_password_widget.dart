import 'package:flutter/material.dart';

import '../../../../internal/theme/text_helper.dart';
import '../../../../internal/theme/theme_helper.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const TextFieldPasswordWidget(
      {super.key, required this.labelText, this.onChanged, this.controller});

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextHelper.poppinsMedium14.copyWith(color: ThemeHelper.black),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ThemeHelper.black),
          ),
          child: Padding(
            padding: EdgeInsets.zero,
            child: TextField(
              controller: widget.controller,
              cursorColor: ThemeHelper.black,
              onChanged: widget.onChanged,
              style: const TextStyle(color: ThemeHelper.black),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ThemeHelper.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
