// ignore_for_file: must_be_immutable

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaiseDisputeDialog extends ConsumerStatefulWidget {
  ValidationHelper valHelper;
  final VoidCallback sendDispute;
  final TextEditingController disputeController;

  RaiseDisputeDialog(this.valHelper,
      {required this.disputeController, required this.sendDispute, super.key});

  @override
  ConsumerState<RaiseDisputeDialog> createState() => _RaiseDisputeDialogState();
}

class _RaiseDisputeDialogState extends ConsumerState<RaiseDisputeDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: Text(
          'Raise Dispute',
          style: AppStyleGilroy.kFontW8,
        ),
      ),
      content: SizedBox(
        height: 150,
        child: Form(
          key: formKey,
          child: TextFormField(
            controller: widget.disputeController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            onChanged: (value) {
              ref.read(disputeProvider.notifier).state =
                  widget.disputeController.text;
            },
            decoration: InputDecoration(
              fillColor: kAsh1,
              filled: true,
              hintText: 'Enter dispute...',
              hintStyle:
                  AppStyleGilroy.kFontW7.copyWith(fontSize: 14, color: kGrey2),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: Colors.transparent)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kRed, width: 0.5)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kRed, width: 0.5)),
            ),
            validator: (value) => ValidationHelper().validateTextField(value!),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style:
                AppStyleGilroy.kFontW7.copyWith(fontSize: 16, color: kPrimary),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.sendDispute.call();
              Navigator.of(context).pop(); // Close the dialog
            }
          },
          child: Text(
            'Send',
            style:
                AppStyleGilroy.kFontW7.copyWith(fontSize: 16, color: kPrimary),
          ),
        ),
      ],
    );
  }
}
