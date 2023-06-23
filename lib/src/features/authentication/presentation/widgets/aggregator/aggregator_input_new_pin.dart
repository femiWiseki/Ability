// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggregatorInputNewPin extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AggregatorController aggregatorController;
  AggregatorInputNewPin(this.validationHelper, this.aggregatorController,
      {super.key});

  @override
  ConsumerState<AggregatorInputNewPin> createState() =>
      _AggregatorInputNewPinState();
}

class _AggregatorInputNewPinState extends ConsumerState<AggregatorInputNewPin> {
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
                            fieldWidth: 27,
                            controller:
                                widget.aggregatorController.inputNewPinOTP,
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
                          // AggregatorResendOTPService()
                          //     .resendOTPService(context: context);
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
                  const SizedBox(height: 29),
                  AbilityPasswordField(
                    controller: widget.aggregatorController.resetPassword,
                    heading: 'Pin',
                    hintText: '******',
                    maxLength: 6,
                    iconName: Icons.lock_rounded,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        widget.validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 20),
                  AbilityPasswordField(
                    controller:
                        widget.aggregatorController.confirmResetPassword,
                    heading: 'Confirm Pin',
                    hintText: '******',
                    maxLength: 6,
                    iconName: Icons.lock_rounded,
                    keyboardType: TextInputType.number,
                    validator: (value) => widget.validationHelper
                        .validatePassword2(
                            value!,
                            widget.aggregatorController.resetPassword.text
                                .trim()),
                  ),
                  const SizedBox(height: 131),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .watch(loadingAggInputNewPin.notifier)
                            .inputNewPinService(
                                context: context,
                                otp: widget
                                    .aggregatorController.inputNewPinOTP.text,
                                newPin: widget
                                    .aggregatorController.resetPassword.text,
                                confirmPin: widget.aggregatorController
                                    .confirmResetPassword.text);
                      }
                    },
                    borderRadius: 10,
                    borderColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAggInputNewPin)
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
