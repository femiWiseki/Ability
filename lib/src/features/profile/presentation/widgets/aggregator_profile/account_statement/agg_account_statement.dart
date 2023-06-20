// ignore_for_file: unnecessary_null_comparison

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/profile/presentation/providers/profile_providers.dart';
import 'package:ability/src/features/profile/presentation/widgets/aggregator_profile/agg_profile_screen.dart';
import 'package:ability/src/features/profile/presentation/widgets/aggregator_profile/agg_refactored_widgets/format_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AggAccountStatement extends ConsumerStatefulWidget {
  const AggAccountStatement({super.key});

  @override
  ConsumerState<AggAccountStatement> createState() =>
      _AggAccountStatementState();
}

class _AggAccountStatementState extends ConsumerState<AggAccountStatement> {
  DateTime _selectedDate = DateTime(0);

  DateTime _selectedDate2 = DateTime(0);

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final fileFormat = ref.watch(fileFormatProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(children: [
            const AppHeader(heading: 'Account Statement'),
            const SizedBox(height: 36.11),
            Text(
              'Choose a timeframe for your statement and select a format you want it in.',
              style: AppStyleGilroy.kFontW6.copyWith(
                fontSize: 12,
                color: kBlack2.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 59),
            TextFieldContainer(
              header: 'Start Date',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                _showDatePicker(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate.toString().isNotEmpty
                        ? _dateFormat.format(_selectedDate)
                        : 'DD/MM/YYYY',
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     _showDatePicker(context);
                  //   },
                  //   child: const Icon(Icons.keyboard_arrow_down_outlined,
                  //       color: kBlack10),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextFieldContainer(
              header: 'End Date',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                _showDatePicker2(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate2.toString().isNotEmpty
                        ? _dateFormat.format(_selectedDate2)
                        : 'DD/MM/YYYY',
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     _showDatePicker(context);
                  //   },
                  //   child: const Icon(Icons.keyboard_arrow_down_outlined,
                  //       color: kBlack10),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextFieldContainer(
              header: 'Format',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                formatDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fileFormat.toString().isNotEmpty
                        ? fileFormat.toString()
                        : 'File Format',
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined,
                      color: kBlack10),
                  // InkWell(
                  //   onTap: () {},
                  //   child: const Icon(Icons.keyboard_arrow_down_outlined,
                  //       color: kBlack10),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 88),
            AbilityButton(
              onPressed: () {
                PageNavigator(ctx: context)
                    .nextPageOnly(page: const AggregatorProfileScreen());
              },
              height: 60,
              buttonColor: kGrey23,
              borderColor: kGrey23,
              borderRadius: 10,
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showDatePicker2(BuildContext context) async {
    final DateTime? picked2 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked2 != null && picked2 != _selectedDate) {
      setState(() {
        _selectedDate2 = picked2;
      });
    }
  }
}
