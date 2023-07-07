// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/show_alert_dialog.dart';
import 'package:ability/src/features/agent/transfer/domain/models/agt_transfer_money_model.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtTransferMoneyService extends StateNotifier<bool> {
  AgtTransferMoneyService() : super(false);

  transferMoneyService({
    required BuildContext context,
    required String passcode,
  }) async {
    try {
      state = true;

      var token = AgentPreference.getPhoneToken();
      var bankName = AgentPreference.getBankName().toString();
      var accountNumber = AgentPreference.getAccountNumber();
      var accountName = AgentPreference.getAccountName();
      var description = AgentPreference.getTransDesc();
      var amount = AgentPreference.getTransferAmount();
      final indexNumber = StateProvider<int>((ref) => 1);
      String serviceUrl = kMakeTransferUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody = jsonEncode({
        "amount": amount,
        "account_number": accountNumber,
        "narration": description,
        "bankName": bankName,
        "passcode": passcode,
        "account_name": accountName
      });

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
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
        return AgtTransferMoneyModel.fromJson(result);
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

        if (refreshedResponse.statusCode == 200) {
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
          return AgtTransferMoneyModel.fromJson(result);
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
