// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/fingerprint_auth.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/authentication/application/services/login_services/login_service.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agent/agent_pin_reset.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/landing_page.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';

import 'package:ability/src/common_widgets/ability_password_field.dart';
import 'package:ability/src/common_widgets/ability_phone_number.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentLoginScreen extends ConsumerStatefulWidget {
  ValidationHelper validationHelper;
  AgentController agentController;
  AgentLoginScreen(this.validationHelper, this.agentController, {super.key});

  @override
  ConsumerState<AgentLoginScreen> createState() => _AgentLoginScreenState();
}

class _AgentLoginScreenState extends ConsumerState<AgentLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CountryCode? _countryCode;
  // late FlCountryCodePicker countryPicker;
  int? maxLength = 10;
  void onAuthenticationSuccess() {
    // Place your post-authentication logic here
    if (ref.read(fingerBiometricsProvider.notifier).state == true) {
      FingerprintLoginService().fingerprintLogin(context: context);
      print('Fingerprint authentication successful, on to HomeScreen!');
    } else {
      errorMessage(
          context: context,
          message: 'Please Enable Fingerprint Biometric for Enhanced Security');
    }
  }

  @override
  void initState() {
    // final preferredCountries = ['NG'];
    // countryPicker = FlCountryCodePicker(filteredCountries: preferredCountries);
    _loadSavedCredentials();
    userFingerPrintAuth(context: context, proceedAuth: onAuthenticationSuccess);
    super.initState();
  }

  void _loadSavedCredentials() async {
    await Future.delayed(const Duration(seconds: 2), () {
      var phoneNumber = AgentPreference.getSavedPhoneNumber();
      var password = AgentPreference.getSavedPassword();

      if (phoneNumber != null && password != null) {
        widget.agentController.loginPhoneNumber.text = phoneNumber;
        widget.agentController.loginPassword.text = password;
        ref.watch(savePasswordProvider.notifier).state = true;
      } else {
        '';
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
                  // const BackIcon(),
                  const SizedBox(height: 38),
                  Text('Welcome back',
                      style: AppStyleGilroy.kFontW6.copyWith(fontSize: 31.62)),
                  const SizedBox(height: 10),
                  Text(
                      'Login on smart supply as agent to access our suite of service.',
                      style: AppStyleGilroy.kFontW5.copyWith(fontSize: 12)),
                  const SizedBox(height: 61),
                  AbilityPhoneNumber(
                    phoneController: widget.agentController.loginPhoneNumber,
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
                              child: Image.asset(
                                'assets/icons/flag.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.98, top: 3),
                            child: Text(
                              '+234',
                              style: AppStyleGilroy.kFontW5
                                  .copyWith(fontSize: 14, color: kBlack2),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // final code = await countryPicker.showPicker(
                              //     context: context);
                              // setState(() {
                              //   _countryCode = code;
                              //   // updateMaxLength();
                              // });
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
                    controller: widget.agentController.loginPassword,
                    heading: 'Pin',
                    hintText: 'Enter 6-digit pin',
                    maxLength: 6,
                    keyboardType: TextInputType.number,
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

                                    if (value == true) {
                                      print("Beneficiary is saved");
                                    } else {
                                      print("Beneficiary is not saved");
                                    }
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
                              page: AgentPinReset(
                                  ValidationHelper(), AgentController()));
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
                        await ref.read(loadingAgentLogin.notifier).getLoginService(
                            context: context,
                            phoneNumber:
                                '0${widget.agentController.loginPhoneNumber.text}',
                            pin: widget.agentController.loginPassword.text);
                      }
                      if (ref.watch(savePasswordProvider)) {
                        await AgentPreference.setSavedPhoneNumber(widget
                            .agentController.loginPhoneNumber.text
                            .trim());
                        await AgentPreference.setSavedPassword(
                            widget.agentController.loginPassword.text);
                      } else {
                        AgentPreference.clearLoginCredentials();
                      }
                      // print(AgentPreference.getPhoneNumber());
                    },
                    borderColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAgentLogin)
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
                  const SizedBox(height: 30),
                  Center(
                    child: Text('or',
                        style: AppStyleGilroy.kFontW4.copyWith(fontSize: 16)),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      // Call userFingerPrintAuth and provide the callback function
                      userFingerPrintAuth(
                        context: context,
                        proceedAuth: onAuthenticationSuccess,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Use fingerprint ",
                          style: AppStyleRoboto.kFontW4
                              .copyWith(fontSize: 14, color: kGrey2),
                        ),
                        const Icon(Icons.fingerprint_outlined, color: kPrimary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppStyleRoboto.kFontW4
                            .copyWith(fontSize: 16, color: kGrey2),
                      ),
                      InkWell(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const LandingPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: AppStyleRoboto.kFontW5
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      ),
                    ],
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
