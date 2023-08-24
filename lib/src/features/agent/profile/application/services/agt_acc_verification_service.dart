// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtAccVerificationService extends StateNotifier<bool> {
  AgtAccVerificationService() : super(false);

  verificationService({
    required BuildContext context,
    required File photo,
    required String documentType,
    required String documentNumber,
  }) async {
    try {
      state = true;

      String serviceUrl = kAgtAccVerificationUrl;
      var token = AgentPreference.getPhoneToken();
      final indexNumber = StateProvider((ref) => 3);

      // // Store the request body as a JSON string
      // var requestBody = jsonEncode(
      //     {'documentType': documentType, 'documentNumber': documentNumber});

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(serviceUrl));

      // Set the headers
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Token $token';

      // Add form fields (request body JSON) to the request
      request.fields['documentType'] = documentType;
      request.fields['documentNumber'] = documentNumber;

      // Add Image file to the request
      var imageStream = http.ByteStream(photo.openRead());
      var imageLength = await photo.length();
      var multiFile = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: photo.path.split('/').last,
      );
      request.files.add(multiFile);

      // Send the request and get response
      var response = await request.send();
      // var responseBody = await response.stream.toBytes();
      // var result = String.fromCharCodes(responseBody);

      print(response.statusCode);
      // print(result);
      // print(requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final streamedResult = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(streamedResult);
        print(result);

        successMessage(context: context, message: result['message']);
        PageNavigator(ctx: context)
            .nextPage(page: AgtBottomNavBar(indexProvider: indexNumber));

        state = false;
      } else {
        final streamedResult = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(streamedResult);

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
