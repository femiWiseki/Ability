import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/back_icon.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/create_account.dart';
import 'package:ability/src/features/authentication/presentation/widgets/login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupOption extends ConsumerWidget {
  const SignupOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0.0),
          child: Column(
            children: [
              Row(
                children: const [
                  BackIcon(),
                ],
              ),
              const SizedBox(height: 136),
              Text('Choose your preferred\nServices',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW6
                      .copyWith(color: kWhite, fontSize: 29.0)),
              const SizedBox(height: 46),
              AbilityButton(
                buttonColor: kWhite,
                borderColor: kWhite,
                titleColor: kPrimary,
                title: ref.watch(isCreateAccountProvider)
                    ? 'Sign up as Agent'
                    : 'Login as Agent',
                onPressed: () {
                  ref.read(isAgentServiceProvider.notifier).state = true;
                  PageNavigator(ctx: context).nextPage(
                      page: ref.watch(isCreateAccountProvider)
                          ? CreateAccount(ValidationHelper())
                          : LoginScreen(ValidationHelper()));
                },
              ),
              const SizedBox(height: 15),
              AbilityButton(
                buttonColor: kTransparent,
                borderColor: kWhite,
                titleColor: kWhite,
                title: ref.watch(isCreateAccountProvider)
                    ? 'Sign up as Aggregator'
                    : 'Login as Aggregator',
                onPressed: () {
                  ref.read(isAgentServiceProvider.notifier).state = false;
                  PageNavigator(ctx: context).nextPage(
                      page: ref.watch(isCreateAccountProvider)
                          ? CreateAccount(ValidationHelper())
                          : LoginScreen(ValidationHelper()));
                },
              ),
              const SizedBox(height: 43),
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
