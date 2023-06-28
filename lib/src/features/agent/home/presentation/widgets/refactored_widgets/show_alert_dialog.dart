import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

generalSuccessfullDialog({
  required BuildContext context,
  required String description,
  required void Function()? onTap,
}) {
  showDialog(
    context: context,
    barrierColor: kAsh1.withOpacity(0.8),
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: SizedBox(
          height: 370,
          width: 345,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/wallet_success.svg'),
                const SizedBox(height: 25.6),
                Text(
                  'Successful!',
                  style: AppStyleGilroy.kFontW6
                      .copyWith(fontSize: 20, color: kPrimary),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW5
                      .copyWith(fontSize: 12, color: kBlack2),
                ),
                const SizedBox(height: 36),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      width: 296,
                      borderRadius: 10,
                      onPressed: onTap,
                      borderColor: kPrimary,
                      buttonColor: kPrimary,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
