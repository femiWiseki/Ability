import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/aggregator/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

formatDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // final indexNumber = StateProvider<int>((ref) => 0);
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: SizedBox(
          height: 150,
          width: 345,
          child: Consumer(
            builder: (context, ref, child) {
              void selectFormat(BuildContext context, String format) {
                ref.read(fileFormatterProvider.notifier).state = format;
                Navigator.of(context).pop();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Choose Format',
                      style: AppStyleGilroy.kFontW6
                          .copyWith(fontSize: 14, color: kGrey2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () => selectFormat(context, 'PDF'),
                      child: Text(
                        'PDF',
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 16, color: kBlack2),
                      )),
                  const Divider(thickness: 1, color: kGrey3),
                  TextButton(
                      onPressed: () => selectFormat(context, 'Microsoft Excel'),
                      child: Text(
                        'Microsoft Excel',
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 16, color: kBlack2),
                      )),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
