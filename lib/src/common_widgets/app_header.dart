import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String? heading;
  final Widget? suffixIcon;
  const AppHeader({
    this.heading,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: kPrimary,
          ),
        ),
        Text(
          heading ?? '',
          style: AppStyleInter.kFontW6.copyWith(fontSize: 20),
        ),
        suffixIcon ?? const SizedBox(width: 25),
      ],
    );
  }
}
