import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralTile extends StatelessWidget {
  final String prefixIconPath;
  final String title;
  final Widget? suffixIcons;
  final TextStyle? textStyle;
  final void Function()? onTap;
  const GeneralTile({
    super.key,
    required this.prefixIconPath,
    required this.title,
    this.suffixIcons,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 20,
          width: 292.14,
          child: Row(
            children: [
              SvgPicture.asset(
                prefixIconPath,
                height: 16.34,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: textStyle ??
                    AppStyleGilroy.kFontW5
                        .copyWith(fontSize: 15, color: kBlack2),
              ),
              const Spacer(),
              suffixIcons ?? const Icon(Icons.keyboard_arrow_right_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
