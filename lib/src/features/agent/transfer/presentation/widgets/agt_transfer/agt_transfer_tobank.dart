// ignore_for_file: unnecessary_null_comparison, must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/transfer/application/repositories/bank_list.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dropdown_button3/dropdown_button3.dart';

class AgtTransferToBank extends ConsumerStatefulWidget {
  TransferController transferController;
  AgtTransferToBank(this.transferController, {super.key});

  @override
  ConsumerState<AgtTransferToBank> createState() => _AgtTransferToBankState();
}

class _AgtTransferToBankState extends ConsumerState<AgtTransferToBank> {
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
                InkWell(
                    onTap: () {
                      // refreshTokenService();
                      print(AgentPreference.getRefreshedToken());
                    },
                    child: const AppHeader(heading: 'Transfer to Bank')),
                const SizedBox(height: 68.89),
                TextFieldContainer(
                  height: 50,
                  header: 'Choose Bank',
                  borderRadius: 5,
                  onTap: () {},
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Choose Bank',
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 14, color: kGrey),
                      ),
                      items: bankListRepo.bankDetails
                          .map((item) => DropdownMenuItem<String>(
                                value: item['name'].toString(),
                                child: Text(
                                  item['name'].toString(),
                                  style: AppStyleRoboto.kFontW4
                                      .copyWith(fontSize: 14, color: kBlack),
                                ),
                              ))
                          .toList(),
                      value: selectedBankName,
                      onChanged: (value) {
                        setState(() {
                          selectedBankName = value as String;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.transferController.agtTrasferAccountNumber,
                  heading: 'Enter Account number',
                  hintText: 'Enter Account number',
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAccountNumber(value!),
                  onChanged: (value) async {
                    ref.watch(isEditingProvider.notifier).state = true;
                    if (value.isEmpty) {
                      ref.watch(isEditingProvider.notifier).state = false;
                    }
                    if (value.length == 10) {
                      FocusScope.of(context).unfocus();
                      ref.watch(isEditingProvider.notifier).state = false;
                    }
                    // if (value.length == 10) {
                    //   await ref.read(bankDetailsProvider).resolveAccNumService(
                    //       context: context,
                    //       bankName: selectedBankName.toString(),
                    //       accountNumber: widget
                    //           .transferController.agtTrasferAccountNumber.text);
                    //   await AgentPreference.setAccountNumber(
                    //       widget.transferController.agtTrasferAccountNumber.text);
                    //   await AgentPreference.setBankName(
                    //       selectedBankName.toString());
                    // }
                  },
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const SizedBox(height: 10),
                //     Container(
                //       width: 238,
                //       height: 31,
                //       padding: const EdgeInsets.only(left: 16, top: 7),
                //       color: kPrimary.withOpacity(0.2),
                //       child: Text(
                //         '${AgentPreference.getAccountName()}',
                //         style: AppStyleGilroy.kFontW7
                //             .copyWith(fontSize: 12, color: kPrimary),
                //         // child: bankDetails.when(
                //         //     data: (data) {
                //         //       return Text(
                //         //         data.data.data.accountName,
                //         //         style: AppStyleGilroy.kFontW7
                //         //             .copyWith(fontSize: 12, color: kPrimary),
                //         //       );
                //         //     },
                //         //     loading: () => const Text('Verifying...'),
                //         //     error: (e, s) => Text(e.toString())),
                //       ),
                //     ),
                //     const SizedBox(height: 7),
                //     Consumer(
                //       builder:
                //           (BuildContext context, WidgetRef ref, Widget? child) {
                //         return Row(
                //           children: [
                //             const SizedBox(width: 5),
                //             SizedBox(
                //               width: 11,
                //               height: 11,
                //               child: Checkbox(
                //                 checkColor: kPrimary, // color of tick Mark
                //                 activeColor: kWhite,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(2.0),
                //                 ),
                //                 side: MaterialStateBorderSide.resolveWith(
                //                   (states) => BorderSide(
                //                       width: 1.0,
                //                       color: kPrimary.withOpacity(0.8)),
                //                 ),
                //                 value: ref.watch(agtSaveBeneficiary),
                //                 onChanged: (value) {
                //                   ref.read(agtSaveBeneficiary.notifier).state =
                //                       !ref
                //                           .read(agtSaveBeneficiary.notifier)
                //                           .state;
                //                 },
                //               ),
                //             ),
                //             const SizedBox(width: 6),
                //             Text(
                //               "Save as beneficiary",
                //               style: AppStyleGilroy.kFontW5
                //                   .copyWith(color: kPrimary, fontSize: 14),
                //             ),
                //           ],
                //         );
                //       },
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 27),
                // AbilityTextField(
                //   controller: widget.transferController.agtTransferAmount,
                //   heading: 'Enter Amount',
                //   hintText: 'Enter Amount',
                //   keyboardType: TextInputType.number,
                //   borderRadius: BorderRadius.circular(5),
                // ),
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
                      await ref
                          .read(loadingAgtBankDetail1.notifier)
                          .resolveAccNumService(
                              context: context,
                              bankName: selectedBankName.toString(),
                              accountNumber: widget.transferController
                                  .agtTrasferAccountNumber.text);
                      await AgentPreference.setAccountNumber(widget
                          .transferController.agtTrasferAccountNumber.text);
                      await AgentPreference.setBankName(selectedBankName!);
                    }

                    // print(selectedBankName);
                    // confirmDetailsDialog(
                    //   context: context,
                    //   bankName: 'Guaranty trust bank plc',
                    //   accountNumber: '0099887766',
                    //   accountName: 'Ability Mensor',
                    //   amount: '5000',
                    //   onTap: () {
                    //     PageNavigator(ctx: context).nextPageOnly(
                    //         page: AgtEnterTransferCode(
                    //             ValidationHelper(), TransferController()));
                    //   },
                    // );
                    // PageNavigator(ctx: context)
                    //     .nextPageOnly(page: const AggregatorProfileScreen());
                  },
                  child: !ref.watch(loadingAgtBankDetail1)
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
