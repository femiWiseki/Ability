import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/signup_option.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 347, 25, 0.0),
          child: Column(
            children: [
              Text('Enjoy Unlimited\nPayments',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW6
                      .copyWith(color: kWhite, fontSize: 31.62)),
              const SizedBox(height: 37),
              AbilityButton(
                buttonColor: kWhite,
                borderColor: kWhite,
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
