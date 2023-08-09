// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_transfer/agt_enter_transfer_code.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/refactored_widgets/confirm_details_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferToBeneficiary2 extends ConsumerWidget {
  TransferController transferController;
  String bankName;
  String accountNumber;
  String accountName;
  AgtTransferToBeneficiary2(this.transferController,
      {required this.bankName,
      required this.accountNumber,
      required this.accountName,
      super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bankDetails = ref.watch(getBankDetailsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const AppHeader(heading: 'Transfer to Beneficiary'),
                const SizedBox(height: 68.89),
                AbilityTextField(
                  controller: transferController.agtBeneAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 27),
                GeneralTextField(
                  controller: transferController.agtBeneDescription,
                  heading: 'Enter Description (Optional)',
                  hintText: 'Enter Description',
                  keyboardType: TextInputType.name,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 96),
                AbilityButton(
                  height: 60,
                  borderRadius: 10,
                  borderColor:
                      ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                  buttonColor:
                      ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int parsedTransAmtVal =
                          int.parse(transferController.agtBeneAmount.text);
                      String transferAmount = parsedTransAmtVal.toString();
                      print(transferAmount);
                      print(transferAmount.runtimeType);
                      confirmDetailsDialog(
                        context: context,
                        bankName: bankName,
                        accountNumber: accountNumber,
                        accountName: accountName,
                        amount: transferAmount,
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                              page: AgtEnterTransferCode(
                                  ValidationHelper(), TransferController()));
                        },
                      );

                      await AgentPreference.setTransferAmount(transferAmount);
                      await AgentPreference.setTransDesc(
                          transferController.agtBeneDescription.text);
                      await AgentPreference.setAccountNumber(accountNumber);
                      await AgentPreference.setBankName(bankName);
                      await AgentPreference.setAccountName(accountName);
                    }
                  },
                  child: !ref.watch(loadingAgtBankDetail2)
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
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
