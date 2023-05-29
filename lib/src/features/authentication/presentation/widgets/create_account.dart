// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/otp_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAccount extends ConsumerWidget {
  ValidationHelper validationHelper;

  CreateAccount(this.validationHelper, {super.key});

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
                      controller: kAgentSignupNameController,
                      validator: (value) =>
                          validationHelper.validateFirstName(value!),
                      heading: ref.watch(isAgentServiceProvider) == true
                          ? 'Full Name'
                          : 'Company Name',
                      hintText: ref.watch(isAgentServiceProvider) == true
                          ? 'Full Name'
                          : 'Company Name',
                      iconName: Icons.person_2_rounded),
                  const SizedBox(height: 2),
                  Text(
                    ref.watch(isAgentServiceProvider) == true
                        ? 'Make sure it is the name on your Identification card'
                        : 'Make sure it is the name on CAC certificate',
                    style: AppStylePoppins.kFontW4.copyWith(
                        fontSize: 10, color: kPrimary.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 15),
                  AbilityTextField(
                      controller: kAgentSignupEmailController,
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
                    keyboardType: TextInputType.phone,
                    controller: kAgentSignupPhoneController,
                    validator: (value) =>
                        validationHelper.validatePhoneNumber(value!),
                  ),
                  SizedBox(
                      height:
                          ref.watch(isAgentServiceProvider) == true ? 15 : 0),
                  ref.watch(isAgentServiceProvider) == true
                      ? AbilityTextField(
                          heading: 'Bvn',
                          controller: kAgentSignupBVNController,
                          validator: (value) =>
                              validationHelper.validateTextField(value!),
                        )
                      : Container(),
                  const SizedBox(height: 15),
                  AbilityPasswordField(
                    controller: kAgentSignupCreatePinController,
                    heading: 'Create Pin',
                    hintText: 'Enter 6-digit pin',
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) =>
                        validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 15),
                  AbilityPasswordField2(
                    controller: kAgentSignupConfirmPinController,
                    heading: 'Confirm Pin',
                    hintText: 'Enter 6-digit pin',
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) => validationHelper.validatePassword2(
                        value!, kAgentSignupCreatePinController.text),
                  ),
                  const SizedBox(height: 50.89),
                  AbilityButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        PageNavigator(ctx: context)
                            .nextPage(page: OTPScreen(ValidationHelper()));
                      }
                    },
                    borderColor: ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                    buttonColor: ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
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
