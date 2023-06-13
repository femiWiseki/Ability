// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_pin_reset.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_phone_number.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggregatorLoginScreen extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AggregatorController aggregatorController;
  AggregatorLoginScreen(this.validationHelper, this.aggregatorController,
      {super.key});

  @override
  ConsumerState<AggregatorLoginScreen> createState() =>
      _AggregatorLoginScreenState();
}

class _AggregatorLoginScreenState extends ConsumerState<AggregatorLoginScreen> {
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
      var phoneNumber = AggregatorPreference.getSavedPhoneNumber();
      var password = AggregatorPreference.getSavedPassword();

      if (phoneNumber != null && password != null) {
        widget.aggregatorController.loginPhoneNumber.text = phoneNumber;
        widget.aggregatorController.loginPassword.text = password;
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
                  Text('Welcome back',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 61),
                  AbilityPhoneNumber(
                    phoneController:
                        widget.aggregatorController.loginPhoneNumber,
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
                                // updateMaxLength();
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
                  const SizedBox(height: 20),
                  AbilityPasswordField(
                    controller: widget.aggregatorController.loginPassword,
                    heading: 'Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    iconName: Icons.lock_rounded,
                    validator: (value) =>
                        widget.validationHelper.validatePassword(value!),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return Row(
                            children: [
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 11,
                                height: 11,
                                child: Checkbox(
                                  checkColor: kPrimary, // color of tick Mark
                                  activeColor: kWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: 1.0,
                                        color: kPrimary.withOpacity(0.8)),
                                  ),
                                  value: ref.watch(savePasswordProvider),
                                  onChanged: (value) {
                                    ref
                                            .read(savePasswordProvider.notifier)
                                            .state =
                                        !ref
                                            .read(savePasswordProvider.notifier)
                                            .state;
                                  },
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Remember me",
                                style: AppStyleGilroy.kFontW5
                                    .copyWith(color: kPrimary, fontSize: 14),
                              ),
                            ],
                          );
                        },
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                              page: AggregatorResetPin(
                                  ValidationHelper(), AggregatorController()));
                        },
                        child: Text(
                          "Forgot Pin?",
                          style: AppStyleGilroy.kFontW5
                              .copyWith(color: kPrimary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAggregatorLogin.notifier)
                            .getLoginService(
                                context: context,
                                phoneNumber:
                                    "0${widget.aggregatorController.loginPhoneNumber.text}",
                                pin: widget
                                    .aggregatorController.loginPassword.text);
                      }
                      if (ref.watch(savePasswordProvider)) {
                        AggregatorPreference.setSavedPhoneNumber(widget
                            .aggregatorController.loginPhoneNumber.text
                            .trim());
                        AggregatorPreference.setSavedPassword(
                            widget.aggregatorController.loginPassword.text);
                      }
                    },
                    borderColor: ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                    buttonColor: ref.watch(isEditingProvider)
                        ? kPrimary.withOpacity(0.5)
                        : kPrimary,
                    child: !ref.watch(loadingAggregatorLogin)
                        ? Text(
                            'continue',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 18),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: kPrimary,
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
