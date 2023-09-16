// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/agt_forgot_pin/agent_input_new_pin.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgentPinResetService extends StateNotifier<bool> {
  AgentPinResetService() : super(false);

  Future<void> pinResetService({
    required BuildContext context,
    required String email,
  }) async {
    try {
      state = true;

      String serviceUrl = kPinResetAgentUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };

      final String requestBody = jsonEncode({"email": email});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // successMessage(context: context, message: result["data"]["msg"]);
        print(result);
        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) =>
                AgentInputNewPin(ValidationHelper(), AgentController())));
        state = false;
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        print(result);
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
