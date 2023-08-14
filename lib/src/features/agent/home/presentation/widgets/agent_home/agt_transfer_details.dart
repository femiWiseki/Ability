// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/acc_statemt_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtTransferDetails extends ConsumerWidget {
  final String transType;
  final String transAmount;
  final String transDateTime;
  final String transStatus;
  final String phoneNumber;
  final String transOperator;
  final String transNumber;
  final String paidWith;
  const AgtTransferDetails(
      {required this.transType,
      required this.transAmount,
      required this.transDateTime,
      required this.transStatus,
      required this.phoneNumber,
      required this.transOperator,
      required this.transNumber,
      required this.paidWith,
      super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 37, 24, 0),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(heading: 'Transaction History'),
              const SizedBox(height: 37.11),
              Container(
                height: 450,
                width: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25), color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(19, 31, 19, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 97.6,
                            height: 34.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 34.1,
                                  width: 32.8,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimary.withOpacity(0.1)),
                                  child: const Icon(
                                    Icons.arrow_upward_rounded,
                                    color: customColor2,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  convertToUppercase(transType),
                                  style: AppStyleGilroy.kFontW5
                                      .copyWith(fontSize: 15.86),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                NumberFormat.currency(
                                        locale: 'en_NG',
                                        decimalDigits: 2,
                                        symbol: '₦')
                                    .format(double.parse(transAmount)),
                                style: AppStyleRoboto.kFontW6
                                    .copyWith(fontSize: 18.25),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transDateTime,
                                style: AppStyleGilroy.kFontW5
                                    .copyWith(fontSize: 10, color: kBlack2),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 26.79),
                      const Divider(
                        thickness: 1,
                        color: kGrey3,
                      ),
                      const SizedBox(height: 17.96),
                      AccStatementTile(
                        prefixText: 'Status',
                        suffixText: transStatus,
                        suffixTextColor: kGreen,
                        suffixTextFontSize: 16,
                      ),
                      AccStatementTile(
                          prefixText: 'Sender', suffixText: paidWith),
                      AccStatementTile(
                          prefixText: 'Bank Name', suffixText: transOperator),
                      AccStatementTile(
                          prefixText: 'Bank Account', suffixText: phoneNumber),
                      AccStatementTile(
                          prefixText: 'Description', suffixText: phoneNumber),
                      const SizedBox(height: 18),
                      const Divider(
                        thickness: 1,
                        color: kGrey3,
                      ),
                      AccStatementTile(
                          prefixText: 'Session ID', suffixText: transNumber),
                      AccStatementTile(
                          prefixText: 'Transaction number',
                          suffixText: transNumber),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 170),
              AbilityButton(title: 'Share Receipt', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
