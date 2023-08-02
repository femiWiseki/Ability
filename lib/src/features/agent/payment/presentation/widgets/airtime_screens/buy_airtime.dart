// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/authentication/presentation/providers/authentication_provider.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/airtime_screens/confirm_airtime_dialog.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuyAirtime extends ConsumerStatefulWidget {
  AgtPaymentController payController;

  BuyAirtime(this.payController, {super.key});

  @override
  ConsumerState<BuyAirtime> createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends ConsumerState<BuyAirtime> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedNetwork;

  List<String> networkList = [
    'MTN',
    '9Mobile',
    'Airtel',
    'Glo',
  ];

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
                const AppHeader(heading: 'Buy Airtime'),
                const SizedBox(height: 94.89),
                TextFieldContainer(
                  height: 50,
                  header: 'Network Provider',
                  borderRadius: 5,
                  onTap: () {},
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Network Provider',
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 14, color: kGrey),
                      ),
                      items: networkList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppStyleRoboto.kFontW4
                                      .copyWith(fontSize: 14, color: kBlack),
                                ),
                              ))
                          .toList(),
                      value: selectedNetwork,
                      onChanged: (value) {
                        setState(() {
                          selectedNetwork = value as String;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                GeneralTextField(
                  controller: widget.payController.airtimePhoneNumber,
                  heading: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validatePhoneNumber(value!),
                ),
                const SizedBox(height: 27),
                AbilityTextField(
                  controller: widget.payController.airtimeAmount,
                  heading: 'Enter Amount',
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validateAmount(value!),
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
                      confirmAirtimeDialog(
                        context: context,
                        billsPayment: 'Airtime Purchase',
                        networkProvider: selectedNetwork.toString(),
                        amount:
                            int.parse(widget.payController.airtimeAmount.text),
                        customerNum: widget
                            .payController.airtimePhoneNumber.text
                            .substring(1),
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
