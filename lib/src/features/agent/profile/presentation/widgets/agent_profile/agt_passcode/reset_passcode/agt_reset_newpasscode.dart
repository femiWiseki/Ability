// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AgtResetNewPasscode extends ConsumerWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgtResetNewPasscode(this.validationHelper, this.agentController, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 31.79, 24, 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const BackIcon(),
                  const AppHeader(heading: 'PASSCODE'),
                  const SizedBox(height: 54.11),
                  Text('Input new passcode',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 26.71),
                  Center(
                    child: GeneralPinCode(
                        pinLenght: 4,
                        boxPinShape: PinCodeFieldShape.box,
                        controller: agentController.resetNewPasscode,
                        validator: (value) =>
                            validationHelper.validateNewPasscode(value!)),
                  ),
                  const SizedBox(height: 153.54),
                  AbilityButton(
                    onPressed: () async {
                      // final indexNumber = StateProvider((ref) => 3);
                      if (_formKey.currentState!.validate()) {
                        // PageNavigator(ctx: context).nextPage(
                        //     page: AgtBottomNavBar(indexProvider: indexNumber));
                        await ref
                            .read(loadingAgtResetNewPasscode.notifier)
                            .newPasscodeService(
                                context: context,
                                newPasscode: agentController.newPasscode.text);
                      }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgtResetNewPasscode)
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
