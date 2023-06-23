// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AgtEnterTransferCode extends ConsumerWidget {
  ValidationHelper validationHelper;
  TransferController transferController;
  AgtEnterTransferCode(this.validationHelper, this.transferController,
      {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final indexNumber = StateProvider<int>((ref) => 1);
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
                        controller: transferController.agtEnterTransferCode,
                        validator: (value) =>
                            validationHelper.validatePinCode2(value!)),
                  ),
                  const SizedBox(height: 139.54),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAgtBankDetail2.notifier)
                            .resolveAccNumService(
                              context: context,
                              passcode:
                                  transferController.agtEnterTransferCode.text,
                            );
                        print(AgentPreference.getBankName());
                        // await ref
                        //     .read(loadingAgentLoginPasscode.notifier)
                        //     .passcodeLoginService(
                        //         context: context,
                        //         passcode: transferController.agtEnterTransferCode.text);
                      }
                      // print(AgentPreference.getPhoneToken());
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgtBankDetail2)
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
