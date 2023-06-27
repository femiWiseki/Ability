import 'dart:convert';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:http/http.dart' as http;

refreshTokenService() async {
  try {
    String refreshUrl = kRefreshTokenUrl;
    var refreshToken = AgentPreference.getRefreshToken();
    final Map<String, String> refreshHeader = {'x-header': '$refreshToken'};

    final refreshResponse =
        await http.post(Uri.parse(refreshUrl), headers: refreshHeader);

    if (refreshResponse.statusCode == 200) {
      final String refreshedToken =
          jsonDecode(refreshResponse.body)['data']['token'];
      print(refreshedToken);
      await AgentPreference.setRefreshedToken(refreshedToken);
    } else {
      print('Something went wrong.');
    }
  } catch (e) {
    print(e.toString());
  }
}
