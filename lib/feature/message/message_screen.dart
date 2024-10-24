import 'package:flutter/material.dart';

import '../../internal/theme/text_helper.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          " В разработке",
          style: TextHelper.poppins32w600,
        ),
      ),
    );
  }
}
