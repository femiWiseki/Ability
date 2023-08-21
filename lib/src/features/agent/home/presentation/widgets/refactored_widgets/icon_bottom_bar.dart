// ignore_for_file: deprecated_member_use

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBottomBar extends ConsumerWidget {
  const IconBottomBar(
      {Key? key,
      required this.iconString1,
      required this.selected,
      required this.iconTitle,
      required this.onPressed})
      : super(key: key);
  final String iconString1;
  final bool selected;
  final Function() onPressed;
  final String iconTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 52,
              height: 39,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
              ),
              child: SvgPicture.asset(
                iconString1,
                color: selected ? kPrimary : kGrey2,
                fit: BoxFit.contain,
              )),
          Text(
            iconTitle,
            style: AppStyleGilroy.kFontW6
                .copyWith(color: selected ? kPrimary : kGrey2, fontSize: 13),
          )
        ],
      ),
    );
  }
}
