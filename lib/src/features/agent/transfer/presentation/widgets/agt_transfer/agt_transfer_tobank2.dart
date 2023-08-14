// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/currency_editing_controller.dart';
import 'package:ability/src/features/agent/transfer/application/repositories/bank_list.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_transfer/agt_enter_transfer_code.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/refactored_widgets/confirm_details_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferToBank2 extends ConsumerStatefulWidget {
  TransferController transferController;
  AgtTransferToBank2(this.transferController, {super.key});

  @override
  ConsumerState<AgtTransferToBank2> createState() => _AgtTransferToBank2State();
}

class _AgtTransferToBank2State extends ConsumerState<AgtTransferToBank2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedBankName;
  BankListRepo bankListRepo = BankListRepo();

  @override
  void initState() {
    super.initState();
    widget.transferController.agtTransferAmount = CurrencyEditingController(
      initialValue: 0.00,
      onValueChange: (newValue) {
        setState(() {});
      },
    );
  }

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
                  controller: widget.transferController.agtTrasferAccountNumber,
                  heading: 'Account Name',
                  hintText: '${AgentPreference.getAccountName()}',
                  readOnly: true,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.transferController.agtTransferAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 27),
                GeneralTextField(
                  controller: widget.transferController.agtEnterTransferDesc,
                  heading: 'Enter Description (Optional)',
                  hintText: 'Enter Description',
                  keyboardType: TextInputType.name,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 8),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return Row(
                      children: [
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 11,
                          height: 11,
                          child: Checkbox(
                            checkColor: kPrimary, // color of tick Mark
                            activeColor: kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 1.0, color: kPrimary.withOpacity(0.8)),
                            ),
                            value: ref.watch(saveBeneficiaryProvider),
                            onChanged: (value) {
                              ref.read(saveBeneficiaryProvider.notifier).state =
                                  !ref
                                      .read(saveBeneficiaryProvider.notifier)
                                      .state;
                              if (value == true) {
                                // AgtSaveBeneficiaryService()
                                //     .saveBeneficiaryService(context: context);

                                print("Beneficiary is saved");
                              } else {
                                print("Beneficiary is not saved");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Save as beneficiary",
                          style: AppStyleGilroy.kFontW5
                              .copyWith(color: kPrimary, fontSize: 14),
                        ),
                      ],
                    );
                  },
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
                      int parsedValue = int.parse(
                          widget.transferController.agtTransferAmount.text);
                      String transferAmount = parsedValue.toString();
                      print(transferAmount);
                      print(transferAmount.runtimeType);
                      confirmDetailsDialog(
                        context: context,
                        bankName: AgentPreference.getBankName().toString(),
                        accountNumber:
                            AgentPreference.getAccountNumber().toString(),
                        accountName:
                            AgentPreference.getAccountName().toString(),
                        amount: transferAmount,
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                              page: AgtEnterTransferCode(
                                  ValidationHelper(), TransferController()));
                        },
                      );
                      var transferDesc =
                          widget.transferController.agtEnterTransferDesc.text;

                      await AgentPreference.setTransferAmount(transferAmount);

                      await AgentPreference.setTransDesc(transferDesc.isEmpty
                          ? 'Transfer from ${AgentPreference.getUsername()}'
                          : transferDesc);
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
