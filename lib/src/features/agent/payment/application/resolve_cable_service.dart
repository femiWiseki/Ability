// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/cable_screens/cable_name_screen.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class ResolveCableService extends StateNotifier<bool> {
  ResolveCableService() : super(false);

  cableService({
    required BuildContext context,
    required String serviceProvider,
    required String cableNumber,
  }) async {
    try {
      state = true;
      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kResolveCableUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody = jsonEncode({
        "biller_name": serviceProvider,
        "name": serviceProvider,
        "customer": cableNumber
      });
      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);
      // print(response.statusCode);
      // print(response.body);
      // print(requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);

        final cableAccountName = result['data']['billItem']['name'];

        await AgentPreference.setCableAccountName(cableAccountName);

        // Navigate to the next screen
        PageNavigator(ctx: context).nextPage(
            page: CableNameScreen(
          AgtPaymentController(),
          cableNumber: cableNumber,
        ));

        state = false;
        // Check if the request is unauthorized
      } else if (response.statusCode == 400 || response.statusCode == 401) {
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

        final refreshedResponse = await http.post(Uri.parse(serviceUrl),
            body: requestBody, headers: refreshedHeader);

        // print('Statuscode: ${refreshedResponse.statusCode}');
        // print(refreshedResponse.body);
        // print(requestBody);

        if (refreshedResponse.statusCode == 200 ||
            refreshedResponse.statusCode == 201) {
          final result = jsonDecode(response.body);

          final cableAccountName = result['data']['billItem']['name'];

          await AgentPreference.setCableAccountName(cableAccountName);

          // Navigate to the next screen
          PageNavigator(ctx: context).nextPage(
              page: CableNameScreen(
            AgtPaymentController(),
            cableNumber: cableNumber,
          ));
          state = false;
        } else {
          final result = jsonDecode(refreshedResponse.body);
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
