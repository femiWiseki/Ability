import 'package:ability/globals.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: kRed,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snackBarKey.currentState?.showSnackBar(snackBar);
    });
    return message;
  }
}
