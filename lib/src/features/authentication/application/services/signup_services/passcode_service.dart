// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/agent/agent_login_screen.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgentPasscodeService extends StateNotifier<bool> {
  AgentPasscodeService() : super(false);

  Future<void> getPasscodeService({
    required BuildContext context,
    required String passcode,
  }) async {
    try {
      state = true;

      final token = AgentPreference.getAccessToken();

      String serviceUrl = kPasscodeAgentUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final String requestBody = jsonEncode({"passcode": passcode});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        successMessage(context: context, message: 'Passcode set successfully');
        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) =>
                AgentLoginScreen(ValidationHelper(), AgentController())));

        state = false;
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        state = false;
      }
    } on SocketException {
      errorMessage(
          context: context, message: 'There is no internet connection.');
      state = false;
    } catch (e) {
      print(e.toString());
      state = false;
    }
  }
}

///
class AggregatorPasscodeService extends StateNotifier<bool> {
  AggregatorPasscodeService() : super(false);

  Future<void> getPasscodeService({
    required BuildContext context,
    required String passcode,
  }) async {
    try {
      state = true;

      final token = AggregatorPreference.getAccessToken();

      String serviceUrl = kPasscodeAggregatorUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final String requestBody = jsonEncode({"passcode": passcode});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      print(response.statusCode);
      print(response.body);
      print(passcode);
      print(token);
      if (response.statusCode == 200) {
        successMessage(context: context, message: 'Passcode set successfully');

        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) => AggregatorLoginScreen(
                ValidationHelper(), AggregatorController())));

        state = false;
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        state = false;
      }
    } on SocketException {
      errorMessage(
          context: context, message: 'There is no internet connection.');
      state = false;
    } catch (e) {
      print(e.toString());
      state = false;
    }
  }
}
