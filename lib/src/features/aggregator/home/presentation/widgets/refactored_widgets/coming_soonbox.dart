import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class ComingSoonBox extends StatelessWidget {
  const ComingSoonBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19.97,
      width: 62.64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.62),
        color: kPrimary.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          'coming soon',
          style:
              AppStyleGilroy.kFontW6.copyWith(color: kPrimary, fontSize: 7.26),
        ),
      ),
    );
  }
}
