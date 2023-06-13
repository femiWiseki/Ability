// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/home/presentation/widgets/home_screen.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgentLoginService extends StateNotifier<bool> {
  AgentLoginService() : super(false);

  Future<void> getLoginService({
    required BuildContext context,
    // required String email,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      state = true;
      String serviceUrl = kLoginAgentUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode({
        // "email": email,
        "phoneNumber": phoneNumber,
        "pin": pin,
      });

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        // Routing
        navigatorKey.currentState!
            .push(CupertinoPageRoute(builder: (context) => const HomeScreen()));

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

class AggregatorLoginService extends StateNotifier<bool> {
  AggregatorLoginService() : super(false);

  Future<void> getLoginService({
    required BuildContext context,
    // required String email,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      state = true;
      String serviceUrl = kLoginAggregatorUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode({
        // "email": email,
        "phoneNumber": phoneNumber,
        "pin": pin,
      });
      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);
      print(phoneNumber);
      print(pin);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        // Routing
        navigatorKey.currentState!
            .push(CupertinoPageRoute(builder: (context) => const HomeScreen()));

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
