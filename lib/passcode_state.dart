// ignore_for_file: use_build_context_synchronously

import 'package:ability/login_state.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agent/agent_passcode_screen.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/aggregator_passcode_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class PasscodeState extends ConsumerStatefulWidget {
  const PasscodeState({Key? key}) : super(key: key);

  @override
  ConsumerState<PasscodeState> createState() => _PasscodeStateState();
}

class _PasscodeStateState extends ConsumerState<PasscodeState> {
  // LoginService loginService = LoginService();

  @override
  void initState() {
    _checkPasscodeState();
    super.initState();
  }

  void _checkPasscodeState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    if (AgentPreference.getPasscodeStatus() == null ||
        AggregatorPreference.getPasscodeStatus() == null) {
      ref.watch(isAgentServiceProvider)
          ? PageNavigator(ctx: context).nextPageOnly(
              page: AgentPasscodeScreen(ValidationHelper(), AgentController()),
            )
          : PageNavigator(ctx: context).nextPageOnly(
              page: AggregatorPasscodeScreen(
                  ValidationHelper(), AggregatorController()),
            );
    } else {
      PageNavigator(ctx: context).nextPageOnly(page: const LoginState());
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
