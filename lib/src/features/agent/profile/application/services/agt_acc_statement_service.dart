// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AgtAccStatementService extends StateNotifier<bool> {
  AgtAccStatementService() : super(false);

  agtAccStatement() async {
    try {
      state = true;
      var token = AgentPreference.getPhoneToken();
      String serviceUrl = kAgtAccStatementUrl;

      final Map<String, String> serviceHeader = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      Future<void> openURL(Uri url) async {
        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $url');
        }
      }

      final response =
          await http.get(Uri.parse(serviceUrl), headers: serviceHeader);
      // print(response.statusCode);
      // print(response.body);
      // print(serviceUrl);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        print(result);

        if (AgentPreference.getAccStatemtFmt() == 'PDF') {
          var pdfLink = result['pdfFileUrl'];
          openURL(Uri.parse('$pdfLink'));
        } else {
          var excelLink = result['excelFileUrl'];
          openURL(Uri.parse('$excelLink'));
        }

        state = false;
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

        // print(refreshedResponse.statusCode);
        // print(refreshedResponse.body);
        // print(serviceUrl);

        if (refreshedResponse.statusCode == 200) {
          final result = jsonDecode(refreshedResponse.body)['data'];
          print(result);

          if (AgentPreference.getAccStatemtFmt() == 'PDF') {
            var pdfLink = result['pdfFileUrl'];
            openURL(Uri.parse('$pdfLink'));
          } else {
            var excelLink = result['excelFileUrl'];
            openURL(Uri.parse('$excelLink'));
          }

          state = false;
        } else {
          final result = jsonDecode(response.body);
          // errorMessage(context: context, message: result['message']);
          // print(result);
          state = false;
        }
      } else {
        final result = jsonDecode(response.body);
        // errorMessage(context: context, message: result['message']);
        // print(result);
        state = false;
      }
    } on SocketException {
      // errorMessage(
      //     context: context, message: 'There is no internet connection.');
    } catch (e) {
      print(e.toString());
      state = false;
    }
  }
}
