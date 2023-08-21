// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/show_alert_dialog.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/refactored_widgets/isloading_dialog.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtSupplySmartService extends StateNotifier<bool> {
  AgtSupplySmartService() : super(false);

  supplySmartService({
    required BuildContext context,
    required int amount,
    required String accNumber,
  }) async {
    try {
      state = true;
      isLoadingDialog(context);

      String serviceUrl = kSupplySmartTransferUrl;
      var token = AgentPreference.getPhoneToken();
      final indexNumber = StateProvider<int>((ref) => 1);

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody =
          jsonEncode({"amount": amount, "phoneNumber": accNumber});

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);
      print(response.statusCode);
      print(response.body);
      print(requestBody);
      Navigator.pop(context);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        // print(result);

        generalSuccessfullDialog(
            context: context,
            description:
                'Congratulations your transfer was successful completed',
            onTap: () {
              PageNavigator(ctx: context).nextPageOnly(
                  page: AgtBottomNavBar(indexProvider: indexNumber));
            });

        state = false;
        // return AgtTransferMoneyModel.fromJson(result);
        // Check if the request is unauthorized
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

        final refreshedResponse = await http.post(Uri.parse(serviceUrl),
            body: requestBody, headers: refreshedHeader);
        print(refreshedResponse.statusCode);
        print(refreshedResponse.body);
        if (refreshedResponse.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(refreshedResponse.body);

          generalSuccessfullDialog(
              context: context,
              description:
                  'Congratulations your transfer was successful completed',
              onTap: () {
                PageNavigator(ctx: context).nextPageOnly(
                    page: AgtBottomNavBar(indexProvider: indexNumber));
              });
          state = false;
          // return AgtTransferMoneyModel.fromJson(result);
        } else {
          final result = jsonDecode(refreshedResponse.body);
          errorMessage(context: context, message: result['message']);
          print(result['message']);
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
