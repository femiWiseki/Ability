import 'dart:async';

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GeneralPinCode extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int pinLenght;
  final PinCodeFieldShape? boxPinShape;
  final double? fieldWidth;
  const GeneralPinCode({
    super.key,
    required this.pinLenght,
    required this.controller,
    this.boxPinShape,
    this.fieldWidth,
    required this.validator,
  });

  @override
  State<GeneralPinCode> createState() => _GeneralPinCodeState();
}

class _GeneralPinCodeState extends State<GeneralPinCode> {
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return PinCodeTextField(
          appContext: context,
          pastedTextStyle:
              AppStyleGilroy.kFontW6.copyWith(color: kBlack, fontSize: 18),
          length: widget.pinLenght,
          obscureText: true,
          obscuringCharacter: '*',
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: widget.validator,
          pinTheme: PinTheme(
            shape: widget.boxPinShape ?? PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(8.39),
            borderWidth: 1.68,
            fieldHeight: 63.75,
            fieldWidth: widget.fieldWidth ?? 70.46,
            activeColor: kPrimary,
            inactiveColor: kBlack50,
            activeFillColor: kWhite,
            inactiveFillColor: kWhite,
          ),
          cursorColor: kBlack,
          cursorHeight: 15,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: widget.controller,
          keyboardType: TextInputType.number,
          onCompleted: (v) {
            debugPrint("Completed");
            ref.watch(isEditingProvider.notifier).state = true;
          },
          onSubmitted: (value) {
            ref.watch(isEditingProvider.notifier).state = true;
          },
          onSaved: (newValue) {
            ref.watch(isEditingProvider.notifier).state = true;
          },
          onChanged: (value) {
            debugPrint(value);
            ref.watch(isEditingProvider.notifier).state = false;
            if (value.isEmpty) {
              ref.watch(isEditingProvider.notifier).state = false;
            }
            // setState(() {
            //   currentText = value;
            // });
          },

          // onTap: () {
          //   ref.watch(isEditingProvider.notifier).state = true;
          // },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        );
      },
    );
  }
}
