// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:ability/src/constants/endpoints.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AgtUploadPhotoService extends StateNotifier<bool> {
  AgtUploadPhotoService() : super(false);

  uploadPhotoService({
    required BuildContext context,
    required File photo,
  }) async {
    try {
      state = true;

      String serviceUrl = kUploadPhotoUrl;
      var token = AgentPreference.getPhoneToken();

      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse(serviceUrl));

      // Set the headers
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Token $token';

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
      // print(result.runtimeType);

      if (response.statusCode == 200) {
        final streamedResult = await response.stream.bytesToString();
        final Map<String, dynamic> decodedResult = jsonDecode(streamedResult);
        final String profilePhoto = decodedResult['data']['picture'];

        // print(profilePhoto);

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
