// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ElectricityPasscode extends ConsumerWidget {
  ValidationHelper validationHelper;
  AgtPaymentController paymentController;
  final String meterNumber;
  final int amount;
  final String paymentType;
  final String serviceProvider;
  ElectricityPasscode(this.validationHelper, this.paymentController,
      {required this.meterNumber,
      required this.amount,
      required this.serviceProvider,
      required this.paymentType,
      super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppHeader(heading: 'Electricity'),
                  const SizedBox(height: 55.11),
                  Container(
                    width: 121,
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimary.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text('Enter Passcode',
                          style: AppStyleGilroy.kFontW5
                              .copyWith(fontSize: 12, color: kPrimary)),
                    ),
                  ),
                  const SizedBox(height: 39.71),
                  Center(
                    child: GeneralPinCode(
                      pinLenght: 4,
                      boxPinShape: PinCodeFieldShape.box,
                      controller: paymentController.electricityPasscode,
                      validator: (value) =>
                          validationHelper.validatePinCode2(value!),
                      pinIsComplete: () async {
                        if (_formKey.currentState!.validate()) {
                          if (ref.watch(isVerifiedProvider) == true &&
                              ref.watch(isDisabledProvider) == false) {
                            await ref
                                .watch(loadingPayAllBills.notifier)
                                .payBillsService(
                                  context: context,
                                  customerNum: meterNumber,
                                  amount: amount,
                                  paymentType: paymentType,
                                  networkProvider: serviceProvider,
                                  passcode: paymentController
                                      .electricityPasscode.text,
                                );
                          } else {
                            errorMessage(
                                context: context,
                                message:
                                    'This account is not valid. Please, contact support.');
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
