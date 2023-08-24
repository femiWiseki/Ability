import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AgtProfileController extends StateNotifier<File> {
  AgtProfileController() : super(File(''));

  Future pickImage(ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (image == null) return;

    state = File(image.path);
  }

  final accVerificationController = TextEditingController();
}
