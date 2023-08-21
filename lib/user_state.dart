// ignore_for_file: use_build_context_synchronously

import 'package:ability/passcode_state.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/landing_page.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserState extends StatefulWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  // LoginService loginService = LoginService();

  @override
  void initState() {
    _checkUserState();
    super.initState();
  }

  void _checkUserState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    if (AgentPreference.getId() == null ||
        AggregatorPreference.getId() == null) {
      PageNavigator(ctx: context).nextPageOnly(page: const LandingPage());
    } else {
      PageNavigator(ctx: context).nextPageOnly(page: const PasscodeState());
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
