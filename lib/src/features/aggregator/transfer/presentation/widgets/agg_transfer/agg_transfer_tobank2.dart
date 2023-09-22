// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/aggregator/transfer/application/repositories/bank_list.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/widgets/agg_transfer/agt_enter_transfer_code.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/widgets/refactored_widgets/confirm_details_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggTransferToBank2 extends ConsumerStatefulWidget {
  TransferController transferController;
  final String bankName;
  final String accountNum;
  AggTransferToBank2(this.transferController,
      {required this.bankName, required this.accountNum, super.key});

  @override
  ConsumerState<AggTransferToBank2> createState() => _AggTransferToBank2State();
}

class _AggTransferToBank2State extends ConsumerState<AggTransferToBank2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedBankName;

  BankListRepo bankListRepo = BankListRepo();

  @override
  Widget build(BuildContext context) {
    // final bankDetails = ref.watch(getBankDetailsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const AppHeader(heading: 'Transfer to Bank'),
                const SizedBox(height: 68.89),
                AbilityTextField(
                  controller: widget.transferController.aggTrasferAccountNumber,
                  heading: 'Account Name',
                  hintText: '${AggregatorPreference.getAccountName()}',
                  readOnly: true,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.transferController.aggTransferAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 27),
                GeneralTextField(
                  controller: widget.transferController.aggEnterTransferDesc,
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
                      confirmDetailsDialog(
                        context: context,
                        bankName: widget.bankName,
                        accountNumber: widget.accountNum,
                        accountName:
                            AggregatorPreference.getAccountName().toString(),
                        amount:
                            widget.transferController.aggTransferAmount.text,
                        onTap: () {
                          final desc = widget
                              .transferController.aggEnterTransferDesc.text;
                          PageNavigator(ctx: context).nextPage(
                              page: AggEnterTransferCode(
                                  accountName:
                                      AggregatorPreference.getAccountName() ??
                                          '',
                                  accountNum: widget.accountNum,
                                  amount: widget.transferController
                                      .aggTransferAmount.text,
                                  bankName: widget.bankName,
                                  description: desc.isEmpty
                                      ? 'Transfer from ${AggregatorPreference.getUserName()}'
                                      : desc,
                                  ValidationHelper(),
                                  TransferController()));
                        },
                      );
                    }
                  },
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
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
