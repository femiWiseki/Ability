// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/otp_timer.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentInputNewPin extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgentInputNewPin(this.validationHelper, this.agentController, {super.key});

  @override
  ConsumerState<AgentInputNewPin> createState() => _AgentInputNewPinState();
}

class _AgentInputNewPinState extends ConsumerState<AgentInputNewPin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 38),
                  Text('Input New Pin',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 29),
                  Text('Please enter the code sent to your Email',
                      style: AppStyleGilroy.kFontW5
                          .copyWith(fontSize: 12, color: kBlack2)),
                  const SizedBox(height: 9),
                  Container(
                    height: 105,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: !ref.watch(isEditingProvider)
                            ? kPrimary.withOpacity(0.2)
                            : kPrimary,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GeneralPinCode(
                            pinLenght: 6,
                            controller: widget.agentController.inputNewPinOTP,
                            validator: (value) => widget.validationHelper
                                .validatePinCode(value!)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Didn't get code? ",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kGrey2)),
                      InkWell(
                        onTap: () {
                          // AgentResendOTPService()
                          //     .resendOTPService(context: context);
                        },
                        child: Text("Resend ",
                            style: AppStylePoppins.kFontW5
                                .copyWith(fontSize: 10, color: kPrimary)),
                      ),
                      Text("in ",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kPrimary)),
                      const OtpTimer(),
                    ],
                  ),
                  const SizedBox(height: 29),
                  AbilityPasswordField(
                    controller: widget.agentController.resetPassword,
                    heading: 'Pin',
                    hintText: '****',
                    maxLength: 4,
                    iconName: Icons.lock_rounded,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        widget.validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 20),
                  AbilityPasswordField(
                    controller: widget.agentController.confirmResetPassword,
                    heading: 'Confirm Pin',
                    hintText: '****',
                    maxLength: 4,
                    iconName: Icons.lock_rounded,
                    keyboardType: TextInputType.number,
                    validator: (value) => widget.validationHelper
                        .validatePassword2(value!,
                            widget.agentController.resetPassword.text.trim()),
                  ),
                  const SizedBox(height: 131),
                  AbilityButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        resetPinBottomSheet(context);
                      }
                    },
                    borderRadius: 10,
                    borderColor: ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                    buttonColor: ref.watch(isEditingProvider)
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
