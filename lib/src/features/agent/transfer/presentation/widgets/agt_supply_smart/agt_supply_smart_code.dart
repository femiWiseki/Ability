// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/fingerprint_auth.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/agent/transfer/application/services/agt_save_bene_service.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AgtSupplySmartCode extends ConsumerWidget {
  ValidationHelper validationHelper;
  TransferController transferController;
  AgtSupplySmartCode(this.validationHelper, this.transferController,
      {super.key});

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
                  const AppHeader(heading: 'Transfer'),
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
                      controller: transferController.agtSupplySmartCode,
                      validator: (value) =>
                          validationHelper.validatePinCode2(value!),
                      pinIsComplete: () async {
                        if (_formKey.currentState!.validate()) {
                          if (AgentPreference.getIsAgentVerified() == true) {
                            await ref
                                .read(loadingAgtBankDetail2.notifier)
                                .transferMoneyService(
                                  context: context,
                                  passcode: transferController
                                      .agtEnterTransferCode.text,
                                );
                            ref.watch(saveBeneficiaryProvider) == true
                                ? AgtSaveBeneficiaryService()
                                    .saveBeneficiaryService(context: context)
                                : false;
                          } else {
                            errorMessage(
                                context: context,
                                message: 'This account is not verified');
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      // Call userFingerPrintAuth and provide the callback function
                      userFingerPrintAuth(
                        context: context,
                        proceedAuth: () async {
                          if (ref
                                  .read(fingerBiometricsProvider.notifier)
                                  .state ==
                              true) {
                            if (AgentPreference.getIsAgentVerified() == true) {
                              await ref
                                  .read(loadingAgtBankDetail2.notifier)
                                  .transferMoneyService(
                                    context: context,
                                    passcode: transferController
                                        .agtEnterTransferCode.text,
                                  );
                              ref.watch(saveBeneficiaryProvider) == true
                                  ? AgtSaveBeneficiaryService()
                                      .saveBeneficiaryService(context: context)
                                  : false;
                            } else {
                              errorMessage(
                                  context: context,
                                  message: 'This account is not verified');
                            }
                          } else {
                            errorMessage(
                                context: context,
                                message:
                                    'Please Enable Fingerprint Biometric for Enhanced Security');
                          }
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Use fingerprint ",
                          style: AppStyleRoboto.kFontW4
                              .copyWith(fontSize: 14, color: kGrey2),
                        ),
                        const Icon(
                          Icons.fingerprint_outlined,
                          color: kPrimary,
                          size: 30,
                        ),
                      ],
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
