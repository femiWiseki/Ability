import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AbilityButton(
                  title: 'Logout',
                  onPressed: () {
                    AgentPreference.clearAccessToken().then((value) {
                      PageNavigator(ctx: context).nextPageOnly(
                          page: AgentLoginScreen(
                              ValidationHelper(), AgentController()));
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
