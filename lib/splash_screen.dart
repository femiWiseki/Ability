import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
              const SizedBox(height: 15),
              AbilityButton(
                buttonColor: kTransparent,
                borderColor: kWhite,
                titleColor: kWhite,
                title: 'Login Account',
                onPressed: () {},
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
