// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/pin_reset_otp.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_phone_number.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinReset extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  PinReset(this.validationHelper, {super.key});

  @override
  ConsumerState<PinReset> createState() => _PinResetState();
}

class _PinResetState extends ConsumerState<PinReset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CountryCode? _countryCode;
  late FlCountryCodePicker countryPicker;
  int? maxLength = 10;
  @override
  void initState() {
    final preferredCountries = ['NG'];
    countryPicker = FlCountryCodePicker(filteredCountries: preferredCountries);
    super.initState();
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
                  Text('Pin Reset',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 10),
                  Text('First, we have to validate your phone number',
                      style: AppStyleGilroy.kFontW5
                          .copyWith(fontSize: 12, color: kBlack2)),
                  const SizedBox(height: 47),
                  AbilityPhoneNumber(
                    phoneController: kLoginPhoneNumberController,
                    maxLength: 10,
                    validator: (value) =>
                        widget.validationHelper.validatePhoneNumber(value!),
                    prefixWidget: SizedBox(
                      width: 120,
                      height: 24,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 4.0),
                            child: SizedBox(
                              width: 24,
                              height: 18,
                              child:
                                  _countryCode?.flagImage(fit: BoxFit.fill) ??
                                      Image.asset(
                                        'assets/icons/flag.png',
                                        fit: BoxFit.fill,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.98, top: 3),
                            child: Text(
                              _countryCode?.dialCode ?? '+234',
                              style: AppStyleGilroy.kFontW5
                                  .copyWith(fontSize: 14, color: kBlack2),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final code = await countryPicker.showPicker(
                                  context: context);
                              setState(() {
                                _countryCode = code;
                              });
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: kBlack10,
                            ),
                          ),
                          const VerticalDivider(
                            indent: 10,
                            endIndent: 10,
                            color: kGrey10,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  AbilityButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        agentShowBottomSheet(context);
                      }
                      PageNavigator(ctx: context)
                          .nextPage(page: PinResetOTP(ValidationHelper()));
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
