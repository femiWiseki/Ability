import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String? heading;
  const AppHeader({
    this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.arrow_back_rounded),
        Text(
          heading ?? '',
          style: AppStyleInter.kFontW6.copyWith(fontSize: 20),
        ),
        const SizedBox(width: 25),
      ],
    );
  }
}
