// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/features/aggregator/home/domain/models/agg_profile_model.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AggProfileService {
  Future<AggProfileModel> aggProfileService(
      // required BuildContext context,
      ) async {
    try {
      var token = AggregatorPreference.getPhoneToken();

      String serviceUrl = kAggProfileUrl;

      final Map<String, String> serviceHeader = {
        'Authorization': 'Bearer $token'
      };

      final response =
          await http.get(Uri.parse(serviceUrl), headers: serviceHeader);
      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // print(result);

        final isAggVerified = result['data']['data']['isVerified'];

        await AggregatorPreference.setIsAggVerified(isAggVerified);

        return AggProfileModel.fromJson(result);
      } else if (response.statusCode == 401) {
        String refreshUrl = kAggRefreshTokenUrl;
        var refreshToken = AggregatorPreference.getAggRefreshToken();
        final Map<String, String> refreshHeader = {
          'Cookie': 'refreshToken=$refreshToken'
        };
        // print('Refresh: $refreshToken');

        final refreshResponse =
            await http.post(Uri.parse(refreshUrl), headers: refreshHeader);

        final String refreshedToken =
            jsonDecode(refreshResponse.body)['data']['token'];
        // print(refreshResponse);
        // print('Refreshed Token: $refreshedToken');

        final Map<String, String> refreshedHeader = {
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse =
            await http.get(Uri.parse(serviceUrl), headers: refreshedHeader);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body);
          // print(result);

          final isAggVerified = result['data']['data']['isVerified'];

          await AggregatorPreference.setIsAggVerified(isAggVerified);

          return AggProfileModel.fromJson(result);
        } else {
          final result = jsonDecode(response.body);
          // errorMessage(context: context, message: result['message']);
          if (kDebugMode) {
            print(result);
          }
        }
      } else {
        final result = jsonDecode(response.body);
        // errorMessage(context: context, message: result['message']);
        if (kDebugMode) {
          print(result);
        }
      }
    } on SocketException {
      // errorMessage(
      //     context: context, message: 'There is no internet connection.');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    throw 'Something went wrong';
  }
}
