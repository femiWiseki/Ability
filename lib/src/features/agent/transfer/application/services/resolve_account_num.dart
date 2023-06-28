// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/transfer/domain/models/resolve_acc_num_model.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_transfer/agt_transfer_tobank2.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtResolveAccNumService extends StateNotifier<bool> {
  AgtResolveAccNumService() : super(false);

  resolveAccNumService({
    required BuildContext context,
    required String bankName,
    required String accountNumber,
  }) async {
    try {
      state = true;

      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kResolveAccountNumberUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final String requestBody =
          jsonEncode({"account_number": accountNumber, "bankName": bankName});

      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // print(result);

        // Save details
        await AgentPreference.setAccountName(
            result['data']['data']['account_name']);

        PageNavigator(ctx: context)
            .nextPage(page: AgtTransferToBank2(TransferController()));

        state = false;
        return ResolveAccNumModel.fromJson(result);
      } else if (response.statusCode == 401) {
        // Check if the request is unauthorized
        print('Just testing');
        String refreshUrl = kRefreshTokenUrl;
        var refreshToken = AgentPreference.getRefreshToken();
        final Map<String, String> refreshHeader = {'x-header': '$refreshToken'};

        final refreshResponse =
            await http.post(Uri.parse(refreshUrl), headers: refreshHeader);
        // print(refreshResponse.body);
        // print(refreshResponse.statusCode);

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
        print(requestBody);
        print(serviceUrl);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(response.body);
          // print(result);

          // Save details
          await AgentPreference.setAccountName(
              result['data']['data']['account_name']);

          PageNavigator(ctx: context)
              .nextPage(page: AgtTransferToBank2(TransferController()));
          state = false;
          return ResolveAccNumModel.fromJson(result);
        } else {
          final result = jsonDecode(response.body);
          errorMessage(context: context, message: result['message']);
          // print('SecondRequest: $result');
          state = false;
        }
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        print('initialRequest: $result');
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
