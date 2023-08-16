// ignore_for_file: must_be_immutable

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_airtime_details.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_home_screen_bar.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_trans_history_screen.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/recent_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtHomeScreen extends ConsumerWidget {
  const AgtHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transHistory = ref.watch(getAgtTransHistoryProvider);
    final agtProfile = ref.watch(getAgtProfileProvider);
    return Scaffold(
      backgroundColor: kAsh1,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(getAgtTransHistoryProvider);
          ref.refresh(getAgtProfileProvider);
        },
        child: Column(
          children: [
            const AgtHomeScreenBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 15.84, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent transaction',
                        style: AppStyleGilroy.kFontW6.copyWith(fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const AgtTransactionHistory());
                        },
                        child: Text(
                          'View All',
                          style: AppStyleGilroy.kFontW6
                              .copyWith(fontSize: 12, color: kPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.05),
                  Container(
                    width: double.maxFinite,
                    height: 348,
                    color: kWhite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: transHistory.when(
                      data: (data) {
                        final historyInfo =
                            data.data.transactionHistory.map((e) => e).toList();
                        return historyInfo.isNotEmpty
                            ? ListView.builder(
                                itemCount: historyInfo.length,
                                itemBuilder: (context, index) {
                                  DateTime historyTime =
                                      historyInfo[index].createdAt;
                                  String formattedDate =
                                      DateFormat('MMM dd, hh:mm')
                                          .format(historyTime);
                                  final info = historyInfo[index];
                                  return RecentTransactionTile(
                                    title: convertToUppercase(
                                        info.transactionType),
                                    dateTime: formattedDate,
                                    amount: info.transactionAmount,
                                    status: convertToUppercase(
                                        info.transactionStatus),
                                    onTap: () {
                                      PageNavigator(ctx: context).nextPage(
                                          page: AgtAirtimeDetails(
                                        transType: info.transactionType,
                                        transAmount: info.transactionAmount,
                                        transDateTime: formattedDate,
                                        transStatus: convertToUppercase(
                                            info.transactionStatus),
                                        transNumber: info.transactionId,
                                        transOperator: info.recipientBank,
                                        phoneNumber: info.transactionRecipient,
                                        paidWith: 'Wallet Balance',
                                      ));
                                    },
                                  );
                                },
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('No transaction yet')],
                              );
                      },
                      error: (e, s) => Text(e.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: kPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // AbilityButton(
            //     title: 'Logout',
            //     onPressed: () {
            //       AgentPreference.clearAccessToken().then((value) {
            //         PageNavigator(ctx: context).nextPageOnly(
            //             page: AgentLoginScreen(
            //                 ValidationHelper(), AgentController()));
            //       });
            //     }),
          ],
        ),
      ),
    );
  }
}
