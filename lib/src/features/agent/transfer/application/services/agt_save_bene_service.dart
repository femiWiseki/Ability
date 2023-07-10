// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtSaveBeneficiaryService extends StateNotifier<bool> {
  AgtSaveBeneficiaryService() : super(false);

  saveBeneficiaryService({
    required BuildContext context,
    // required String passcode,
  }) async {
    try {
      state = true;
      String serviceUrl = kSaveBeneficiaryUrl;
      var token = AgentPreference.getPhoneToken();
      var bankName = AgentPreference.getBankName().toString();
      var accountNumber = AgentPreference.getAccountNumber();
      var accountName = AgentPreference.getAccountName();

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody = jsonEncode({
        "accountNumber": accountNumber,
        "bankName": bankName,
        "accountName": accountName
      });

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);
      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        print(result);

        state = false;
        // Check if the request is unauthorized
      } else if (response.statusCode == 401) {
        String refreshUrl = kRefreshTokenUrl;
        var refreshToken = AgentPreference.getRefreshToken();
        final Map<String, String> refreshHeader = {'x-header': '$refreshToken'};

        final refreshResponse =
            await http.post(Uri.parse(refreshUrl), headers: refreshHeader);

        final String refreshedToken =
            jsonDecode(refreshResponse.body)['data']['token'];
        print(refreshedToken);

        final Map<String, String> refreshedHeader = {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse = await http.post(Uri.parse(serviceUrl),
            body: requestBody, headers: refreshedHeader);
        print(refreshedResponse.statusCode);
        print(refreshedResponse.body);

        if (refreshedResponse.statusCode == 201) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);

          state = false;
        } else {
          final result = jsonDecode(refreshedResponse.body);
          print(result);
          // errorMessage(context: context, message: result['message']);
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
