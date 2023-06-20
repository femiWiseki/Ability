import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final String header;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final void Function()? onTap;
  const TextFieldContainer({
    required this.header,
    this.child,
    this.padding,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          header,
          style: AppStyleGilroy.kFontW4.copyWith(fontSize: 14, color: kBlack2),
        ),
        const SizedBox(height: 8),
        Container(
          height: 67,
          width: double.maxFinite,
          padding: padding ?? const EdgeInsets.fromLTRB(0, 8, 16, 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color ?? kBlack50)),
          child: child,
        ),
      ]),
    );
  }
}
