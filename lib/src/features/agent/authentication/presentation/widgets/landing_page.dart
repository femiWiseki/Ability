import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/signup_option.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 98.3, 25, 0.0),
          child: Column(
            children: [
              SizedBox(
                  width: 155,
                  height: 148.39,
                  child: Image.asset('assets/icons/abilityLogo.png')),
              const SizedBox(height: 100.3),
              Text('Enjoy Unlimited\nPayments',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW6
                      .copyWith(color: kWhite, fontSize: 31.62)),
              const SizedBox(height: 37),
              AbilityButton(
                buttonColor: kWhite,
                borderColor: kWhite,
                borderRadius: 30,
                titleColor: kPrimary,
                title: 'Create Account',
                onPressed: () {
                  ref.read(isCreateAccountProvider.notifier).state = true;
                  PageNavigator(ctx: context)
                      .nextPage(page: const SignupOption());
                },
              ),
              const SizedBox(height: 15),
              AbilityButton(
                buttonColor: kTransparent,
                borderColor: kWhite,
                titleColor: kWhite,
                borderRadius: 30,
                title: 'Login Account',
                onPressed: () {
                  ref.read(isCreateAccountProvider.notifier).state = false;
                  PageNavigator(ctx: context)
                      .nextPage(page: const SignupOption());
                },
              ),
              const SizedBox(height: 36),
              Text(
                  ' By continuing you agree to Abitypay terms and Privacy\nPolicy ',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW6
                      .copyWith(color: kWhite, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
