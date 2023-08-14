import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class AccStatementTile extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  final Color? suffixTextColor;
  final double? suffixTextFontSize;
  const AccStatementTile({
    super.key,
    required this.prefixText,
    required this.suffixText,
    this.suffixTextColor,
    this.suffixTextFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prefixText,
            style: AppStyleGilroy.kFontW6
                .copyWith(fontSize: 12.69, color: kBlack2, letterSpacing: 0.29),
          ),
          Text(
            suffixText,
            style: AppStyleGilroy.kFontW6.copyWith(
                fontSize: suffixTextFontSize ?? 13.48,
                color: suffixTextColor ?? kBlack,
                letterSpacing: 0.33,
                height: 1.40),
          ),
        ],
      ),
    );
  }
}
