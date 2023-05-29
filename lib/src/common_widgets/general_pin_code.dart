import 'dart:async';

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GeneralPinCode extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int pinLenght;
  const GeneralPinCode(
      {super.key,
      required this.pinLenght,
      required this.controller,
      required this.validator});

  @override
  State<GeneralPinCode> createState() => _GeneralPinCodeState();
}

class _GeneralPinCodeState extends State<GeneralPinCode> {
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  // final formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   errorController = StreamController<ErrorAnimationType>();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   errorController!.close();
  //   super.dispose();
  // }

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
            shape: PinCodeFieldShape.underline,
            borderWidth: 0.2,
            fieldHeight: 30,
            fieldWidth: 27,
            activeColor: kBlack,
            inactiveColor: kPrimary,
            activeFillColor: kWhite,
            inactiveFillColor: kWhite,
          ),
          cursorColor: kBlack,
          cursorHeight: 15,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          // errorAnimationController: errorController,
          controller: widget.controller,
          keyboardType: TextInputType.number,

          onCompleted: (v) {
            debugPrint("Completed");
            ref.watch(isEditingProvider.notifier).state = true;
          },
          onChanged: (value) {
            debugPrint(value);
            ref.watch(isEditingProvider.notifier).state = true;
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        );
      },
    );
  }
}
