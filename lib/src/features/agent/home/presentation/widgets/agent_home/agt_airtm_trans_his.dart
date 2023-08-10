// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtAirTransHistory extends ConsumerWidget {
  final String transType;
  final String transAmount;
  final String transDateTime;
  final String transStatus;
  final String phoneNumber;
  final String transOperator;
  final String transNumber;
  final String paidWith;
  const AgtAirTransHistory(
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
        padding: const EdgeInsets.fromLTRB(24, 37, 14, 0),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(heading: 'Transaction History'),
              const SizedBox(height: 37.11),
              Container(
                height: 406,
                width: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25), color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(19, 31, 19, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 97.6,
                            height: 34.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 24.51,
                                  width: 23.61,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimary.withOpacity(0.1)),
                                  child: const Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kPrimary,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  transType,
                                  style: AppStyleGilroy.kFontW5
                                      .copyWith(fontSize: 12.71),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 185),
              AbilityButton(title: 'Share Receipt', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
