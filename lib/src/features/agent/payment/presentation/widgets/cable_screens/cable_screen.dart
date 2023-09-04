// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/ability_text_field.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/providers/payment_providers.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/cable_screens/cable_service_bsheet.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/electricity_screens/elect_service_bsheet.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CableScreen extends ConsumerStatefulWidget {
  AgtPaymentController payController;

  CableScreen(this.payController, {super.key});

  @override
  ConsumerState<CableScreen> createState() => _CableScreenState();
}

class _CableScreenState extends ConsumerState<CableScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String hintAmt = '0.000';
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
                const AppHeader(heading: 'Cable'),
                const SizedBox(height: 94.89),
                GeneralTextField(
                  controller: widget.payController.cableNumber,
                  heading: 'Cable Number',
                  hintText: 'Enter Cable Number',
                  // maxLength: 11,
                  keyboardType: TextInputType.phone,
                  borderRadius: BorderRadius.circular(5),
                  validator: (value) =>
                      ValidationHelper().validatePhoneNumber(value!),
                ),
                const SizedBox(height: 27),
                TextFieldContainer(
                  height: 50,
                  header: 'Service Package',
                  borderRadius: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: kPrimary.withOpacity(0.25),
                  onTap: () {
                    cableServiceBottomSheet(
                      context: context,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(selectedCableProvider).isEmpty
                            ? 'Select Service Package'
                            : ref.watch(selectedCableProvider),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: kPrimary.withOpacity(0.25),
                  child: Center(
                    child: Text(
                      ref.watch(selectedCableAmount) == 0
                          ? "₦0.00"
                          : '₦${ref.watch(selectedCableAmount)}',
                      style: AppStyleRoboto.kFontW6
                          .copyWith(fontSize: 25, color: kBlack),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                AbilityButton(
                  height: 60,
                  borderRadius: 10,
                  borderColor: ref.watch(selectedCableProvider).isEmpty
                      ? kGrey23
                      : kPrimary,
                  buttonColor: ref.watch(selectedCableProvider).isEmpty
                      ? kGrey23
                      : kPrimary,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (ref.watch(selectedCableProvider).isEmpty) {
                        errorMessage(
                            context: context,
                            message: 'Please, select a service package');
                      } else {
                        await ref
                            .watch(loadingResolveCable.notifier)
                            .cableService(
                              context: context,
                              serviceProvider: ref.watch(selectedCableProvider),
                              cableNumber:
                                  widget.payController.cableNumber.text,
                            );
                      }
                    }
                  },
                  child: !ref.watch(loadingResolveCable)
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
