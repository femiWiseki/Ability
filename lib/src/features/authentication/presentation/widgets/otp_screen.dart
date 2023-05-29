// ignore_for_file: must_be_immutable

import 'package:ability/globals.dart';
import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OTPScreen extends ConsumerWidget {
  ValidationHelper validationHelper;
  OTPScreen(this.validationHelper, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackIcon(),
                  const SizedBox(height: 39),
                  Text('OTP',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 10),
                  Text('Please enter the code sent to your phone number',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 35),
                  Container(
                    height: 105,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: !ref.watch(isEditingProvider)
                              ? kPrimary.withOpacity(0.2)
                              : kPrimary,
                          width: !ref.watch(isEditingProvider) ? 0.2 : 2),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GeneralPinCode(
                            pinLenght: 6,
                            controller: kAgentSignupOTPPinController,
                            validator: (value) =>
                                validationHelper.validatePinCode(value!)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text("Didn't get code? ",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kGrey2)),
                      Text("Resend in 0.59",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kPrimary)),
                    ],
                  ),
                  const SizedBox(height: 171),
                  AbilityButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        agentShowBottomSheet(context);
                      }
                    },
                    borderColor: !ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                    buttonColor: !ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
