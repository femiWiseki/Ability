// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/refactored_widgets/agent_signup_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AggregatorInputNewPinService extends StateNotifier<bool> {
  AggregatorInputNewPinService() : super(false);

  Future<void> inputNewPinService({
    required BuildContext context,
    required String otpCode,
    required String newPin,
    required String confirmPin,
  }) async {
    try {
      state = true;
      String serviceUrl = kInputNewPinAggregatorUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode(
          {"newPin": newPin, "confirmPin": newPin, "resetOtp": otpCode});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      print(otpCode);
      print(response.statusCode);
      print(requestBody);
      print(response.body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);
        resetPinBottomSheet(context);

        state = false;
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
