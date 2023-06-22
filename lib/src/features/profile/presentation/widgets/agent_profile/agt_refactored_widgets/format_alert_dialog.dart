import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/profile/presentation/providers/profile_providers.dart';
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
          height: 200,
          width: 345,
          child: Consumer(
            builder: (context, ref, child) {
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
                  const SizedBox(height: 58),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(fileFormatProvider.notifier)
                            .selectFormat('PDF');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'PDF',
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 16, color: kBlack2),
                      )),
                  const Divider(thickness: 1, color: kGrey3),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(fileFormatProvider.notifier)
                            .selectFormat('Microsoft Excel');
                        Navigator.of(context).pop();
                      },
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
