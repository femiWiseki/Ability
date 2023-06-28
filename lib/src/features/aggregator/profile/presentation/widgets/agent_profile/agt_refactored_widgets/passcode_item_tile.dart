import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class PasscodeItemTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const PasscodeItemTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                AppStyleGilroy.kFontW5.copyWith(fontSize: 15, color: kBlack2),
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: kBlack2,
          )
        ],
      ),
    );
  }
}
