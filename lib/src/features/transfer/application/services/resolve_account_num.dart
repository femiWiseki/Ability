// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/authentication/presentation/widgets/aggregator/aggregator_input_new_pin.dart';
import 'package:ability/src/features/transfer/domain/models/resolve_acc_num_model.dart';
import 'package:ability/src/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/transfer/presentation/widgets/agt_transfer/agt_transfer_tobank2.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
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

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);

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

class AggregatorPinResetService extends StateNotifier<bool> {
  AggregatorPinResetService() : super(false);

  Future<void> pinResetService({
    required BuildContext context,
    required String email,
  }) async {
    try {
      state = true;
      String serviceUrl = kPinResetAggregatorUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode({"email": email});
      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        successMessage(context: context, message: result['message']);

        // Routing
        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) => AggregatorInputNewPin(
                ValidationHelper(), AggregatorController())));
        state = false;
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
      print(e.toString());
      state = false;
    }
  }
}
