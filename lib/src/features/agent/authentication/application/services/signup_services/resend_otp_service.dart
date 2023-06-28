// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgentResendOTPService extends StateNotifier<bool> {
  AgentResendOTPService() : super(false);

  Future<void> resendOTPService({
    required BuildContext context,
  }) async {
    try {
      state = true;

      final agentEmail = AgentPreference.getEmail();

      String serviceUrl = kResendOTPAgentUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };

      final String requestBody = jsonEncode({"email": agentEmail});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        successMessage(context: context, message: result["data"]["msg"]);
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

class AggregatorResendOTPService extends StateNotifier<bool> {
  AggregatorResendOTPService() : super(false);

  Future<void> resendOTPService({
    required BuildContext context,
  }) async {
    try {
      state = true;

      final aggregatorEmail = AgentPreference.getEmail();

      String serviceUrl = kResendOTPAggregatorUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode({"email": aggregatorEmail});
      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        successMessage(context: context, message: result["data"]["msg"]);
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
