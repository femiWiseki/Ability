// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/application/services/resend_otp_service.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_passcode/reset_passcode/agt_reset_newpasscode.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AgtVerifyResetPasscode extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgtVerifyResetPasscode(this.validationHelper, this.agentController,
      {super.key});

  @override
  ConsumerState<AgtVerifyResetPasscode> createState() =>
      _AgtVerifyResetPasscodeState();
}

class _AgtVerifyResetPasscodeState
    extends ConsumerState<AgtVerifyResetPasscode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(60);

  @override
  void dispose() {
    _timerNotifier.dispose(); // Dispose the timer notifier
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_timerNotifier.value <= 0) {
        timer.cancel();
        // Timer has completed, implement your logic here
      } else {
        _timerNotifier.value -= 1; // Decrement the timer value
      }
    });
  }

  void resetTimer() {
    _timerNotifier.value = 60; // Reset the timer value
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer
  }

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
                  const AppHeader(heading: 'PASSCODE'),
                  const SizedBox(height: 74),
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
                            fieldWidth: 27,
                            controller:
                                widget.agentController.verifyOTPPasscode,
                            validator: (value) => widget.validationHelper
                                .validatePinCode(value!)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text("Didn't get code? ",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kGrey2)),
                      InkWell(
                        onTap: () {
                          widget.agentController.signupOTPPin.clear();
                          AgentResendOTPService()
                              .resendOTPService(context: context);
                          resetTimer();
                          startTimer();
                        },
                        child: Text("Resend ",
                            style: AppStylePoppins.kFontW5
                                .copyWith(fontSize: 10, color: kPrimary)),
                      ),
                      Text("in ",
                          style: AppStylePoppins.kFontW5
                              .copyWith(fontSize: 10, color: kPrimary)),
                      ValueListenableBuilder<int>(
                        valueListenable: _timerNotifier,
                        builder: (context, value, _) {
                          return Text(
                            value.toString(),
                            style: AppStylePoppins.kFontW5
                                .copyWith(fontSize: 10, color: kPrimary),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 170),
                  AbilityButton(
                    onPressed: () async {
                      PageNavigator(ctx: context).nextPage(
                          page: AgtResetNewPasscode(
                              ValidationHelper(), AgentController()));
                      // if (_formKey.currentState!.validate()) {
                      //   await ref
                      //       .read(loadingAgtVerifyPasscode.notifier)
                      //       .resetPasscodeService(
                      //         context: context,
                      //         otp:
                      //             widget.agentController.verifyOTPPasscode.text,
                      //       );
                      //   // agentShowBottomSheet(context);
                      // }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgtVerifyPasscode)
                        ? Text(
                            'continue',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 18),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: kWhite,
                            ),
                          ),
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
