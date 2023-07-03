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

class AgtResetNewPasscodeService extends StateNotifier<bool> {
  AgtResetNewPasscodeService() : super(false);

  Future<void> newPasscodeService(
      {required BuildContext context, required String newPasscode}) async {
    try {
      state = true;

      String serviceUrl = kPasscodeAgentUrl;
      final token = AgentPreference.getPhoneToken();
      final indexNumber = StateProvider<int>((ref) => 3);
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody = jsonEncode({"passcode": newPasscode});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // successMessage(context: context, message: result["data"]["msg"]);
        print(result);

        // Routing
        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) => AgtBottomNavBar(indexProvider: indexNumber)));
        state = false;
      } else if (response.statusCode == 401) {
        String refreshUrl = kRefreshTokenUrl;
        var refreshToken = AgentPreference.getRefreshToken();
        final Map<String, String> refreshHeader = {'x-header': '$refreshToken'};

        final refreshResponse =
            await http.post(Uri.parse(refreshUrl), headers: refreshHeader);

        final String refreshedToken =
            jsonDecode(refreshResponse.body)['data']['token'];
        // print(refreshedToken);

        final Map<String, String> refreshedHeader = {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse = await http.put(Uri.parse(serviceUrl),
            body: requestBody, headers: refreshedHeader);

        if (refreshedResponse.statusCode == 200) {
          // print(jsonDecode(refreshedResponse.body));

          // Routing
          navigatorKey.currentState!.push(CupertinoPageRoute(
              builder: (context) =>
                  AgtBottomNavBar(indexProvider: indexNumber)));

          state = false;
        } else {
          final result = jsonDecode(response.body);
          errorMessage(context: context, message: result['message']);
          state = false;
        }
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
