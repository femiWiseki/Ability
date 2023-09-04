import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_airtime_details.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_deposit_details.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_transfer_details.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_withdrawal_history.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/recent_transaction_tile.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/transaction_box.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtTransactionHistory extends ConsumerStatefulWidget {
  const AgtTransactionHistory({super.key});

  @override
  ConsumerState<AgtTransactionHistory> createState() =>
      _AgtTransactionHistoryState();
}

class _AgtTransactionHistoryState extends ConsumerState<AgtTransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final transHistory = ref.watch(getAgtTransHistoryProvider);
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(
            children: [
              AppHeader(
                heading: 'Transaction History',
                suffixIcon: PopupMenuButton<String>(
                  offset: const Offset(-10, 40),
                  // icon: SvgPicture.asset('assets/icons/filter.svg'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'screen1',
                      child: Text('Withdrawal History'),
                    ),
                    // const PopupMenuItem<String>(
                    //   value: 'screen2',
                    //   child: Text('Transaction History'),
                    // ),
                  ],
                  onSelected: (String value) {
                    if (value == 'screen1') {
                      PageNavigator(ctx: context)
                          .nextPage(page: const AgtWithdrawalHistory());
                    }
                    //  else if (value == 'screen2') {
                    //   Future.delayed(Duration(milliseconds: 100), () {
                    //     Navigator.pop(context); // Close the popup menu
                    //   });
                    // }
                  },
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransactionBox(
                    boxColor: customColor2,
                    title: 'Debit',
                    amount: 5000,
                  ),
                  TransactionBox(
                    boxColor: kPrimary,
                    title: 'Credit',
                    amount: 1000,
                  )
                ],
              ),
              const SizedBox(height: 9),
              transHistory.when(
                data: (data) {
                  final historyInfo =
                      data.data.transactionHistory.map((e) => e).toList();
                  return historyInfo.isNotEmpty
                      ? Expanded(
                          child: Container(
                            color: kWhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 20),
                            child: ListView.builder(
                              itemCount: historyInfo.length,
                              itemBuilder: (context, index) {
                                DateTime historyTime =
                                    historyInfo[index].createdAt;
                                String formattedDate =
                                    DateFormat('MMM dd, hh:mm')
                                        .format(historyTime);
                                final info = historyInfo[index];
                                return RecentTransactionTile(
                                  title:
                                      convertToUppercase(info.transactionType),
                                  dateTime: formattedDate,
                                  amount: info.transactionAmount,
                                  icon: info.transactionType == 'transfer' ||
                                          info.transactionType == 'airtime'
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  iconColor:
                                      info.transactionType == 'transfer' ||
                                              info.transactionType == 'airtime'
                                          ? kRed
                                          : kPrimary,
                                  status: convertToUppercase(
                                      info.transactionStatus),
                                  statusColor:
                                      info.transactionStatus == 'success'
                                          ? kGreen
                                          : kRed,
                                  onTap: () {
                                    if (info.transactionGroup == 'pay_bills') {
                                      PageNavigator(ctx: context).nextPage(
                                          page: AgtAirtimeDetails(
                                        transType: info.transactionType,
                                        transAmount: info.transactionAmount,
                                        transDateTime: formattedDate,
                                        transStatus: convertToUppercase(
                                            info.transactionStatus),
                                        transNumber: info.id,
                                        transOperator: info.recipientBank ?? '',
                                        phoneNumber:
                                            info.transactionRecipient ?? '',
                                        paidWith: 'Wallet Balance',
                                      ));
                                    } else if (info.transactionGroup ==
                                        'transfer') {
                                      PageNavigator(ctx: context).nextPage(
                                          page: AgtTransferDetails(
                                        transType: info.transactionType,
                                        transAmount: info.transactionAmount,
                                        transDateTime: formattedDate,
                                        transStatus: convertToUppercase(
                                            info.transactionStatus),
                                        sender:
                                            AgentPreference.getUsername() ?? '',
                                        bankName: info.recipientBank ?? '',
                                        accNumber:
                                            info.recipientAccountNumber ?? '',
                                        accName: info.recipientAccountName,
                                        description:
                                            info.transactionDescription ?? '',
                                        transNumber: info.id,
                                        sessionID: info.sessionId,
                                      ));
                                    } else {
                                      PageNavigator(ctx: context).nextPage(
                                          page: AgtDepositDetails(
                                        transType: info.transactionType,
                                        transAmount: info.transactionAmount,
                                        transDateTime: formattedDate,
                                        transStatus: convertToUppercase(
                                            info.transactionStatus),
                                        sender: '',
                                        bankName: '',
                                        bankAccount: '',
                                        depositType: '',
                                        transNumber: info.id,
                                        sessionId: info.sessionId,
                                      ));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('No transaction yet')],
                        );
                },
                error: (e, s) => const Text(''),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: kWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
