import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agent/agent_passcode_screen.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/aggregator_login_screen.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/aggregator_passcode_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void agentSignupBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
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
                        ref.watch(isAgentServiceProvider)
                            ? PageNavigator(ctx: context).nextPageRep(
                                page: AgentPasscodeScreen(
                                    ValidationHelper(), AgentController()))
                            : PageNavigator(ctx: context).nextPageRep(
                                page: AggregatorPasscodeScreen(
                                    ValidationHelper(),
                                    AggregatorController()));
                      },
                      borderColor: ref.watch(isEditingProvider)
                          ? kPrimary.withOpacity(0.5)
                          : kPrimary,
                      buttonColor: ref.watch(isEditingProvider)
                          ? kPrimary.withOpacity(0.5)
                          : kPrimary,
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
                        ref.watch(isAgentServiceProvider)
                            ? PageNavigator(ctx: context).nextPageOnly(
                                page: AgentLoginScreen(
                                    ValidationHelper(), AgentController()))
                            : PageNavigator(ctx: context).nextPageOnly(
                                page: AggregatorLoginScreen(ValidationHelper(),
                                    AggregatorController()));
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
