import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This is Error Page",
          style: TextStyle(
            fontSize: 30,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
