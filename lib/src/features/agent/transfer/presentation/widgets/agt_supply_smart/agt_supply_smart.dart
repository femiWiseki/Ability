// ignore_for_file: unnecessary_null_comparison, must_be_immutable, use_build_context_synchronously

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/currency_editing_controller.dart';
import 'package:ability/src/features/agent/transfer/application/repositories/bank_list.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferToSupplySmart extends ConsumerStatefulWidget {
  TransferController transferController;
  AgtTransferToSupplySmart(this.transferController, {super.key});

  @override
  ConsumerState<AgtTransferToSupplySmart> createState() =>
      _AgtTransferToSupplySmartState();
}

class _AgtTransferToSupplySmartState
    extends ConsumerState<AgtTransferToSupplySmart> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BankListRepo bankListRepo = BankListRepo();

  @override
  void initState() {
    super.initState();
    widget.transferController.agtSupplySmartAmount = CurrencyEditingController(
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
                InkWell(
                    onTap: () {
                      // refreshTokenService();
                      print(AgentPreference.getRefreshedToken());
                    },
                    child:
                        const AppHeader(heading: 'Transfer to Supply Smart')),
                const SizedBox(height: 68.89),
                AbilityTextField(
                  controller: widget.transferController.agtSupplySmartAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.transferController.agtSupplySmartAccNum,
                  heading: 'Enter Phone number',
                  hintText: 'Enter Phone number',
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAccountNumber(value!),
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
                      if (ref.watch(isVerifiedProvider) == true &&
                          ref.watch(isDisabledProvider) == false) {
                        ref
                            .read(transSupplySmartProvider.notifier)
                            .supplySmartService(
                                context: context,
                                amount: int.parse(widget.transferController
                                    .agtSupplySmartAmount.text),
                                accNumber: widget.transferController
                                    .agtSupplySmartAccNum.text);
                        // PageNavigator(ctx: context).nextPage(
                        //     page: AgtSupplySmartCode(
                        //         ValidationHelper(), TransferController()));
                      } else {
                        errorMessage(
                            context: context,
                            message:
                                'This account is not valid. Please, contact support.');
                      }
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
