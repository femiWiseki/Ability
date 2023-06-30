// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/features/agent/home/domain/models/agt_profile_model.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:http/http.dart' as http;

class AgtProfileService {
  Future<AgtProfileModel> agtProfileService(
      // required BuildContext context,
      ) async {
    try {
      var token = AgentPreference.getPhoneToken();

      String serviceUrl = kAgtProfileUrl;

      final Map<String, String> serviceHeader = {
        'Authorization': 'Bearer $token'
      };

      final response =
          await http.get(Uri.parse(serviceUrl), headers: serviceHeader);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);

        return AgtProfileModel.fromJson(result);
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
          'Authorization': 'Bearer $refreshedToken'
        };

        final refreshedResponse =
            await http.get(Uri.parse(serviceUrl), headers: refreshedHeader);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);

          return AgtProfileModel.fromJson(result);
        } else {
          final result = jsonDecode(response.body);
          // errorMessage(context: context, message: result['message']);
          print(result);
        }
      } else {
        final result = jsonDecode(response.body);
        // errorMessage(context: context, message: result['message']);
        print(result);
      }
    } on SocketException {
      // errorMessage(
      //     context: context, message: 'There is no internet connection.');
    } catch (e) {
      print(e.toString());
    }
    throw 'Something went wrong';
  }
}
