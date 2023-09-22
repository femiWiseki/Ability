// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/general_pin_code.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AggEnterTransferCode extends ConsumerWidget {
  ValidationHelper validationHelper;
  TransferController transferController;
  final String bankName;
  final String accountNum;
  final String accountName;
  final String amount;
  final String description;
  AggEnterTransferCode(this.validationHelper, this.transferController,
      {required this.accountName,
      required this.accountNum,
      required this.amount,
      required this.bankName,
      required this.description,
      super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final indexNumber = StateProvider<int>((ref) => 1);
    return Scaffold(
      backgroundColor: kPrimary1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppHeader(heading: 'Transfer'),
                  const SizedBox(height: 55.11),
                  Container(
                    width: 121,
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimary.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text('Enter Passcode',
                          style: AppStyleGilroy.kFontW5
                              .copyWith(fontSize: 12, color: kPrimary)),
                    ),
                  ),
                  const SizedBox(height: 39.71),
                  Center(
                    child: GeneralPinCode(
                        pinLenght: 4,
                        boxPinShape: PinCodeFieldShape.box,
                        controller: transferController.aggEnterTransferCode,
                        onCompleted: (value) {
                          ref.watch(isEditingProvider.notifier).state = true;
                        },
                        validator: (value) =>
                            validationHelper.validatePinCode2(value!)),
                  ),
                  const SizedBox(height: 139.54),
                  AbilityButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(loadingAggBankDetail2.notifier)
                            .resolveAccNumService(
                              context: context,
                              accountName: accountName,
                              accountNumber: accountNum,
                              amount: amount,
                              bankName: bankName,
                              description: description,
                              passcode:
                                  transferController.aggEnterTransferCode.text,
                            );
                      }
                    },
                    borderColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    buttonColor:
                        !ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                    child: !ref.watch(loadingAggBankDetail2)
                        ? Text(
                            'continue',
                            style: AppStyleGilroy.kFontW6
                                .copyWith(color: kWhite, fontSize: 18),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: kWhite,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
