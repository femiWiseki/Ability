import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

void isLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: kGrey3.withOpacity(0.4),
    builder: (context) => Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: kGrey3,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const CircularProgressIndicator(
          color: kPrimary,
        ),
      ),
    ),
  );
}
