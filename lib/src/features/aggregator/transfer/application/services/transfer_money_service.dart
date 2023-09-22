// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/agg_bottom_nav_bar.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/refactored_widgets/show_alert_dialog.dart';
import 'package:ability/src/features/aggregator/transfer/domain/models/resolve_acc_num_model.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AggTransferMoneyService extends StateNotifier<bool> {
  AggTransferMoneyService() : super(false);

  resolveAccNumService({
    required BuildContext context,
    required String passcode,
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String amount,
    required String description,
  }) async {
    try {
      state = true;

      var token = AgentPreference.getPhoneToken();
      final indexNumber = StateProvider<int>((ref) => 1);
      String serviceUrl = kAggMakeTransferUrl;

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
                  page: AggBottomNavBar(indexProvider: indexNumber));
            });

        state = false;
        return ResolveAccNumModel.fromJson(result);
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

        print(refreshedResponse.statusCode);
        print(refreshedResponse.body);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);

          // Navigate to the next screen
          generalSuccessfullDialog(
              context: context,
              description:
                  'Congratulations your transfer was successful completed',
              onTap: () {
                PageNavigator(ctx: context).nextPageOnly(
                    page: AggBottomNavBar(indexProvider: indexNumber));
              });

          state = false;
        } else {
          final result = jsonDecode(refreshedResponse.body);
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
