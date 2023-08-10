// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/features/agent/payment/domain/data_bundle_model.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:http/http.dart' as http;

class GetDataService {
  Future<DataBundleModel> getData() async {
    try {
      var token = AgentPreference.getPhoneToken();

      String serviceUrl = kGetDataUrl;

      final Map<String, String> serviceHeader = {
        'Authorization': 'Bearer $token'
      };

      final response =
          await http.get(Uri.parse(serviceUrl), headers: serviceHeader);
      print(response.statusCode);
      print(response.body);
      print(serviceUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        print(result);

        return DataBundleModel.fromJson(result);
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

        print(refreshedResponse.statusCode);
        print(refreshedResponse.body);
        print(refreshedToken);

        if (refreshedResponse.statusCode == 200 || response.statusCode == 201) {
          final result = jsonDecode(refreshedResponse.body);
          print(result);

          return DataBundleModel.fromJson(result);
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
