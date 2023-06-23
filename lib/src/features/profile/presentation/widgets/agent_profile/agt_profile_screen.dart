import 'package:ability/src/common_widgets/kflutter_switch.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/general_tile.dart';
import 'package:ability/src/features/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/profile/presentation/widgets/aggregator_profile/account_statement/agg_account_statement.dart';
import 'package:ability/src/features/profile/presentation/widgets/aggregator_profile/agg_refactored_widgets/agg_contactus_tile.dart';
import 'package:ability/src/features/profile/presentation/widgets/aggregator_profile/agg_refactored_widgets/agg_profile_card.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtProfileScreen extends ConsumerWidget {
  const AgtProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 19, 24, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Agent Profile',
                style: AppStyleGilroy.kFontW6.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 16.91),
              const AggProfileCard(),
              const SizedBox(height: 20),
              const AggContactUsTile(),
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
                            onTap: () {},
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
                                  .nextPage(page: const AggAccountStatement());
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
                            onTap: () {},
                          ),
                          GeneralTile(
                            prefixIconPath: 'assets/icons/biometrics.svg',
                            title: 'Biometrics',
                            suffixIcons: KFlutterSwitch(
                              value: ref.watch(onBiometrics),
                              onToggle: (value) {
                                ref.read(onBiometrics.notifier).state = value;
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
                            title: 'Delete Account',
                            textStyle: AppStyleGilroy.kFontW5
                                .copyWith(fontSize: 15, color: customColor2),
                            onTap: () {
                              AgentPreference.logoutUser().then((value) {
                                PageNavigator(ctx: context).nextPageOnly(
                                    page: AgentLoginScreen(
                                        ValidationHelper(), AgentController()));
                              });
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
