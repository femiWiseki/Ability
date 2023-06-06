import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void agentSignupBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 378,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 62.81, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 141,
                    height: 136.49,
                    child: Image.asset('assets/icons/successLogo.png')),
                const SizedBox(height: 23.93),
                Text(
                  'Successful!',
                  style: AppStyleGilroy.kFontW8
                      .copyWith(fontSize: 16, color: kPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your account is successfully created continue to\ndashboard  ',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW5
                      .copyWith(fontSize: 14, color: kGrey2),
                ),
                const SizedBox(height: 12.58),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      onPressed: () {
                        PageNavigator(ctx: context).nextPageRep(
                            page: AgentLoginScreen(
                                ValidationHelper(), AgentController()));
                      },
                      borderColor: kPrimary,
                      buttonColor: kPrimary,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Rest Pin Bottom Sheet
void resetPinBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 378,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 62.81, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 141,
                    height: 136.49,
                    child: Image.asset('assets/icons/login_success.png')),
                const SizedBox(height: 23.93),
                Text(
                  'Successful!',
                  style: AppStyleGilroy.kFontW8
                      .copyWith(fontSize: 16, color: kPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your account is successfully created continue to\ndashboard  ',
                  textAlign: TextAlign.center,
                  style: AppStyleGilroy.kFontW5
                      .copyWith(fontSize: 14, color: kGrey2),
                ),
                const SizedBox(height: 12.58),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      onPressed: () {
                        // PageNavigator(ctx: context)
                        //     .nextPageRep(page: LoginScreen(ValidationHelper()));
                      },
                      borderColor: kPrimary,
                      buttonColor: kPrimary,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
