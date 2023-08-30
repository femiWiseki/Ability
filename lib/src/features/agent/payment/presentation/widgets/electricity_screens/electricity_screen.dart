// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/electricity_screens/elect_service_bsheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ElectricityScreen extends ConsumerStatefulWidget {
  AgtPaymentController payController;

  ElectricityScreen(this.payController, {super.key});

  @override
  ConsumerState<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends ConsumerState<ElectricityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                GeneralTextField(
                  controller: widget.payController.electricityMeterNumber,
                  heading: 'Meter Number',
                  hintText: 'Enter Meter Number',
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validatePhoneNumber(value!),
                ),
                const SizedBox(height: 27),
                TextFieldContainer(
                  height: 50,
                  header: 'Service Provider',
                  borderRadius: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () {
                    electServiceBottomSheet(
                      context: context,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(selectedElectProvider).isEmpty
                            ? 'Select Service Provider'
                            : ref.watch(selectedElectProvider),
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
                const SizedBox(height: 150),
                AbilityButton(
                  height: 60,
                  borderRadius: 10,
                  borderColor: ref.watch(selectedElectProvider).isEmpty
                      ? kGrey23
                      : kPrimary,
                  buttonColor: ref.watch(selectedElectProvider).isEmpty
                      ? kGrey23
                      : kPrimary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .watch(loadingResolveElectricity.notifier)
                          .electricityService(
                            context: context,
                            serviceProvider: ref.watch(selectedElectProvider),
                            meterNumber: widget
                                .payController.electricityMeterNumber.text,
                          );
                    }
                  },
                  child: !ref.watch(loadingResolveElectricity)
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
