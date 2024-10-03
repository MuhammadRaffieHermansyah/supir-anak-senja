// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class Utilities {
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
