// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_passcode/reset_passcode/agt_verify_resetpc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtResetPasscode extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgtResetPasscode(this.validationHelper, this.agentController, {super.key});

  @override
  ConsumerState<AgtResetPasscode> createState() => _AgtResetPasscodeState();
}

class _AgtResetPasscodeState extends ConsumerState<AgtResetPasscode> {
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
                  const AppHeader(heading: 'PASSCODE'),
                  const SizedBox(height: 74),
                  AbilityTextField(
                      controller: widget.agentController.resetPasscode,
                      heading: 'Email Address',
                      hintText: 'Email address',
                      iconName: Icons.email_rounded,
                      borderRadius: BorderRadius.circular(12),
                      validator: (value) =>
                          EmailValidator.validate(value!.trim())
                              ? null
                              : "Please enter a valid email"),
                  const SizedBox(height: 100),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        PageNavigator(ctx: context).nextPage(
                            page: AgtVerifyResetPasscode(
                                ValidationHelper(), AgentController()));
                        // await ref
                        //     .read(loadingAgentPinRest.notifier)
                        //     .pinResetService(
                        //         context: context,
                        //         email:
                        //             widget.agentController.pinRestEmail.text);
                        // PageNavigator(ctx: context).nextPage(
                        //     page: AgentInputNewPin(
                        //         ValidationHelper(), AgentController()));
                        // agentShowBottomSheet(context);
                      }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgentPinRest)
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
