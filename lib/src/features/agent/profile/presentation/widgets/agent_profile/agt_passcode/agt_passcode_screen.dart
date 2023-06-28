import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_passcode/agt_change_passcode.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/passcode_item_tile.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtPasscodeScreen extends ConsumerWidget {
  const AgtPasscodeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 31.79, 24, 0),
          child: Column(
            children: [
              const AppHeader(heading: 'PASSCODE'),
              const SizedBox(height: 76.89),
              Container(
                height: 166,
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(31, 35, 31, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.7), color: kWhite),
                child: Column(
                  children: [
                    PasscodeItemTile(
                      title: 'Change Passscode',
                      onTap: () async {
                        PageNavigator(ctx: context).nextPage(
                            page: AgtChangePasscode(
                                ValidationHelper(), AgentController()));
                      },
                    ),
                    const SizedBox(height: 23),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    const SizedBox(height: 23),
                    PasscodeItemTile(
                      title: 'Reset Passcode',
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
