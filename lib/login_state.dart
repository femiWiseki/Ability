// ignore_for_file: use_build_context_synchronously

import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_passcode_login.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_passcode_screen.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_login_screen.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_passcode_login.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_passcode_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class LoginState extends ConsumerStatefulWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends ConsumerState<LoginState> {
  int? initLoginScreen;

  @override
  void initState() {
    _checkLoginState();
    super.initState();
  }

  void _checkLoginState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    if (AgentPreference.getAccessToken() == null ||
        AggregatorPreference.getAccessToken() == null) {
      ref.watch(isAgentServiceProvider)
          ? PageNavigator(ctx: context).nextPageRep(
              page: AgentLoginScreen(ValidationHelper(), AgentController()),
            )
          : PageNavigator(ctx: context).nextPageRep(
              page: AggregatorLoginScreen(
                  ValidationHelper(), AggregatorController()),
            );
    } else {
      ref.watch(isAgentServiceProvider)
          ? PageNavigator(ctx: context).nextPageRep(
              page: AgentPasscodeLogin(ValidationHelper(), AgentController()),
            )
          : PageNavigator(ctx: context).nextPageRep(
              page: AggregatorPasscodeLogin(
                  ValidationHelper(), AggregatorController()),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kWhite,
      ),
    );
  }
}
