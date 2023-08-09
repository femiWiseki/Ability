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
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferToBank extends ConsumerStatefulWidget {
  TransferController transferController;
  AgtTransferToBank(this.transferController, {super.key});

  @override
  ConsumerState<AgtTransferToBank> createState() => _AgtTransferToBankState();
}

class _AgtTransferToBankState extends ConsumerState<AgtTransferToBank> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedBankName;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search bank...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value
                              .toString()
                              .toLowerCase()
                              .contains(searchValue.toLowerCase());
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
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
                  },
                ),

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
