// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/features/transfer/presentation/widgets/agt_transfer/agt_enter_transfer_code.dart';
import 'package:ability/src/features/transfer/application/repositories/bank_list.dart';
import 'package:ability/src/features/transfer/presentation/widgets/refactored_widgets/confirm_details_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:intl/intl.dart';

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
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.transferController.agtEnterTransferDesc,
                  heading: 'Enter Description (Optional)',
                  hintText: 'Enter Description',
                  keyboardType: TextInputType.name,
                  borderRadius: BorderRadius.circular(5),
                ),
                // const SizedBox(height: 27),
                // AbilityTextField(
                //     controller: widget.transferController.agtEnterTransferCode,
                //     heading: 'Enter Passcode',
                //     hintText: 'Enter Passcode',
                //     keyboardType: TextInputType.number,
                //     maxLength: 4,
                //     borderRadius: BorderRadius.circular(5),
                //     validator: (value) =>
                //         ValidationHelper().validatePasscode(value!),
                //     onChanged: (value) async {
                //       ref.watch(isEditingProvider.notifier).state = true;
                //       if (value.isEmpty) {
                //         ref.watch(isEditingProvider.notifier).state = false;
                //       }
                //       if (value.length == 4) {
                //         FocusScope.of(context).unfocus();
                //         ref.watch(isEditingProvider.notifier).state = false;
                //       }
                //     }),
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
                        bankName: AgentPreference.getBankName().toString(),
                        accountNumber:
                            AgentPreference.getAccountNumber().toString(),
                        accountName:
                            AgentPreference.getAccountName().toString(),
                        amount:
                            widget.transferController.agtTransferAmount.text,
                        onTap: () {
                          PageNavigator(ctx: context).nextPageOnly(
                              page: AgtEnterTransferCode(
                                  ValidationHelper(), TransferController()));
                        },
                      );
                      await AgentPreference.setTransferAmount(
                          widget.transferController.agtTransferAmount.text);
                      await AgentPreference.setTransDesc(
                          widget.transferController.agtEnterTransferDesc.text);
                      // PageNavigator(ctx: context)

                      //   .nextPageOnly(page: const AggregatorProfileScreen());
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
