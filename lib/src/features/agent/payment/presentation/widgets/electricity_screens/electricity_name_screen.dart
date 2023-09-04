// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/currency_editing_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/electricity_screens/confirm_electricity_dialog.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ElectricityNameScreen extends ConsumerStatefulWidget {
  AgtPaymentController payController;
  final String meterNumber;

  ElectricityNameScreen(this.payController,
      {required this.meterNumber, super.key});

  @override
  ConsumerState<ElectricityNameScreen> createState() =>
      _ElectricityNameScreenState();
}

class _ElectricityNameScreenState extends ConsumerState<ElectricityNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.payController.electricityAmount = CurrencyEditingController(
      initialValue: 0.00,
      onValueChange: (newValue) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const AppHeader(heading: 'Electricity'),
                const SizedBox(height: 94.89),
                AbilityTextField(
                  controller: widget.payController.airtimeAmount,
                  heading: 'Account Name',
                  hintText: '${AgentPreference.getElectAccountName()}',
                  readOnly: true,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.payController.electricityAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
                ),
                const SizedBox(height: 150),
                AbilityButton(
                  height: 60,
                  borderRadius: 10,
                  borderColor:
                      ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                  buttonColor:
                      ref.watch(isEditingProvider) ? kGrey23 : kPrimary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      confirmElectricityDialog(
                        context: context,
                        serviceProvider: ref.watch(selectedElectProvider),
                        amount: int.parse(
                            widget.payController.electricityAmount.text),
                        cableNumber: widget.meterNumber,
                        accountName:
                            AgentPreference.getElectAccountName() ?? '',
                      );
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
