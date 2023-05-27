import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AbilityButton extends ConsumerWidget {
  const AbilityButton( {
    Key? key,
    this.title,
    this.titleColor,
    this.buttonColor,
    this.height,
    this.width,
    this.borderColor,
    required this.onPressed,
    this.iconVisibility,
    this.titleStyle,
    this.borderRadius,
    this.style,
    this.icon,
    this.child,
  }) : super(key: key);

  final String? title;
  final IconData? icon;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Function()? onPressed;
  final bool? iconVisibility;
  final double? borderRadius;
  final Widget? child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 60,
      child: ElevatedButton(
          style: style ??
              ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(borderRadius ?? 30.0),
                        side: BorderSide(color: borderColor ?? kPrimary))),
                backgroundColor:
                    MaterialStateProperty.all<Color>(buttonColor ?? kPrimary),
              ),
          onPressed: onPressed,
          child: child ??
              Text(
                title ?? 'Continue',
                style: titleStyle ??
                    AppStyleGilroy.kFontW6.copyWith(
                      color: titleColor ?? kWhite,
                    ),
              )),
    );
  }
}
