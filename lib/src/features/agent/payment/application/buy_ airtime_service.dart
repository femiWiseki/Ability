// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

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

class BuyAirtimeService extends StateNotifier<bool> {
  BuyAirtimeService() : super(false);

  airtimeService({
    required BuildContext context,
    required String customerNum,
    required int amount,
    required String paymentType,
    required String networkProvider,
    required String passcode,
  }) async {
    try {
      state = true;
      isLoadingDialog(context);
      // var isBeneSaved = Provider((ref) => ref.watch(saveBeneficiaryProvider));
      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kBuyAirtimeUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody = jsonEncode({
        "customer": "+234$customerNum",
        "amount": amount,
        "paymentType": paymentType,
        "biller_name": networkProvider,
        "passcode": passcode
      });
      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);
      print(response.statusCode);
      print(response.body);
      // print(requestBody);
      // print(token);
      Navigator.pop(context);

      if (response.statusCode == 200 || response.statusCode == 201) {
        generalSuccessfullDialog(
          context: context,
          description: 'Congratulations your transfer was successful completed',
          onTap: () {
            final indexNumber = StateProvider<int>((ref) => 2);

            PageNavigator(ctx: context).nextPageOnly(
              page: AgtBottomNavBar(indexProvider: indexNumber),
            );
          },
        );
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
          generalSuccessfullDialog(
            context: context,
            description:
                'Congratulations your transfer was successful completed',
            onTap: () {
              final indexNumber = StateProvider<int>((ref) => 2);

              PageNavigator(ctx: context).nextPageOnly(
                page: AgtBottomNavBar(indexProvider: indexNumber),
              );
            },
          );
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
