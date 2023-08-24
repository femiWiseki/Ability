import 'package:ability/src/common_widgets/kflutter_switch.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/fingerprint_auth.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/general_tile.dart';
import 'package:ability/src/features/agent/profile/application/services/agt_enroll_fingerprint_service.dart';
import 'package:ability/src/features/agent/profile/presentation/controllers/profile_controllers.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_acc_verification.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_account_statement.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_passcode/agt_passcode_screen.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/agt_contactus_tile.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/agt_profile_card.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/signout_alert_dialog.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/unenroll_fingerprint_dialog.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtProfileScreen extends ConsumerWidget {
  const AgtProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onAuthenticationSuccess() {
      // Place your post-authentication logic here
      if (ref.read(fingerBiometricsProvider.notifier).state == true) {
        AgtEnrollFingerPTService().enrollFingerPrint(context);
        successMessage(
            context: context,
            message: 'Biometrics for Password activated successfully');
      } else {
        errorMessage(
            context: context,
            message: 'Biometrics not enabled, try again later');
      }
    }

    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 19, 24, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Profile',
                style: AppStyleGilroy.kFontW6.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 16.91),
              const AgtProfileCard(), // Create for Agent too
              const SizedBox(height: 20),
              const AgtContactUsTile(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 26, left: 10),
                            child: Text(
                              'Account',
                              style: AppStyleGilroy.kFontW6.copyWith(
                                  fontSize: 16,
                                  color: kBlack2.withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/verification.svg',
                            title: 'Verification',
                            onTap: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: AgtAccVerification(
                                      AgtProfileController()));
                            },
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/account_limits.svg',
                            title: 'Account Limits',
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/agents.svg',
                            title: 'Agents',
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath:
                                'assets/icons/account_statement.svg',
                            title: 'Account Statement',
                            onTap: () {
                              PageNavigator(ctx: context)
                                  .nextPage(page: const AgtAccountStatement());
                            },
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/hide_balance.svg',
                            title: 'Hide Balance',
                            suffixIcons: KFlutterSwitch(
                              value: ref.watch(hideCurrentBalance),
                              onToggle: (value) {
                                ref.read(hideCurrentBalance.notifier).state =
                                    value;
                              },
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      height: 190,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 26, left: 10),
                            child: Text(
                              'Security',
                              style: AppStyleGilroy.kFontW6.copyWith(
                                  fontSize: 16,
                                  color: kBlack2.withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/passcode.svg',
                            title: 'Passcode',
                            onTap: () {
                              PageNavigator(ctx: context)
                                  .nextPage(page: const AgtPasscodeScreen());
                            },
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/biometrics.svg',
                            title: 'Biometrics',
                            suffixIcons: KFlutterSwitch(
                              value: ref.watch(fingerBiometricsProvider),
                              onToggle: (value) {
                                if (value) {
                                  userFingerPrintAuth(
                                      context: context,
                                      proceedAuth: onAuthenticationSuccess);
                                  ref
                                      .read(fingerBiometricsProvider.notifier)
                                      .state = value;
                                  AgentPreference.setFingerBiometrics(value);
                                } else {
                                  unenrollFingerPTDialog(
                                    context: context,
                                    unenrollFinger: () {
                                      AgtEnrollFingerPTService()
                                          .enrollFingerPrint(context);
                                      successMessage(
                                          context: context,
                                          message:
                                              'Biometrics disable successfully');
                                      ref
                                          .read(
                                              fingerBiometricsProvider.notifier)
                                          .state = value;
                                      AgentPreference.setFingerBiometrics(
                                          value);
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                              },
                            ),
                            onTap: () {
                              print(AgentPreference.getFingerBiometrics());
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      height: 240,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 26, left: 10),
                            child: Text(
                              'About Us',
                              style: AppStyleGilroy.kFontW6.copyWith(
                                  fontSize: 16,
                                  color: kBlack2.withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/faq.svg',
                            title: 'FAQ',
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/website.svg',
                            title: 'Website',
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/twitter.svg',
                            title: 'Twitter',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      height: 240,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 26, left: 10),
                            child: Text(
                              'Legal',
                              style: AppStyleGilroy.kFontW6.copyWith(
                                  fontSize: 16,
                                  color: kBlack2.withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/privacy_policy.svg',
                            title: 'Privacy Policy',
                            suffixIcons: SvgPicture.asset(
                                'assets/icons/send_privacy_policy.svg'),
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/terms_conditions.svg',
                            title: 'Terms and Condition',
                            suffixIcons: SvgPicture.asset(
                                'assets/icons/send_privacy_policy.svg'),
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/delete_account.svg',
                            title: 'Sign out',
                            textStyle: AppStyleGilroy.kFontW5
                                .copyWith(fontSize: 15, color: customColor2),
                            onTap: () {
                              signoutAlertDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
