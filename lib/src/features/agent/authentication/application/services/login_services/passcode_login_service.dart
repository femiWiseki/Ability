// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtPasscodeLoginService extends StateNotifier<bool> {
  AgtPasscodeLoginService() : super(false);

  Future<void> passcodeLoginService({
    required BuildContext context,
    required String passcode,
  }) async {
    try {
      state = true;
      var token = AgentPreference.getPhoneToken();
      final indexNumber = StateProvider<int>((ref) => 0);
      String serviceUrl = kPasscodeLoginAgentUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final String requestBody = jsonEncode({
        "passcode": passcode,
      });

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        // Routing
        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) => AgtBottomNavBar(indexProvider: indexNumber)));

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
