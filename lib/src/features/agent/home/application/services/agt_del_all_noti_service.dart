// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/refactored_widgets/isloading_dialog.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgtDelAllNotificationsService {
  agtNotifications({
    required BuildContext context,
  }) async {
    try {
      isLoadingDialog(context);
      var token = AgentPreference.getPhoneToken();

      String serviceUrl = kDeleteAllNotiUrl;

      final Map<String, String> serviceHeader = {
        'Authorization': 'Bearer $token'
      };

      final response =
          await http.delete(Uri.parse(serviceUrl), headers: serviceHeader);
      print(response.statusCode);
      print(response.body);

      Navigator.pop(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        print(result);
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
            await http.delete(Uri.parse(serviceUrl), headers: refreshedHeader);

        if (refreshedResponse.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);
        } else {
          final result = jsonDecode(response.body);
          errorMessage(context: context, message: result['message']);
          print(result);
        }
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        print(result);
      }
    } on SocketException {
      errorMessage(
          context: context, message: 'There is no internet connection.');
    } catch (e) {
      print(e.toString());
    }
  }
}
