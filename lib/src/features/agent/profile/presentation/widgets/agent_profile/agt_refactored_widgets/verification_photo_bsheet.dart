// ignore_for_file: use_build_context_synchronously, unused_result

import 'dart:io';

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

void verificationPhotoBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (
      BuildContext context,
    ) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Column(
              children: [
                Text(
                  'Upload Passport',
                  style: AppStyleRoboto.kFontW7.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      height: 50,
                      borderRadius: 30,
                      onPressed: () async {
                        await ref
                            .read(imageProvider.notifier)
                            .pickImage(ImageSource.camera);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt_outlined, color: kWhite),
                          const SizedBox(width: 16),
                          Text(
                            'Upload Camera',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 14),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      height: 50,
                      borderRadius: 30,
                      buttonColor: kTransparent,
                      onPressed: () async {
                        ref
                            .read(imageProvider.notifier)
                            .pickImage(ImageSource.gallery);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.gallery, color: kPrimary),
                          const SizedBox(width: 16),
                          Text(
                            'Upload from Gallery',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kPrimary, fontSize: 14),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
