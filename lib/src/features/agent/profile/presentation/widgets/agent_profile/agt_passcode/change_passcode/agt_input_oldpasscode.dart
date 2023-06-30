// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_passcode/change_passcode/agt_input_newpasscode.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AgtInputOldPasscode extends ConsumerWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgtInputOldPasscode(this.validationHelper, this.agentController, {super.key});

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
                  Text('Input old passcode',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 26.71),
                  Center(
                    child: GeneralPinCode(
                        pinLenght: 4,
                        boxPinShape: PinCodeFieldShape.box,
                        controller: agentController.oldPasscode,
                        validator: (value) =>
                            validationHelper.validateOldPasscode(value!)),
                  ),
                  const SizedBox(height: 153.54),
                  AbilityButton(
                    onPressed: () async {
                      print(agentController.loginPasscode.text);
                      if (_formKey.currentState!.validate()) {
                        PageNavigator(ctx: context).nextPage(
                            page: AgtInputNewPasscode(
                                ValidationHelper(), AgentController()));
                        // await ref
                        //     .read(loadingAgentPasscode.notifier)
                        //     .getPasscodeService(
                        //         context: context,
                        //         passcode: agentController.signupPasscode.text);
                      }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgentPasscode)
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
