import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtNotificationsTile extends ConsumerWidget {
  final String title;
  final String dateTime;
  final String body;
  final void Function()? onTap;
  const AgtNotificationsTile({
    required this.title,
    required this.dateTime,
    required this.body,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: kWhite, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kPrimary),
                        child: Image.asset('assets/icons/app_logo.png')),
                    const SizedBox(width: 10),
                    Text(
                      convertToUppercase(title),
                      style: AppStyleRoboto.kFontW6.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    convertToUppercase(body),
                    style: AppStyleRoboto.kFontW6.copyWith(
                        fontSize: 13, color: kBlack2.withOpacity(0.6)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: kGrey3.withOpacity(0.4),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      dateTime,
                      style: AppStyleGilroy.kFontW6.copyWith(
                          fontSize: 13, color: kBlack2.withOpacity(0.6)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
