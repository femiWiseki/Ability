// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtEnrollFingerPTService extends StateNotifier<bool> {
  AgtEnrollFingerPTService() : super(false);

  enrollFingerPrint(BuildContext context) async {
    try {
      state = true;
      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kEnrollFingerPrintUrl;

      final Map<String, String> serviceHeader = {
        'Authorization': 'Bearer $token'
      };

      final response =
          await http.post(Uri.parse(serviceUrl), headers: serviceHeader);
      print(response.statusCode);
      print(response.body);
      print(serviceUrl);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        print(result);

        await AgentPreference.setFingerBiometrics(
            result['isBiometricRegistered']);

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
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse =
            await http.post(Uri.parse(serviceUrl), headers: refreshedHeader);

        print(refreshedResponse.statusCode);
        print(refreshedResponse.body);
        print(serviceUrl);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body)['data'];
          print(result);

          await AgentPreference.setFingerBiometrics(
              result['isBiometricRegistered']);

          state = false;
        } else {
          final result = jsonDecode(response.body);
          errorMessage(context: context, message: result['message']);
          print(result);
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
    } catch (e) {
      print(e.toString());
      state = false;
    }
  }
}
