// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/pin_reset.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputNewPin extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  InputNewPin(this.validationHelper, {super.key});

  @override
  ConsumerState<InputNewPin> createState() => _InputNewPinState();
}

class _InputNewPinState extends ConsumerState<InputNewPin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CountryCode? _countryCode;
  late FlCountryCodePicker countryPicker;
  int? maxLength = 10;
  @override
  void initState() {
    final preferredCountries = ['NG'];
    countryPicker = FlCountryCodePicker(filteredCountries: preferredCountries);
    _loadSavedCredentials();
    super.initState();
  }

  void _loadSavedCredentials() async {
    await Future.delayed(const Duration(seconds: 2), () {
      var phoneNumber = UserPreference.getSavePhoneNumber();
      var password = UserPreference.getSavePassword();

      if (phoneNumber != null && password != null) {
        kLoginPhoneNumberController.text = phoneNumber;
        kLoginPasswordController.text = password;
        ref.watch(savePasswordProvider.notifier).state = true;
      }
    });
  }

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
                  const BackIcon(),
                  const SizedBox(height: 38),
                  Text('Input New Pin',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 47),
                  AbilityPasswordField(
                    controller: kResetPasswordController,
                    heading: 'Password',
                    hintText: '**********',
                    iconName: Icons.lock_rounded,
                    validator: (value) =>
                        widget.validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 20),
                  AbilityPasswordField(
                    controller: kConfirmResetPasswordController,
                    heading: 'Confirm Password',
                    hintText: '**********',
                    iconName: Icons.lock_rounded,
                    validator: (value) => widget.validationHelper
                        .validatePassword2(
                            value!, kResetPasswordController.text.trim()),
                  ),
                  const SizedBox(height: 131),
                  AbilityButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        resetPinBottomSheet(context);
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
