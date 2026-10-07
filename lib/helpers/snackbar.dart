import 'package:flutter/material.dart';
import 'package:note_sphere/utils/text_styles.dart';

class AppHelpers {
  static void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.appButton.copyWith(color: Colors.black),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
