// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AggResolveAccNumService extends StateNotifier<bool> {
  AggResolveAccNumService() : super(false);

  resolveAccNumService(
      {required BuildContext context,
      required String bankName,
      required String accountNumber,
      void Function()? nextScreen}) async {
    try {
      state = true;

      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kAggResolveAccountNumUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody =
          jsonEncode({"account_number": accountNumber, "bankName": bankName});

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Save details
        await AggregatorPreference.setAccountName(
            result['data']['data']['account_name']);

        // Navigate to the next screen
        nextScreen!.call();

        state = false;
      } else if (response.statusCode == 401) {
        // Check if the request is unauthorized
        String refreshUrl = kAggRefreshTokenUrl;

        var refreshToken = AggregatorPreference.getAggRefreshToken();

        final Map<String, String> refreshHeader = {
          'Cookie': 'refreshToken=$refreshToken',
        };

        final refreshResponse =
            await http.post(Uri.parse(refreshUrl), headers: refreshHeader);

        final String refreshedToken =
            jsonDecode(refreshResponse.body)['data']['token'];

        final Map<String, String> refreshedHeader = {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse = await http.post(Uri.parse(serviceUrl),
            body: requestBody, headers: refreshedHeader);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);

          // Save details
          await AggregatorPreference.setAccountName(
              result['data']['data']['account_name']);

          // Navigate to the next screen
          nextScreen!.call();

          state = false;
        } else {
          final result = jsonDecode(response.body);
          errorMessage(context: context, message: result['message']);
          state = false;
        }
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
      if (kDebugMode) {
        print(e.toString());
      }
      state = false;
    }
  }
}
