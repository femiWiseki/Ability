// ignore_for_file: must_be_immutable, unrelated_type_equality_checks

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/poppins.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/application/services/signup_services/create_account_service.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_otp_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggregatorCreateAccount extends ConsumerWidget {
  ValidationHelper validationHelper;
  AggregatorController aggregatorController;
  AggregatorCreateAccount(this.validationHelper, this.aggregatorController,
      {super.key});

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
                      controller: aggregatorController.signupName,
                      validator: (value) =>
                          validationHelper.validateFirstName(value!),
                      heading: 'Company Name',
                      hintText: 'Company Name',
                      iconName: Icons.person_2_rounded),
                  const SizedBox(height: 2),
                  Text(
                    'Make sure it is the name on CAC certificate',
                    style: AppStylePoppins.kFontW4.copyWith(
                        fontSize: 10, color: kPrimary.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 15),
                  AbilityTextField(
                      controller: aggregatorController.signupEmail,
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
                    controller: aggregatorController.signupPhone,
                    validator: (value) =>
                        validationHelper.validatePhoneNumber(value!),
                  ),
                  const SizedBox(height: 15),
                  AbilityPasswordField(
                    controller: aggregatorController.signupCreatePin,
                    heading: 'Create Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) =>
                        validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 15),
                  AbilityPasswordField2(
                    controller: aggregatorController.signupConfirmPin,
                    heading: 'Confirm Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    iconName: Icons.lock_rounded,
                    borderRadius: BorderRadius.zero,
                    validator: (value) => validationHelper.validatePassword2(
                        value!, aggregatorController.signupCreatePin.text),
                  ),
                  const SizedBox(height: 50.89),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAggregatorCreateAccount.notifier)
                            .createAccountService(
                              context: context,
                              name: aggregatorController.signupName.text.trim(),
                              email:
                                  aggregatorController.signupEmail.text.trim(),
                              phoneNumber:
                                  aggregatorController.signupPhone.text.trim(),
                              pin: aggregatorController.signupCreatePin.text,
                            );
                      }
                      await AggregatorPreference.setEmail(
                          aggregatorController.signupEmail.text);
                      await AggregatorPreference.setPhoneNumber(
                          aggregatorController.signupPhone.text);
                    },
                    borderColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAggregatorCreateAccount)
                        ? Text(
                            'continue',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 18),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: kWhite,
                              backgroundColor: kRed,
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
