// ignore_for_file: unnecessary_null_comparison

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/common_widgets/text_field_container.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/profile/presentation/widgets/agent_profile/agt_refactored_widgets/format_alert_dialog.dart';
import 'package:ability/src/features/aggregator/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtAccountStatement extends ConsumerStatefulWidget {
  const AgtAccountStatement({super.key});

  @override
  ConsumerState<AgtAccountStatement> createState() =>
      _AgtAccountStatementState();
}

class _AgtAccountStatementState extends ConsumerState<AgtAccountStatement> {
  DateTime _selectedDate = DateTime(0);

  DateTime _selectedDate2 = DateTime(0);

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final fileFormat = ref.watch(fileFormatterProvider);

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
                    _selectedDate.year == 0
                        ? 'DD/MM/YYYY'
                        : _dateFormat.format(_selectedDate),
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
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
                    _selectedDate2.year == 0
                        ? 'DD/MM/YYYY'
                        : _dateFormat.format(_selectedDate2),
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
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
                    fileFormat.isNotEmpty ? fileFormat : 'File Format',
                    style: AppStyleGilroy.kFontW6
                        .copyWith(fontSize: 14, color: kBlack50),
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined,
                      color: kBlack10),
                ],
              ),
            ),
            const SizedBox(height: 88),
            AbilityButton(
              onPressed: () {
                if (_selectedDate.year == 0 ||
                    _selectedDate2.year == 0 ||
                    fileFormat.isEmpty) {
                  errorMessage(
                      context: context, message: 'All fields must be filled');
                } else {
                  // PageNavigator(ctx: context)
                  //     .nextPageOnly(page: const AggregatorProfileScreen());
                }
              },
              height: 60,
              buttonColor: fileFormat.isEmpty ? kGrey23 : kPrimary,
              borderColor: fileFormat.isEmpty ? kGrey23 : kPrimary,
              borderRadius: 10,
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.year == 0 ? currentDate : _selectedDate,
      firstDate: DateTime(2000),
      lastDate: currentDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showDatePicker2(BuildContext context) async {
    final DateTime currentDate2 = DateTime.now();
    final DateTime? picked2 = await showDatePicker(
      context: context,
      initialDate: _selectedDate2.year == 0 ? currentDate2 : _selectedDate2,
      firstDate: DateTime(2000),
      lastDate: currentDate2,
    );

    if (picked2 != null && picked2 != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked2;
      });
    }
  }
}
