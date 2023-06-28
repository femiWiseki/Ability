import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class ConfirmDetailsTile extends StatelessWidget {
  final String prefixText;
  final String? suffixText;
  final Widget? withLogo;
  const ConfirmDetailsTile({
    super.key,
    required this.prefixText,
    this.suffixText,
    this.withLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prefixText,
            style: AppStyleGilroy.kFontW5
                .copyWith(fontSize: 11.52, color: kBlack2),
          ),
          withLogo ??
              Text(
                suffixText ?? '',
                style: AppStyleRoboto.kFontW6
                    .copyWith(fontSize: 12, color: kBlack2),
              ),
        ],
      ),
    );
  }
}
