import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showSessionExpiredDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          'Your session has expired',
          style: AppStyleGilroy.kFontW7.copyWith(fontSize: 20),
        ),
        content: Text(
          'Please, log in again to continue using the app.',
          style: AppStyleGilroy.kFontW5.copyWith(fontSize: 14),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                child: Text(
                  'Login',
                  style: AppStyleGilroy.kFontW8.copyWith(color: kPrimary),
                ),
                onPressed: () {
                  ref.watch(isAgentServiceProvider)
                      ? PageNavigator(ctx: context).nextPageOnly(
                          page: AgentLoginScreen(
                              ValidationHelper(), AgentController()))
                      : PageNavigator(ctx: context).nextPageOnly(
                          page: AggregatorLoginScreen(
                              ValidationHelper(), AggregatorController()));
                },
              );
            },
          ),
        ],
      );
    },
  );
}
