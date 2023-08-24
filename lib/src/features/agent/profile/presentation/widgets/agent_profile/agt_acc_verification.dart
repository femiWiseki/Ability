// ignore_for_file: unnecessary_null_comparison, must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/profile/presentation/controllers/profile_controllers.dart';
import 'package:ability/src/features/agent/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/verification_photo_bsheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtAccVerification extends ConsumerStatefulWidget {
  AgtProfileController profileController;
  AgtAccVerification(this.profileController, {super.key});

  @override
  ConsumerState<AgtAccVerification> createState() => _AgtAccVerificationState();
}

class _AgtAccVerificationState extends ConsumerState<AgtAccVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> docTypeList = [
    "Driver's License",
    "International Passport",
    "Permanent Voter's Card",
    "National Id (NIN)",
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppHeader(heading: 'Verification'),
                    const SizedBox(height: 68.89),
                    TextFieldContainer(
                      height: 50,
                      header: 'Document Type',
                      borderRadius: 5,
                      color: kPrimary.withOpacity(0.2),
                      onTap: () {},
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Select document type',
                            style: AppStyleGilroy.kFontW5
                                .copyWith(fontSize: 14, color: kGrey),
                          ),
                          items: docTypeList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyleRoboto.kFontW4.copyWith(
                                          fontSize: 14, color: kBlack),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    AbilityTextField(
                      controller:
                          widget.profileController.accVerificationController,
                      heading: 'Document Number',
                      hintText: 'Enter document number',
                      maxLength: 11,
                      borderRadius: BorderRadius.circular(5),
                      validator: (value) =>
                          ValidationHelper().validateTextField(value!),
                      onChanged: (value) async {
                        ref.watch(isEditingProvider.notifier).state = true;
                        if (value.isEmpty) {
                          ref.watch(isEditingProvider.notifier).state = false;
                        }
                        if (value.length == 11) {
                          FocusScope.of(context).unfocus();
                          ref.watch(isEditingProvider.notifier).state = false;
                        }
                      },
                    ),
                    const SizedBox(height: 27),
                    Text(
                      'Document Image',
                      style: AppStyleGilroy.kFontW6
                          .copyWith(fontSize: 16, color: kBlack),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () => verificationPhotoBottomSheet(context, ref),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 150,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: kPrimary.withOpacity(0.2), width: 2),
                          ),
                          child: ref.watch(imageProvider).path != ""
                              ? Image.file(
                                  ref.watch(imageProvider),
                                  fit: BoxFit.fill,
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                    Text('Select Image')
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 96),
                    AbilityButton(
                      height: 60,
                      borderRadius: 10,
                      borderColor:
                          ref.watch(imageProvider) == null ? kGrey23 : kPrimary,
                      buttonColor:
                          ref.watch(imageProvider) == null ? kGrey23 : kPrimary,
                      onPressed: () async {
                        if (selectedValue != null ||
                                widget.profileController
                                        .accVerificationController !=
                                    null
                            //     &&
                            // ref.watch(imageProvider) != null
                            ) {
                          if (ref.watch(isVerifiedProvider) == true &&
                              ref.watch(isDisabledProvider) == false) {
                            ref
                                .read(loadingAgtAccVerification.notifier)
                                .verificationService(
                                    context: context,
                                    photo: ref.watch(imageProvider),
                                    documentType: selectedValue.toString(),
                                    documentNumber: widget.profileController
                                        .accVerificationController.text);
                          } else {
                            errorMessage(
                                context: context,
                                message:
                                    'This account is not valid. Please, contact support.');
                          }
                        } else {
                          errorMessage(
                              context: context,
                              message:
                                  'None of the fields can be empty. Please, fill all the fields.');
                        }
                      },
                      child: !ref.watch(loadingAgtAccVerification)
                          ? Text(
                              'Submit Documents',
                              style: AppStyleGilroy.kFontW6
                                  .copyWith(color: kWhite, fontSize: 18),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 6,
                                color: kWhite,
                              ),
                            ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
