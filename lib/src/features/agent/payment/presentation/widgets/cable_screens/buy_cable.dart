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
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/data_screens/confirm_data_dialog.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/data_screens/data_service_bsheet.dart';
import 'package:ability/src/features/agent/transfer/presentation/providers/transfer_providers.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class BuyCableScreen extends ConsumerStatefulWidget {
  AgtPaymentController payController;

  BuyCableScreen(this.payController, {super.key});

  @override
  ConsumerState<BuyCableScreen> createState() => _BuyCableScreenState();
}

class _BuyCableScreenState extends ConsumerState<BuyCableScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isDataPlanOptionsLoaded = false;
  String? selectedNetwork;
  // String? selectedDataPlan;

  final List<Map<String, dynamic>> billers = [
    {
      'image': 'assets/icons/mtn.png',
      'text': 'DSTV',
    },
    {
      'image': 'assets/icons/9mobile.png',
      'text': 'GOTV',
    },
    {
      'image': 'assets/icons/airtel.png',
      'text': 'AIRTEL',
    },
    {
      'image': 'assets/icons/glo.png',
      'text': 'GLO',
    },
  ];

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
                const AppHeader(heading: 'Buy Cable'),
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
                      items: billers
                          .map((item) => DropdownMenuItem<String>(
                                value: item['text'],
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(item['image'])),
                                    const SizedBox(width: 10),
                                    Text(
                                      item['text'],
                                      style: AppStyleRoboto.kFontW4.copyWith(
                                          fontSize: 14, color: kBlack),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      value: selectedNetwork,
                      onChanged: (value) async {
                        setState(() {
                          selectedNetwork = value as String;
                        });

                        await AgentPreference.setDataNetwork(
                            selectedNetwork.toString());

                        // ref.read(selectedDataNetwork.notifier).state =
                        //     selectedNetwork.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                GeneralTextField(
                  controller: widget.payController.dataPhoneNumber,
                  heading: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validatePhoneNumber(value!),
                ),
                const SizedBox(height: 27),
                TextFieldContainer(
                  height: 50,
                  header: 'Data Plan',
                  borderRadius: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () {
                    dataServiceBottomSheet(
                      context: context,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(selectedDataPlan).isEmpty
                            ? 'Select Data Plan'
                            : ref.watch(selectedDataPlan),
                        style: AppStyleRoboto.kFontW4
                            .copyWith(fontSize: 14, color: kBlack),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: kGrey,
                        weight: 2,
                        size: 30,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 27),
                TextFieldContainer(
                  height: 50,
                  header: 'Amount',
                  borderRadius: 5,
                  onTap: () {},
                  child: Center(
                    child: Text(
                      ref.watch(selectedDataAmount).isEmpty
                          ? '₦0.00'
                          : NumberFormat.currency(
                                  locale: 'en_NG',
                                  decimalDigits: 2,
                                  symbol: '₦')
                              .format(int.parse(ref
                                  .watch(selectedDataAmount.notifier)
                                  .state)),
                      style: AppStyleRoboto.kFontW5
                          .copyWith(fontSize: 25, color: kBlack2),
                    ),
                  ),
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
                      print(AgentPreference.getDataNetwork());
                      final dataAmount =
                          int.parse(ref.watch(selectedDataAmount)).isNaN
                              ? 0
                              : int.parse(ref.watch(selectedDataAmount));

                      confirmDataDialog(
                        context: context,
                        dataPlan: ref.watch(selectedDataPlanName),
                        networkProvider: selectedNetwork.toString(),
                        amount: dataAmount,
                        customerNum: widget.payController.dataPhoneNumber.text
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
