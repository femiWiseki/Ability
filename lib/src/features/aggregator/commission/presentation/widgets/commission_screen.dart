// ignore_for_file: unused_result

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/recent_transaction_tile.dart';
import 'package:ability/src/features/aggregator/commission/presentation/providers/commission_providers.dart';
import 'package:ability/src/features/aggregator/commission/presentation/widgets/refactor_widgets/commission_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CommissionScreen extends ConsumerWidget {
  const CommissionScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aggCom = ref.watch(getAggCommissionProvider);
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(getAggCommissionProvider);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Commission',
                      style: AppStyleInter.kFontW6.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 50),
                    CommissionCard(aggCom: aggCom),
                    const SizedBox(height: 15.84),
                    Row(
                      children: [
                        Text(
                          'Commission History',
                          style: AppStyleGilroy.kFontW6.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.maxFinite,
                          color: kWhite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 20),
                          child: aggCom.when(
                              data: (data) {
                                return ListView.builder(
                                  itemCount: data.data.commission.length,
                                  itemBuilder: (context, index) {
                                    DateTime historyTime =
                                        data.data.commission[index].createdAt;
                                    String formattedDate =
                                        DateFormat('MMM dd, hh:mm')
                                            .format(historyTime);
                                    final info = data.data.commission[index];
                                    // return const Text('');
                                    return RecentTransactionTile(
                                      amount: info.amount.toString(),
                                      title: info.commissionType,
                                      dateTime: formattedDate,
                                      status: info.aggregatorId,
                                      statusColor: kBlack,
                                      icon: Icons.keyboard_arrow_down_rounded,
                                      iconColor: kPrimary,
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) {
                                errorMessage(
                                    context: context,
                                    message: error.toString());
                                return null;
                              },
                              loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
