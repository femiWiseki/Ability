// ignore_for_file: must_be_immutable, unrelated_type_equality_checks

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentCreateAccount extends ConsumerWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgentCreateAccount(this.validationHelper, this.agentController, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const SizedBox(height: 39),
                  Text('Create Account',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 10),
                  Text('Sign up on abity to access our suite of service',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 40),
                  AbilityTextField(
                      controller: agentController.signupName,
                      validator: (value) =>
                          validationHelper.validateFirstName(value!),
                      heading: 'Full Name',
                      hintText: 'Full Name',
                      iconName: Icons.person_2_rounded),
                  const SizedBox(height: 2),
                  Text(
                    'Make sure it is the name on your Identification card',
                    style: AppStylePoppins.kFontW4.copyWith(
                        fontSize: 10, color: kPrimary.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 15),
                  AbilityTextField(
                      controller: agentController.signupEmail,
                      heading: 'Email Address',
                      hintText: 'Email address',
                      iconName: Icons.email_rounded,
                      validator: (value) =>
                          EmailValidator.validate(value!.trim())
                              ? null
                              : "Please enter a valid email"),
                  const SizedBox(height: 15),
                  AbilityTextField(
                    heading: 'Phone Number',
                    hintText: 'Phone number',
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    controller: agentController.signupPhone,
                    validator: (value) =>
                        validationHelper.validatePhoneNumber(value!),
                  ),
                  const SizedBox(height: 15),
                  AbilityTextField(
                    heading: 'Bvn',
                    maxLength: 11,
                    controller: agentController.signupBVN,
                  ),
                  const SizedBox(height: 15),
                  AbilityPasswordField(
                    controller: agentController.signupCreatePin,
                    heading: 'Create Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) =>
                        validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 15),
                  AbilityPasswordField2(
                    controller: agentController.signupConfirmPin,
                    heading: 'Confirm Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) => validationHelper.validatePassword2(
                        value!, agentController.signupCreatePin.text),
                  ),
                  const SizedBox(height: 50.89),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAgentCreateAccount.notifier)
                            .createAccountService(
                              context: context,
                              name: agentController.signupName.text.trim(),
                              email: agentController.signupEmail.text.trim(),
                              phoneNumber:
                                  agentController.signupPhone.text.trim(),
                              pin: agentController.signupCreatePin.text,
                              bvn: agentController.signupBVN.text.trim(),
                            );
                      }
                      await AgentPreference.setEmail(
                          agentController.signupEmail.text);
                    },
                    borderColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgentCreateAccount)
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
