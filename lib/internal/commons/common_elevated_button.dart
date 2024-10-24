import 'package:flutter/material.dart';

import '../theme/text_helper.dart';
import '../theme/theme_helper.dart';

class CommonElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CommonElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeHelper.elevatedBackColor,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: TextHelper.poppins14.copyWith(
          color: ThemeHelper.black,
        ),
      ),
    );
  }
}
