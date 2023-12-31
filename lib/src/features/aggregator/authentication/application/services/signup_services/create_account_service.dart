// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/globals.dart';
import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/controllers/auth_controllers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/aggregator_otp_screen.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AggregatorCreateAccountService extends StateNotifier<bool> {
  AggregatorCreateAccountService() : super(false);

  Future<void> createAccountService({
    required BuildContext context,
    required String name,
    required String email,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      state = true;
      String serviceUrl = kCreateAccountAggregatorUrl;
      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json'
      };
      final String requestBody = jsonEncode({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "pin": pin,
      });
      final response = await http.post(Uri.parse(serviceUrl),
          body: requestBody, headers: serviceHeader);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);

        //Save Agent Id and PhoneNumber
        final id = result["data"]["data"];
        await AggregatorPreference.setId(id);

        // Routing
        navigatorKey.currentState!.push(
          CupertinoPageRoute(
            builder: (context) =>
                AggregatorOTPScreen(ValidationHelper(), AggregatorController()),
          ),
        );

        state = false;
      } else {
        final result = jsonDecode(response.body);
        errorMessage(context: context, message: result['message']);
        state = false;
        print(result);
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
