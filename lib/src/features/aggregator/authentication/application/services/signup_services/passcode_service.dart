// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/aggregator_login_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AggregatorPasscodeService extends StateNotifier<bool> {
  AggregatorPasscodeService() : super(false);

  Future<void> getPasscodeService({
    required BuildContext context,
    required String passcode,
  }) async {
    try {
      state = true;

      final token = AggregatorPreference.getAccessToken();

      String serviceUrl = kPasscodeAggregatorUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ZDBlM2QyMmZlZjk3MGM5NTczNmRiOSIsInBob25lTnVtYmVyIjoiMDgwMzQ0MzUxMjMiLCJlbWFpbCI6ImRhbW9sYUBzdXBwbHlzbWFydC5jbyIsImlhdCI6MTY5NDU4Njc3MiwiZXhwIjoxNjk0NTg3MDcyfQ.xL4ja4nioyB8bCr24-3dd8gBZ61ap--cb5IYDms5zhE'
      };
      final String requestBody = jsonEncode({"passcode": passcode});

      final response = await http.put(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      print(response.statusCode);
      print(response.body);
      print(passcode);
      print(token);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        //Save Agent Passcode Status
        await AggregatorPreference.setPasscodeStatus(result['status']);
        successMessage(context: context, message: 'Passcode set successfully');

        navigatorKey.currentState!.push(CupertinoPageRoute(
            builder: (context) => AggregatorLoginScreen(
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
