import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

unenrollFingerPTDialog(
    {required BuildContext context, required void Function() unenrollFinger}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Column(
          children: [
            const Icon(
              Icons.fingerprint,
              size: 60,
              color: kPrimary,
            ),
            const SizedBox(height: 10),
            Text(
              'Do you want to disable biometrics?',
              style:
                  AppStyleRoboto.kFontW7.copyWith(fontSize: 16, color: kBlack),
            ),
            const SizedBox(height: 10),
            Text(
              'Please confirm if you want to disable biometrics. This action will temporarily disable biometrics for login.',
              textAlign: TextAlign.center,
              style:
                  AppStyleRoboto.kFontW4.copyWith(color: kGrey2, fontSize: 13),
            ),
            const SizedBox(height: 30),
            AbilityButton(
              onPressed: () {
                unenrollFinger.call();
              },
              title: 'Confirm',
              buttonColor: kPrimary,
              borderColor: kPrimary,
            ),
            const SizedBox(height: 10),
            AbilityButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Close',
              buttonColor: kGrey3,
              borderColor: kGrey3,
            )
          ],
        ),
      );
    },
  );
}
