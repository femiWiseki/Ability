// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgentOTPService extends StateNotifier<bool> {
  AgentOTPService() : super(false);

  Future<void> agentOTPService({
    required BuildContext context,
    required String otp,
  }) async {
    try {
      state = true;

      final agentPhoneNumber = AgentPreference.getPhoneNumber();

      String serviceUrl = kVerifyAgenttUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody =
          jsonEncode({"phoneNumber": agentPhoneNumber, "otp": otp});

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // successMessage(context: context, message: result["message"]);
        // print(result);

        // Routing
        agentSignupBottomSheet(context);

        // navigatorKey.currentState!.push(CupertinoPageRoute(
        //     builder: (context) => AgOTP(ValidationHelper())));

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
