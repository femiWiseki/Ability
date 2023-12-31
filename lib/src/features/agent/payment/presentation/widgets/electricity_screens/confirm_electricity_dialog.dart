import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/cable_screens/cable_passcode.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/data_screens/buy_data_passcode.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/electricity_screens/electricity_passcode.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/refactored_widgets/confirm_details_tile.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

confirmElectricityDialog({
  required BuildContext context,
  required String serviceProvider,
  required int amount,
  required String cableNumber,
  required String accountName,
}) {
  showDialog(
    context: context,
    barrierColor: kAsh1.withOpacity(0.8),
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: SizedBox(
            height: 413,
            width: 345,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 31.21),
                Text(
                  'Confirm Details',
                  style: AppStyleGilroy.kFontW6
                      .copyWith(fontSize: 14, color: kBlack2),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 66,
                  width: 297,
                  padding: const EdgeInsets.all(10),
                  color: kPrimary.withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DISCLAIMER',
                        style: AppStyleGilroy.kFontW6
                            .copyWith(fontSize: 12.24, color: kPrimary),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Confirm the account details are correct before you proceed to avoid mistakes.Successful transfers cannot be reversed.',
                        textAlign: TextAlign.justify,
                        style: AppStyleGilroy.kFontW5
                            .copyWith(fontSize: 10, color: kPrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34.19),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const ConfirmDetailsTile(
                        prefixText: 'Bills payment',
                        suffixText: 'Electricity Subscription',
                      ),
                      ConfirmDetailsTile(
                        prefixText: 'Account Name',
                        suffixText: accountName,
                      ),
                      ConfirmDetailsTile(
                        prefixText: 'Cable Number',
                        suffixText: cableNumber,
                      ),
                      ConfirmDetailsTile(
                        prefixText: 'Service Provider',
                        suffixText: serviceProvider,
                      ),
                      ConfirmDetailsTile(
                        prefixText: 'Amount',
                        suffixText: NumberFormat.currency(
                                locale: 'en_NG', decimalDigits: 2, symbol: '₦')
                            .format(amount),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 41),
                Consumer(
                  builder: (context, ref, child) {
                    return AbilityButton(
                      width: 300,
                      height: 60,
                      borderRadius: 10,
                      borderColor: kPrimary,
                      buttonColor: kPrimary,
                      onPressed: () {
                        PageNavigator(ctx: context).nextPage(
                          page: CablePasscode(
                            ValidationHelper(),
                            AgtPaymentController(),
                            cableNumber: cableNumber,
                            amount: amount,
                            paymentType: serviceProvider,
                            serviceProvider: serviceProvider,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
